import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ATM extends StatefulWidget {
  String numbers;
  ATM({super.key, required this.numbers});

  @override
  State<ATM> createState() => _ATMState();
}

class _ATMState extends State<ATM> {
  @override
  Widget build(BuildContext context) {
    String f1 = widget.numbers.substring(0, 4);
    String f2 = widget.numbers.substring(4, 8);
    String f3 = widget.numbers.substring(8, 12);
    String f4 = widget.numbers.substring(12, 16);
    return SizedBox(
      height: 29.h,
      width: 265.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            f1,
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
          Text(f2, style: const TextStyle(color: Colors.white, fontSize: 24)),
          Text(f3, style: const TextStyle(color: Colors.white, fontSize: 24)),
          Text(f4, style: const TextStyle(color: Colors.white, fontSize: 24))
        ],
      ),
    );
  }
}
