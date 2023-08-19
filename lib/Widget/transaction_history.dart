import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors.dart';
import 'height.dart';

class TransactionHistoryWidget extends StatefulWidget {
  final String title;
  final String subtitile;
  final price;

  final String name;
  final String tranType;
  const TransactionHistoryWidget(
      {required this.tranType,
      required this.name,
      required this.price,
      required this.subtitile,
      required this.title,
      super.key});

  @override
  State<TransactionHistoryWidget> createState() =>
      _TransactionHistoryWidgetState();
}

class _TransactionHistoryWidgetState extends State<TransactionHistoryWidget> {
  @override
  Widget build(BuildContext context) {
    String fullName = widget.name;
    List<String> nameParts = fullName.split(' ');

    final String firstName = nameParts[0];
    final String lastName = nameParts.length > 1 ? nameParts[1] : '';
    final String in1 = firstName[0];
    final String in2 = nameParts.length > 1 ? lastName[0] : '';
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
                child: Center(
                    child: Text(
                  (in1 + in2).toUpperCase(),
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                )),
              ),
              Width(17.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(fontFamily: "Poppins", fontSize: 16),
                  ),
                  Height(height: 6.h),
                  Text(
                    widget.subtitile,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(color: AppColor.primaryText, fontSize: 12.sp),
                  )
                ],
              )
            ],
          ),
        ),
        widget.tranType == "debit"
            ? Text(
                '-\$${widget.price}',
                style: TextStyle(fontSize: 16.sp, fontFamily: "Poppins"),
              )
            : Text(
                '\$${widget.price}',
                style: TextStyle(color: AppColor.primaryColor, fontSize: 16.sp),
              )
      ],
    );
  }
}
