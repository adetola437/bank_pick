import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors.dart';

class SmallText extends StatelessWidget {
  String text;
  SmallText({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 14.sp, fontFamily: "Poppins", color: AppColor.primaryText),
    );
  }
}