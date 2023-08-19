import 'package:bank_pick/Widget/button.dart';
import 'package:bank_pick/Widget/details.dart';
import 'package:bank_pick/Widget/header_row.dart';
import 'package:bank_pick/Widget/height.dart';
import 'package:bank_pick/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../bloc/user/user_bloc.dart';

class TransactionReceipt extends StatefulWidget {
  final String name;
  final String email;
  final num amount;
  final String description;
  final DateTime? transactionTime;
  final String? type;
  const TransactionReceipt({
    super.key,
    required this.amount,
    required this.description,
    required this.email,
    required this.name,
    required this.transactionTime,
    required this.type,
  });

  @override
  State<TransactionReceipt> createState() => _TransactionReceiptState();
}

class _TransactionReceiptState extends State<TransactionReceipt> {
  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formattedDate = formatter.format(dateTime);

    final DateFormat timeFormatter = DateFormat('h:mma');
    final String formattedTime = timeFormatter.format(dateTime);

    return '$formattedDate at $formattedTime';
  }

  late String userEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 10.h, right: 20.w, left: 20.w),
        child: SingleChildScrollView(
          child: SafeArea(
            child: SizedBox(
              height: 812.h,
              width: 375.w,
              child: Stack(
                children: [
                  const HeaderRow(
                      leading: Icons.arrow_back_ios,
                      text: 'Transaction',
                      trailing: Icons.share),

                  // Background image

                  // Watermark
                  Opacity(
                    opacity: 0.3,
                    child: Transform.rotate(
                      angle:
                          -0.5, // Rotation angle in radians (-0.5 radians is approximately -28.65 degrees)
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/splash.png',
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                  ),
                  Positioned(top: 30.h, child: const Divider()),
                  // Your content widgets
                  Positioned(
                    top: 70.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Height(height: 12.h),
                        Padding(
                          padding: EdgeInsets.only(left: 80.w),
                          child: Column(
                            children: [
                              Container(
                                height: 60.h,
                                width: 60.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.r),
                                    color: const Color.fromARGB(
                                        255, 211, 234, 213)),
                                child: UnconstrainedBox(
                                  child: Container(
                                    height: 30.h,
                                    width: 30.h,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        color: const Color.fromARGB(
                                            255, 79, 158, 114)),
                                    child: const Center(
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Height(height: 15.h),
                              Text(
                                'Payment Success',
                                style: TextStyle(fontSize: 22.sp),
                              ),
                              Height(height: 10.h),
                              Text(
                                '\$${widget.amount.toString()}',
                                style: TextStyle(
                                    fontSize: 26.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins'),
                              )
                            ],
                          ),
                        ),
                        Height(height: 32.h),
                        Container(
                          height: 0.5.h,
                          width: double.maxFinite,
                          decoration: const BoxDecoration(color: Colors.grey),
                        ),
                        Height(height: 20.h),
                        SizedBox(
                          height: 380.h,
                          width: 335.w,
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.type == 'debit' ? 'To' : 'From',
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        color: AppColor.primaryText),
                                  ),
                                  BlocBuilder<UserBloc, UserState>(
                                    builder: (context, state) {
                                      if (state is UserLoaded) {
                                        return Text(
                                          widget.type == 'Debit'
                                              ? state.userEmail
                                              : widget.email,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontFamily: 'Poppins'),
                                        );
                                      }
                                      return Container();
                                    },
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                child: Container(
                                  height: 0.5.h,
                                  width: double.maxFinite,
                                  decoration:
                                      const BoxDecoration(color: Colors.grey),
                                ),
                              ),
                              Details(
                                  leadng: 'Payment Time',
                                  trailing:
                                      formatDateTime(widget.transactionTime!)),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                child: Container(
                                  height: 0.5.h,
                                  width: double.maxFinite,
                                  decoration:
                                      const BoxDecoration(color: Colors.grey),
                                ),
                              ),
                              Details(
                                  leadng: 'Payment Method',
                                  trailing: 'Bank Transfer'),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                child: Container(
                                  height: 0.5.h,
                                  width: double.maxFinite,
                                  decoration:
                                      const BoxDecoration(color: Colors.grey),
                                ),
                              ),
                              Details(
                                  leadng: 'Payment Type',
                                  trailing: widget.type!),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                child: Container(
                                  height: 0.5.h,
                                  width: double.maxFinite,
                                  decoration:
                                      const BoxDecoration(color: Colors.grey),
                                ),
                              ),
                              Details(
                                  leadng: 'Description',
                                  trailing: widget.description),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                child: Container(
                                  height: 0.5.h,
                                  width: double.maxFinite,
                                  decoration:
                                      const BoxDecoration(color: Colors.grey),
                                ),
                              ),
                              Details(
                                  leadng: widget.type == 'debit'
                                      ? 'Receiver Name'
                                      : 'Sender Name',
                                  trailing: widget.name),
                            ],
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Button(text: 'Close'))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
