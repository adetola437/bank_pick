import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'height.dart';

class LanguageSelect extends StatelessWidget {
  String image;
  String language;
  bool visible;
  // Function? onTap;
  LanguageSelect({
    this.visible = false,
    // required this.onTap,
    required this.image,
    required this.language,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 58.h,
          width: 335.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 48.h,
                    width: 48.w,
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Width(16.w),
                  Text(
                    language,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),

              // Width(150.w),
              Visibility(
                  visible: visible,
                  child: Checkbox(value: true, onChanged: (value) {}))
            ],
          ),
        ),
        const Divider()
      ],
    );
  }
}
