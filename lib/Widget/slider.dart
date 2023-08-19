import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Model/slider_model.dart';

class SliderWidget extends StatelessWidget {
  SliderWidget({super.key, required this.slider, this.currentIndex});
  final SliderModel slider;
  int? currentIndex;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: SvgPicture.asset(slider.imagePath!),
        ),
        Text(
          slider.title!,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          slider.description!,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
        )
      ],
    );
  }
}
