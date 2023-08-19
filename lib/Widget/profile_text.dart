import 'package:bank_pick/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Light extends StatelessWidget {
  String text;
  Light({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 14.sp, color: AppColor.primaryText, fontFamily: "Poppins"),
    );
  }
}
