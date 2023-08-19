import 'package:bank_pick/Widget/height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../colors.dart';

class ActionContainer extends StatefulWidget {
  final String image;
  final String text;
  ActionContainer({super.key, required this.image, required this.text});

  @override
  State<ActionContainer> createState() => _ActionContainerState();
}

class _ActionContainerState extends State<ActionContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 54.h,
          height: 54.h,
          decoration: BoxDecoration(
            color: AppColor.backBackground,
            borderRadius: BorderRadius.circular(50.r),
          ),
          child: Center(child: SvgPicture.asset(widget.image)),
        ),
        Height(height: 5.h),
        Text(widget.text)
      ],
    );
  }
}
