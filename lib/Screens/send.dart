import 'dart:developer';

import 'package:bank_pick/Model/beneficiary.dart';
import 'package:bank_pick/Widget/header_row.dart';
import 'package:bank_pick/Widget/light_text.dart';
import 'package:bank_pick/Widget/send_to.dart';
import 'package:bank_pick/Widget/sucess_sheet.dart';
import 'package:bank_pick/bloc/transaction/transaction_bloc.dart';
import 'package:bank_pick/bloc/user/user_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_validator/form_validator.dart';

import '../Widget/height.dart';
import '../bloc/beneficiary/beneficiary_bloc.dart';
import '../colors.dart';

class Send extends StatefulWidget {
  const Send({super.key});

  @override
  State<Send> createState() => _SendState();
}

class _SendState extends State<Send> {
  final TextEditingController _pinController = TextEditingController();
  String pin = '';
  int trials = 3;

  void _addDigit(String digit) {
    setState(() {
      if (_pinController.text.length < 4) {
        _pinController.text += digit;
      }
    });
  }

  void _removeDigit() {
    setState(() {
      if (_pinController.text.isNotEmpty) {
        _pinController.text =
            _pinController.text.substring(0, _pinController.text.length - 1);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _priceController.text = '0.00';
  }

  void _enterPin() {
    // String pin = _pinController.text;
    showDialog(
        context: context,
        barrierDismissible: true,
        //animationType: DialogTransitionType.slideFromBottomFade,
        //duration: const Duration(milliseconds: 500),
        // curve: Curves.easeInOut,
        builder: (BuildContext context) {
          return BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoaded) {
                return AlertDialog(
                    title: const Text('Enter Pin'),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // Validate the entered PIN and perform necessary actions
                          if (num.parse(_pinController.text) ==
                              state.user.pin) {
                            num? userBalance =
                                context.read<UserBloc>().state.getBalance;
                            String? userEmail =
                                context.read<UserBloc>().state.userEmail;
                            if (userBalance != null) {
                              context.read<TransactionBloc>().add(
                                  InitiateTransactionEvent(
                                      userEmail: userEmail!,
                                      senderBalance: userBalance,
                                      amount: num.parse(_priceController.text),
                                      description: _descriptionController.text,
                                      email: _emailController.text));
                            }
                          } else {
                            _pinController.clear();
                            setState(() {
                              if (trials >= 0) {
                                trials -= 1;
                              }
                            });
                            Fluttertoast.showToast(
                                msg:
                                    'Incorrect Password, you have $trials trials left');
                          }
                        },
                        child: const Text('Submit'),
                      ),
                      Width(70.w),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // Validate the entered PIN and perform necessary actions
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                    content: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 300.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: _pinController,
                            onChanged: (value) => pin = value,
                            obscureText: true,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 20.sp),
                            decoration: const InputDecoration(
                              hintText: 'PIN',
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Height(height: 20.h),
                                SizedBox(
                                  width: 200.w,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _buildPinDigitButton('1'),
                                      _buildPinDigitButton('2'),
                                      _buildPinDigitButton('3'),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                SizedBox(
                                  width: 200,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _buildPinDigitButton('4'),
                                      _buildPinDigitButton('5'),
                                      _buildPinDigitButton('6'),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                SizedBox(
                                  width: 200,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _buildPinDigitButton('7'),
                                      _buildPinDigitButton('8'),
                                      _buildPinDigitButton('9'),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                SizedBox(
                                  width: 200,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Width(50.w),
                                      _buildPinDigitButton('0'),
                                      _buildPinDigitButton('',
                                          icon: Icons.backspace),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ));
              }
              return Container();
            },
          );
        });
  }

  String name = '';
  bool _isSearching = false;

  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // List<Beneficiary> send = [
  //   Beneficiary(email: 'add@gmail.com', initials: 'OA', name: 'Tayo')
  // ];

  Future<void> _searchName() async {
    setState(() {
      _isSearching = true;
    });
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: _emailController.text)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final List<QueryDocumentSnapshot> document = snapshot.docs;
      for (final doc in document) {
        final String userId = doc.id;
        final DocumentReference userRef =
            FirebaseFirestore.instance.collection('users').doc(userId);

        // Get the existing balance from the document
        final DocumentSnapshot userSnapshot = await userRef.get();
        setState(() {
          name = userSnapshot.get('name');
          log(name);

          _isSearching = false;
        });
      }
    } else {
      setState(() {
        name = 'User Does not exists';
        _isSearching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Height(height: 10.h),
                const HeaderRow(
                    leading: Icons.arrow_back_ios,
                    text: 'Send',
                    trailing: Icons.home),
                Height(height: 20.h),
                Text(
                  'Email Address',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: "Poppins",
                      color: AppColor.primaryText),
                ),
                TextFormField(
                  validator: ValidationBuilder().required().email().build(),
                  onChanged: (value) {
                    // Reset the name when email is changed
                    setState(() {
                      name = '';
                    });
                  },
                  // onFieldSubmitted: (value) {
                  //   // Trigger name search when the text field is submitted
                  //   _searchName();
                  // },
                  controller: _emailController,
                  decoration: InputDecoration(
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColor.primaryText, width: 0)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColor.primaryText, width: 0)),
                      prefixIcon: Image.asset('assets/person.png')),
                ),
                const SizedBox(height: 8),
                _isSearching
                    ? const CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      )
                    : Text(name.isNotEmpty ? ' $name' : ''),
                Height(height: 22.h),
                Text(
                  'Description',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: "Poppins",
                      color: AppColor.primaryText),
                ),
                TextFormField(
                  validator:
                      ValidationBuilder().required().maxLength(30).build(),
                  onTap: () {
                    _searchName();
                  },
                  controller: _descriptionController,
                  decoration: InputDecoration(
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColor.primaryText, width: 0)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColor.primaryText, width: 0)),
                      prefixIcon: Image.asset('assets/Path.png')),
                ),
                Height(height: 32.h),
                Container(
                  height: 140.h,
                  width: 335.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.primaryText),
                      borderRadius: BorderRadius.circular(25.r)),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LightText(text: 'Send To'),
                            Height(height: 13.h),
                            SizedBox(
                              height: 84.h,
                              width: 335.w,
                              child: BlocBuilder<BeneficiaryBloc,
                                  BeneficiaryState>(
                                builder: (context, state) {
                                  if (state is BeneficiarySuccessful) {
                                    List<Beneficiary> send = state.beneficiary;
                                    return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: send.length,
                                        itemBuilder: (ctx, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _emailController.text =
                                                    send[index].email;
                                              });
                                            },
                                            child: SendTo(
                                              text: send[index].name,
                                              initials: send[index].initials,
                                            ),
                                          );
                                        });
                                  }
                                  return Container();
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Height(height: 32.h),
                Container(
                  height: 116.h,
                  width: 335.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.primaryText),
                      borderRadius: BorderRadius.circular(25.r)),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 25.h),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Enter Your Amount',
                              style: TextStyle(color: AppColor.primaryText),
                            ),
                            Text(
                              'Change Currency?',
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                        Height(height: 13.h),
                        Row(
                          children: [
                            Text(
                              'USD',
                              style: TextStyle(
                                  color: AppColor.transaction, fontSize: 24.sp),
                            ),
                            Width(16.w),
                            Padding(
                              padding: EdgeInsets.only(top: 12.00.h),
                              child: SizedBox(
                                height: 24.h,
                                width: 200.sp,
                                child: TextFormField(
                                  controller: _priceController,
                                  style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold),
                                  decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white))),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Height(height: 110.h),
                BlocListener<TransactionBloc, TransactionState>(
                  listener: (context, state) {
                    if (state is TransactionSuccessful) {
                      print("Transaction successful");
                      context.read<UserBloc>().add(GetUserEvent());
                      showTransactionSuccessBottomSheet(context);
                    }
                    if (state is TransactionError) {
                      Fluttertoast.showToast(msg: state.error);
                    }
                  },
                  child: GestureDetector(onTap: () async {
                    if (formKey.currentState!.validate()) {
                      _enterPin();
                      // num? userBalance =
                      //     context.read<UserBloc>().state.getBalance;
                      // String? userEmail =
                      //     context.read<UserBloc>().state.userEmail;
                      // if (userBalance != null) {
                      //   context.read<TransactionBloc>().add(
                      //       InitiateTransactionEvent(
                      //           userEmail: userEmail!,
                      //           senderBalance: userBalance,
                      //           amount: num.parse(_priceController.text),
                      //           description: _descriptionController.text,
                      //           email: _emailController.text));
                      // }
                    }
                  }, child: BlocBuilder<TransactionBloc, TransactionState>(
                    builder: (context, state) {
                      return Container(
                        width: 335.w,
                        height: 56.h,
                        decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(16.r)),
                        child: state is TransactionLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Center(
                                child: Text(
                                  'Send Money',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                      );
                    },
                  )),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget _buildPinDigitButton(String digit, {IconData? icon}) {
    final isBackspace = icon == Icons.backspace;
    const textStyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
    return InkWell(
      onTap: isBackspace ? _removeDigit : () => _addDigit(digit),
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: isBackspace ? Colors.red : Colors.blue,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: icon != null
              ? Icon(
                  icon,
                  color: Colors.white,
                )
              : Text(
                  digit,
                  style: textStyle.copyWith(color: Colors.white),
                ),
        ),
      ),
    );
  }
}
