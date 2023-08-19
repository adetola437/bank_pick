import 'dart:developer';

import 'package:bank_pick/Widget/header_row.dart';
import 'package:bank_pick/Widget/height.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';

import '../Widget/sucess_sheet.dart';
import '../bloc/request/request_bloc.dart';
import '../colors.dart';

class Request extends StatefulWidget {
  const Request({super.key});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController _dayController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  DateTime? _selectedDate;
  @override
  void initState() {
    super.initState();
    _dayController = TextEditingController();
    _priceController.text = '0.00';
  }

  @override
  void dispose() {
    _dayController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dayController.text = picked.day.toString();
        _monthController.text = picked.month.toString();
        _yearController.text = picked.year.toString();
      });
    }
  }

  String name = '';
  bool _isSearching = false;
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
          _nameController.text = userSnapshot.get('name');
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
        child: BlocListener<RequestBloc, RequestState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is RequestSuccessful) {
              showTransactionSuccessBottomSheet(context);
            }
          },
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
                      text: 'Request Money',
                      trailing: Icons.home),
                  Height(height: 32.h),
                  Text(
                    'Email Address',
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "Poppins",
                        color: AppColor.primaryText),
                  ),
                  TextFormField(
                    controller: _emailController,
                    validator: ValidationBuilder().required().email().build(),
                    decoration: InputDecoration(
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColor.primaryText, width: 0)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColor.primaryText, width: 0)),
                        prefixIcon: Image.asset('assets/person.png')),
                  ),
                  Height(height: 22.h),
                  Text(
                    'Payer Name',
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "Poppins",
                        color: AppColor.primaryText),
                  ),
                  TextFormField(
                    onTap: () {
                      _searchName();
                    },
                    validator: ValidationBuilder().required().build(),
                    controller: _nameController,
                    decoration: InputDecoration(
                        suffixIcon: _isSearching
                            ? AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                width: 20.0,
                                height: 20.0,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [Colors.blue, Colors.purple],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                ),
                              )
                            : null,
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColor.primaryText, width: 0)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColor.primaryText, width: 0)),
                        prefixIcon: Image.asset('assets/person.png')),
                  ),
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
                        ValidationBuilder().required().maxLength(20).build(),
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
                  Height(height: 22.h),
                  // Text(
                  //   'Month Due By',
                  //   style: TextStyle(
                  //       fontSize: 14.sp,
                  //       fontFamily: "Poppins",
                  //       color: AppColor.primaryText),
                  // ),
                  // Height(height: 10.h),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     SizedBox(
                  //       width: 82.w,
                  //       height: 24.h,
                  //       child: TextFormField(
                  //         controller: _dayController,
                  //         readOnly: true,
                  //         onTap: () => _selectDate(context),
                  //         decoration: const InputDecoration(
                  //           suffixIcon: Icon(Icons.arrow_drop_down),
                  //           enabledBorder: UnderlineInputBorder(
                  //               borderSide: BorderSide(
                  //                   color: AppColor.primaryText, width: 0)),
                  //           focusedBorder: UnderlineInputBorder(
                  //               borderSide: BorderSide(
                  //                   color: AppColor.primaryText, width: 0)),
                  //           //  labelText: 'Day',
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 82.w,
                  //       height: 24.h,
                  //       child: TextFormField(
                  //         controller: _monthController,
                  //         readOnly: true,
                  //         onTap: () => {},
                  //         decoration: const InputDecoration(
                  //           enabledBorder: UnderlineInputBorder(
                  //               borderSide: BorderSide(
                  //                   color: AppColor.primaryText, width: 0)),
                  //           focusedBorder: UnderlineInputBorder(
                  //               borderSide: BorderSide(
                  //                   color: AppColor.primaryText, width: 0)),
                  //           //  labelText: 'Day',
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 82.w,
                  //       height: 24.h,
                  //       child: TextFormField(
                  //         controller: _yearController,
                  //         readOnly: true,
                  //         onTap: () => {},
                  //         decoration: const InputDecoration(
                  //           enabledBorder: UnderlineInputBorder(
                  //               borderSide: BorderSide(
                  //                   color: AppColor.primaryText, width: 0)),
                  //           focusedBorder: UnderlineInputBorder(
                  //               borderSide: BorderSide(
                  //                   color: AppColor.primaryText, width: 0)),
                  //           //  labelText: 'Day',
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  Height(height: 22.h),
                  Container(
                    height: 116.h,
                    width: 335.w,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColor.primaryText),
                        borderRadius: BorderRadius.circular(25.r)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 25.h),
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
                                    color: AppColor.transaction,
                                    fontSize: 24.sp),
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
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white))),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Height(height: 166.h),
                  BlocBuilder<RequestBloc, RequestState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            context.read<RequestBloc>().add(SaveRequestEvent(
                                amount: num.parse(_priceController.text),
                                description: _descriptionController.text,
                                email: _emailController.text,
                                name: _nameController.text));
                          }
                        },
                        child: Container(
                          width: 335.w,
                          height: 56.h,
                          decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(16.r)),
                          child: state is RequestLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    'Request',
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
