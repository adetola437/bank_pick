import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoldText extends StatelessWidget {
  String text;
  BoldText({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 14.sp, fontWeight: FontWeight.bold, fontFamily: "Poppins"),
    );
  }
}
