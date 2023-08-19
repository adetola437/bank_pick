import 'package:bank_pick/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'height.dart';

class SendTo extends StatelessWidget {
  // final Widget widget;
  final String initials;
  final String text;
  const SendTo({
    required this.initials,
    required this.text,
    //required this.widget,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // text == 'Add'
          //     ? Container(
          //         height: 48.h,
          //         width: 48.w,
          //         decoration: BoxDecoration(
          //             border: Border.all(color: Colors.blue),
          //             borderRadius: BorderRadius.circular(50.r)),
          //         child: widget)
          Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                  color: AppColor.primaryText,
                  borderRadius: BorderRadius.circular(50.r)),
              child: Center(
                child: Text(
                  initials,
                  style: const TextStyle(
                      fontSize: 26,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                ),
              )),
          Height(height: 6.h),
          SizedBox(
              width: 42.w,
              child: Text(
                text,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
              ))
        ],
      ),
    );
  }
}
