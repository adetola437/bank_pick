import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../colors.dart';
import 'height.dart';

class Transaction extends StatelessWidget {
  String image;
  String title;
  String subTitle;
  double price;
  String tranType;
  Transaction({
    required this.image,
    required this.price,
    required this.subTitle,
    required this.title,
    required this.tranType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: Row(
            children: [
              Container(
                width: 42.h,
                height: 42.h,
                decoration: BoxDecoration(
                  color: AppColor.backBackground,
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Center(child: SvgPicture.asset(image)),
              ),
              Width(17.w),
              Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontFamily: "Poppins", fontSize: 16),
                  ),
                  Height(height: 6.h),
                  Text(
                    subTitle,
                    style:
                        TextStyle(color: AppColor.primaryText, fontSize: 12.sp),
                  )
                ],
              )
            ],
          ),
        ),
        tranType == "Debit"
            ? Text(
                '-\$$price',
                style: TextStyle(fontSize: 16.sp, fontFamily: "Poppins"),
              )
            : Text(
                '\$$price',
                style: TextStyle(color: AppColor.primaryColor, fontSize: 16.sp),
              )
      ],
    );
  }
}
