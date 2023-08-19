import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors.dart';

class Details extends StatefulWidget {
 final String leadng;
  final String trailing;
  Details({
    required this.leadng,
    required this.trailing,
    super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.leadng,
          style: TextStyle(fontSize: 18.sp, color: AppColor.primaryText),
        ),
        Text(
          widget.trailing,
          style: TextStyle(fontSize: 16.sp, fontFamily: 'Poppins'),
        )
      ],
    );
  }
}
