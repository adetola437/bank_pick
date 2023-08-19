import 'package:bank_pick/Widget/height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../Widget/atm_number.dart';
import '../Widget/header_row.dart';
import '../Widget/transaction.dart';
import '../colors.dart';

class MyCards extends StatefulWidget {
  const MyCards({super.key});

  @override
  State<MyCards> createState() => _MyCardsState();
}

class _MyCardsState extends State<MyCards> {
  double _value = 50; // Initial value of the slider
  final double _min = 0; // Minimum value of the slider
  final double _max = 10000; // Maximum value of the slider
  List<Transaction> transactions = [
    Transaction(
        image: 'assets/apple.svg',
        price: 5.93,
        subTitle: 'Entertainment',
        title: 'Apple Store',
        tranType: 'Debit'),
    Transaction(
        image: 'assets/spotify.svg',
        price: 12.99,
        subTitle: 'Music',
        title: 'Spotify',
        tranType: 'Debit'),
    Transaction(
        image: 'assets/trans.svg',
        price: 300,
        subTitle: 'Transaction',
        title: 'Money Transfer',
        tranType: 'Credit'),
    Transaction(
        image: 'assets/groc.svg',
        price: 0.88,
        subTitle: 'Transaction',
        title: 'Grocery',
        tranType: 'Debit')
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Height(height: 10.h),
          const HeaderRow(
            leading: Icons.arrow_back_ios,
            trailing: Icons.add,
            text: "My Cards",
          ),
          Height(height: 30.h),
          Container(
            height: 199.h,
            width: 355.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.r),
                gradient: const LinearGradient(colors: [
                  Color.fromARGB(255, 37, 37, 61),
                  Color.fromARGB(255, 29, 17, 107)
                ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 17.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset('assets/rec.svg'),
                      SvgPicture.asset('assets/rec2.svg'),
                    ],
                  ),
                  Height(height: 26.h),
                  ATM(numbers: '1234567890123456'),
                  Height(height: 12.h),
                  Text(
                    'AR Johnson',
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                  ),
                  Height(height: 16.h),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Expiry Date',
                            style: TextStyle(
                                color: AppColor.primaryText, fontSize: 9.sp),
                          ),
                          Height(height: 5.h),
                          Text(
                            '24/2000',
                            style:
                                TextStyle(color: Colors.white, fontSize: 13.sp),
                          ),
                        ],
                      ),
                      Width(30.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cvv',
                            style: TextStyle(
                                color: AppColor.primaryText, fontSize: 9.sp),
                          ),
                          Height(height: 5.h),
                          Text(
                            '294',
                            style:
                                TextStyle(color: Colors.white, fontSize: 13.sp),
                          ),
                          Width(30.w),
                        ],
                      ),
                      Width(110.w),
                      Column(
                        children: [
                          SvgPicture.asset('assets/master.svg'),
                          Height(height: 5.h),
                          Text(
                            'MasterCard',
                            style:
                                TextStyle(color: Colors.white, fontSize: 13.sp),
                          ),
                          Width(30.w),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Height(height: 30.h),
          SizedBox(
            height: 160.h,
            width: double.infinity,
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return transactions[index];
              },
              itemCount: transactions.length,
            ),
          ),
          Height(height: 15.h),
          Text(
            'Monthly Spending Limit',
            style: TextStyle(fontSize: 18.sp, fontFamily: "Poppins"),
          ),
          Height(height: 20.h),
          Expanded(
            child: Container(
              height: 90.h,
              width: 335.w,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 227, 227, 233),
                  borderRadius: BorderRadius.circular(18.r)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20.h, left: 20.w),
                    child: const Text('Amount: \$8,450.00'),
                  ),
                  Container(
                    child: SliderTheme(
                      data: SliderThemeData(
                        trackHeight: 3, // Adjust the track height as needed
                        //thumbColor: Colors.blue, // Color of the circular button
                        activeTrackColor: AppColor
                            .primaryColor, // Color of the active portion of the track
                        inactiveTrackColor: Colors
                            .white, // Color of the inactive portion of the track
                        overlayColor: Colors
                            .transparent, // Color of the white circle in between
                        thumbShape:
                            CustomSliderThumbShape(), // Custom shape for the circular button
                        // overlayShape: CustomSliderOverlayShape(), // Custom shape for the white circle in between
                      ),
                      child: Column(
                        children: [
                          Slider(
                            min: _min,
                            max: _max,
                            value: _value,
                            onChanged: (value) {
                              setState(() {
                                _value = value;
                              });
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$${_min.toStringAsFixed(0)}",
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                                Text(
                                  "\$${_value.toStringAsFixed(0)}",
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                                Text(
                                  "\$${_max.toStringAsFixed(0)}",
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Height(height: 5.h)
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}

class CustomSliderThumbShape extends RoundSliderThumbShape {
  static const double _thumbRadius = 6.0;
  static const double _overlayRadius = 8.0;
  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final canvas = context.canvas;

    final thumbRadius = _thumbRadius * enableAnimation.value;
    final overlayRadius = _overlayRadius * enableAnimation.value;

    final thumbCenter = center;
    final overlayCenter = center;

    // Draw the circular button with blue color
    canvas.drawCircle(
      thumbCenter,
      thumbRadius,
      Paint()..color = sliderTheme.thumbColor!,
    );

    // Draw the white circle in between
    canvas.drawCircle(
      overlayCenter,
      overlayRadius,
      Paint()..color = AppColor.primaryColor,
    );
  }
}
