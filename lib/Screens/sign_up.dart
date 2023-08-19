import 'package:bank_pick/Screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';

import '../Widget/height.dart';
import '../Widget/small_text.dart';
import '../bloc/autthentication/authentication_bloc.dart';
import '../colors.dart';

//final authBloc = AuthenticationBloc();

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is SignupSuccess) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const SignIn(),
          ));
        }
      },
      child: Scaffold(
        body: Form(
          key: formKey,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: 42.h,
                      height: 42.h,
                      decoration: BoxDecoration(
                        color: AppColor.backBackground,
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 16.w,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 54.h,
                    ),
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 32,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                      'Full Name',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "Poppins",
                          color: AppColor.primaryText),
                    ),
                    TextFormField(
                      controller: nameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator:
                          ValidationBuilder().minLength(3).required().build(),
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
                    Text(
                      'Phone Number',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "Poppins",
                          color: AppColor.primaryText),
                    ),
                    TextFormField(
                      controller: phoneNumberController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: ValidationBuilder()
                          .maxLength(11)
                          .phone()
                          .required()
                          .build(),
                      decoration: InputDecoration(
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColor.primaryText, width: 0)),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColor.primaryText, width: 0)),
                          prefixIcon: Image.asset('assets/Path.png')),
                    ),
                    SizedBox(
                      height: 22.h,
                    ),
                    Text(
                      'Email Address',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "Poppins",
                          color: AppColor.primaryText),
                    ),
                    TextFormField(
                      controller: emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: ValidationBuilder()
                          .email()
                          .maxLength(50)
                          .required()
                          .build(),
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
                      controller: passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator:
                          ValidationBuilder().required().minLength(6).build(),
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
                      if (formKey.currentState!.validate()) {
                        context.read<AuthenticationBloc>().add(EmailSignUpEvent(
                            email: emailController.text,
                            name: nameController.text,
                            phoneNumber: phoneNumberController.text,
                            password: passwordController.text));
                          
                      }
                    }, child:
                        BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      //  bloc: authBloc,
                      builder: (context, state) {
                        return Container(
                          width: 335.w,
                          height: 56.h,
                          decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(16.r)),
                          child: Center(
                            child: state is AuthenticationLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    'Sign Up',
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
                        SmallText(text: "Already have an account."),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const SignIn(),
                            ));
                          },
                          child: const Text(
                            'Sign In',
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
    );
  }
}
