import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors.dart';
import 'bold_text.dart';

// ignore: must_be_immutable
class SettingsContainer extends StatelessWidget {
  String text;
  SettingsContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BoldText(text: text),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColor.linear,
                  size: 16.w,
                )),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
