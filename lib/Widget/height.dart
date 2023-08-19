import 'package:flutter/material.dart';

class Height extends StatelessWidget {
  double height;
  Height({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

Widget Width(double width) {
  return SizedBox(
    width: width,
  );
}
