import 'package:bank_pick/Screens/pin_login.dart';
import 'package:bank_pick/Screens/sign_up.dart';
import 'package:bank_pick/Widget/height.dart';
import 'package:bank_pick/bloc/user/user_bloc.dart';
import 'package:bank_pick/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';

import '../Widget/nav_container.dart';
import '../Widget/small_text.dart';
import '../bloc/autthentication/authentication_bloc.dart';
import 'home.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController =
      TextEditingController(text: "tola@gmail.com");
  TextEditingController passwordController =
      TextEditingController(text: "password");
  bool _obscureText = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is AuthenticationError) {
            // String error = state.error;
            // Fluttertoast.showToast(msg: error);
          }

          if (state is AuthenticationSuccess) {
            context.read<UserBloc>().add(GetUserEvent());
            // Navigator.of(context).pushAndRemoveUntil(
            //   MaterialPageRoute(builder: (context) => const Home()),
            //   (Route<dynamic> route) => false,
            // );
          }
        },
        child: Form(
          key: formKey,
          child: BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is UserSetPin) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const PinLogin()),
                  (Route<dynamic> route) => false,
                );
              }
              if (state is UserLoaded) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Home()),
                  (Route<dynamic> route) => false,
                );
              }
            },
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      NavContainer(
                        icon: Icons.arrow_back_ios,
                      ),
                      SizedBox(
                        height: 54.h,
                      ),
                      const Text(
                        'Sign In',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 32,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Text(
                        'Email Address',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: "Poppins",
                            color: AppColor.primaryText),
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator:
                            ValidationBuilder().required().email().build(),
                        controller: emailController,
                        decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.primaryText, width: 0)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.primaryText, width: 0)),
                            prefixIcon: Image.asset('assets/email.png')),
                      ),
                      SizedBox(
                        height: 22.h,
                      ),
                      SmallText(
                        text: 'Password',
                      ),
                      TextFormField(
                        validator: ValidationBuilder().required().build(),
                        controller: passwordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.primaryText, width: 0)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.primaryText, width: 0)),
                            prefixIcon: Image.asset('assets/Lock.png'),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(_obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            )),
                      ),
                      Height(height: 40.h),
                      GestureDetector(onTap: () {
                        print('clicked');
                        if (formKey.currentState!.validate()) {
                          context.read<AuthenticationBloc>().add(
                              EmailSignInEvent(
                                  email: emailController.text,
                                  password: passwordController.text));
                        }
                        // Navigator.of(context).pushReplacement(MaterialPageRoute(
                        //   builder: (context) => const Home(),
                        // ));
                      }, child:
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, state) {
                          return Container(
                            width: 335.w,
                            height: 56.h,
                            decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.circular(16.r)),
                            child: state is AuthenticationLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      'Sign In',
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
                      Height(height: 30.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SmallText(text: "I'm a new user."),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => const SignUp(),
                              ));
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
