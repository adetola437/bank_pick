import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Model/slider_model.dart';

class SliderText extends StatefulWidget {
  const SliderText({super.key, required this.slider});
  final SliderModel slider;

  @override
  State<SliderText> createState() => _SliderTextState();
}

class _SliderTextState extends State<SliderText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.slider.title!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          widget.slider.description!,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
