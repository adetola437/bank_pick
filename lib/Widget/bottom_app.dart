import 'package:bank_pick/Widget/height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BottomApp extends StatefulWidget {
  String imageUrl;
  String text;
  Color color;
  BottomApp(
      {super.key,
      required this.imageUrl,
      required this.text,
      required this.color});

  @override
  State<BottomApp> createState() => _BottomAppState();
}

class _BottomAppState extends State<BottomApp> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          widget.imageUrl,
          width: 18.w,
          height: 18.h,
          colorFilter: ColorFilter.mode(
            widget.color, // Set the desired color
            BlendMode.srcIn,
          ),
        ),
        Height(height: 7.h),
        Text(
          widget.text,
          style: TextStyle(color: widget.color),
        )
      ],
    );
  }
}
