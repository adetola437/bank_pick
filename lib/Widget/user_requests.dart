import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors.dart';
import 'height.dart';

class UserRequests extends StatefulWidget {
  String email;
  String name;
  String description;
  DateTime time;
  String status;
  num amount;
  UserRequests(
      {required this.amount,
      required this.description,
      required this.email,
      required this.name,
      required this.status,
      required this.time,
      super.key});

  @override
  State<UserRequests> createState() => _UserRequestsState();
}

class _UserRequestsState extends State<UserRequests> {
  late Color borderColor;
  bool _isExpanded = false;
  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

 // int selected = -1;

  @override
  Widget build(BuildContext context) {
    if (widget.status == 'Accepted') {
      borderColor = Colors.green;
    } else if (widget.status == 'Rejected') {
      borderColor = Colors.red;
    } else {
      borderColor = Colors.yellow;
    }
    String fullName = widget.name;
    List<String> nameParts = fullName.split(' ');

    final String firstName = nameParts[0];
    final String lastName = nameParts.length > 1 ? nameParts[1] : '';
    final String in1 = firstName[0];
    final String in2 = nameParts.length > 1 ? lastName[0] : '';
    return GestureDetector(
      onTap: _toggleExpanded,
      child: AnimatedContainer(
        height: 80.h,
        width: 335.w,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: _isExpanded ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2.0,
              blurRadius: 5.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 42.h,
                    height: 42.h,
                    decoration: BoxDecoration(
                      color: AppColor.backBackground,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Center(
                        child: Text(
                      (in1 + in2).toUpperCase(),
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )),
                  ),
                  Width(17.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.email,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          color: _isExpanded ? Colors.white : Colors.black,
                        ),
                      ),
                      Height(height: 6.h),
                      Text(
                        widget.description,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: _isExpanded
                                ? Colors.white
                                : AppColor.primaryText,
                            fontSize: 12.sp),
                      )
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '\$${widget.amount.toString()}',
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  ),
                  Height(height: 5.h),
                  Container(
                    height: 20.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                        color: borderColor,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: borderColor, width: 3.0)),
                    child: Center(
                      child: Text(
                        widget.status,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
