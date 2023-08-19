import 'package:bank_pick/Widget/button.dart';
import 'package:bank_pick/Widget/height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Model/user.dart';
import '../bloc/user/user_bloc.dart';
import '../colors.dart';
import 'home.dart';

class PinLogin extends StatefulWidget {
  const PinLogin({super.key});

  @override
  State<PinLogin> createState() => _PinLoginState();
}

class _PinLoginState extends State<PinLogin> {
  final TextEditingController _pinController = TextEditingController();
  String pin = '';
  String initialPin = '';
  String finalPin = '';
  bool page = false;

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoaded) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const Home()),
              (Route<dynamic> route) => false,
            );
          }
          if (state is UserLoadingError) {
            Fluttertoast.showToast(msg: 'Couldnt add');
          }
          // TODO: implement listener
        },
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue,
              Colors.green,
            ],
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 80.h,
                ),
                child: SizedBox(
                  height: 50.h,
                  width: 50.h,
                  child: Image.asset('assets/splash.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Hi Oduyomi',
                  style: TextStyle(
                      fontSize: 22.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                page == false ? 'Set Your Transaction Pin' : 'Confirm Your Pin',
                style: TextStyle(fontSize: 16.sp),
              ),
              Height(height: 20.h),
              SizedBox(
                height: 20.h,
                width: 100.w,
                child: TextField(
                  controller: _pinController,
                  onChanged: (value) => pin = value,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 20.sp),
                  decoration: const InputDecoration(
                      //hText: 'PIN',
                      ),
                ),
              ),
              Height(height: 20.h),
              Container(
                decoration: const BoxDecoration(),
                height: 400.h,
                width: double.maxFinite,
                child: Column(
                  children: [
                    Height(height: 50.h),
                    SizedBox(
                      width: 300.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildPinDigitButton('1'),
                          _buildPinDigitButton('2'),
                          _buildPinDigitButton('3'),
                        ],
                      ),
                    ),
                    SizedBox(height: 50.h),
                    SizedBox(
                      width: 300.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildPinDigitButton('4'),
                          _buildPinDigitButton('5'),
                          _buildPinDigitButton('6'),
                        ],
                      ),
                    ),
                    SizedBox(height: 50.h),
                    SizedBox(
                      width: 300.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildPinDigitButton('7'),
                          _buildPinDigitButton('8'),
                          _buildPinDigitButton('9'),
                        ],
                      ),
                    ),
                    SizedBox(height: 50.h),
                    SizedBox(
                      width: 300.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Width(50.w),
                          _buildPinDigitButton('0'),
                          _buildPinDigitButton('', icon: Icons.backspace),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Height(height: 50.h),
              page == false
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          page = !page;
                          print(page);
                          initialPin = _pinController.text;
                          print(initialPin);
                          _pinController.clear();
                        });
                      },
                      child: Button(text: 'Next'))
                  : BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        return GestureDetector(
                            onTap: () {
                              setState(() {
                                print(page);
                                finalPin = _pinController.text;
                                print(finalPin);
                                _pinController.clear();

                                if (initialPin == finalPin) {
                                  if (state is UserSetPin) {
                                    User user = state.user;
                                    user.pin = num.parse(finalPin);
                                    state.user = user;
                                    context
                                        .read<UserBloc>()
                                        .add(AddPinEvent(user: user));
                                  }
                                } else {
                                  page = !page;
                                  Fluttertoast.showToast(
                                      msg: 'Pin Does Not Match');
                                }
                              });
                            },
                            child: Container(
                              width: 335.w,
                              height: 56.h,
                              decoration: BoxDecoration(
                                  color: AppColor.primaryColor,
                                  borderRadius: BorderRadius.circular(16.r)),
                              child: state is UserLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        'Confirm',
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.white,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                            ));
                      },
                    )
            ],
          ),
        ),
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
