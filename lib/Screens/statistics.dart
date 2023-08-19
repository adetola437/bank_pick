import 'package:bank_pick/Widget/height.dart';
import 'package:bank_pick/Widget/light_text.dart';
import 'package:bank_pick/Widget/nav_container.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Model/datapoint.dart';
import '../Widget/transaction.dart';
import '../bloc/user/user_bloc.dart';
import '../colors.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  List<double> monthlyExpenses = [500.0, 300.0, 700.0, 400.0, 600.0, 900.0];

  String selectedMonth = 'Jan';
  // List<double> monthlyExpense = [500.0, 300.0, 700.0, 400.0, 600.0, 900.0];
  List<DataPoint> dataPoints = [
    DataPoint(month: 'Jan', value: 30),
    DataPoint(month: 'Feb', value: 50),
    DataPoint(month: 'Mar', value: 40),
    DataPoint(month: 'Apr', value: 70),
    DataPoint(month: 'May', value: 60),
    DataPoint(month: 'Jun', value: 80),
  ];
  bool showDot = false;

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
      padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavContainer(icon: Icons.arrow_back_ios),
              Text(
                'Statistics',
                style: TextStyle(fontSize: 18.sp, fontFamily: "Poppins"),
              ),
              NavContainer(icon: Icons.notifications_sharp)
            ],
          ),
          Height(height: 32.h),
          LightText(text: 'Current Balance'),
          Height(height: 14.h),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoaded) {
                return Text(
                  '\$${state.user.balance.toStringAsFixed(2)}',
                  style:
                      TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600),
                );
              }
              return Container();
            },
          ),
          Height(height: 16.h),
          Column(
            children: [
              SizedBox(
                height: 200.h,
                width: 335.w,
                child: Column(
                  children: [
                    // Container(
                    //   padding: const EdgeInsets.all(16.0),
                    //   child: DropdownButton<String>(
                    //     value: selectedMonth,
                    //     onChanged: (String? newValue) {
                    //       setState(() {
                    //         selectedMonth = newValue!;
                    //       });
                    //     },
                    //     items: <String>[
                    //       'Jan',
                    //       'Feb',
                    //       'Mar',
                    //       'Apr',
                    //       'May',
                    //       'Jun',
                    //     ].map<DropdownMenuItem<String>>(
                    //       (String value) {
                    //         return DropdownMenuItem<String>(
                    //           value: value,
                    //           child: Text(value),
                    //         );
                    //       },
                    //     ).toList(),
                    //   ),
                    // ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(16.0),
                        child: LineChart(
                          LineChartData(
                            titlesData: FlTitlesData(
                              show: false,
                            ),
                            borderData: FlBorderData(show: false),
                            gridData: FlGridData(show: false),
                            lineBarsData: [
                              LineChartBarData(
                                isCurved: true,
                                color: AppColor.primaryColor,
                                barWidth: 4,
                                dotData: FlDotData(show: false),
                                belowBarData: BarAreaData(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppColor.primaryColor.withOpacity(0.2),
                                      Colors.white,
                                    ],
                                  ),
                                  show: true,
                                ),
                                spots: monthlyExpenses
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  final monthIndex = entry.key.toDouble() + 1;
                                  final expense = entry.value.toDouble();
                                  return FlSpot(monthIndex, expense);
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // SfCartesianChart(
              //   primaryXAxis: CategoryAxis(),
              //   series: <ChartSeries>[
              //     LineSeries<DataPoint, String>(
              //       dataSource: dataPoints,
              //       xValueMapper: (DataPoint point, _) => point.month,
              //       yValueMapper: (DataPoint point, _) => point.value,
              //     ),
              //   ],
              // ),

              const SizedBox(height: 10),
              SizedBox(
                height: 30.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dataPoints.length,
                  itemBuilder: (context, index) {
                    final point = dataPoints[index];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedMonth = point.month!;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          // border: Border.all(
                          //   color: selectedMonth == point.month
                          //       ? Colors.blue
                          //       : Colors.grey,
                          // ),
                          borderRadius: BorderRadius.circular(4),
                          color: selectedMonth == point.month
                              ? AppColor.primaryColor
                              : null,
                        ),
                        child: Text(
                          point.month!,
                          style: TextStyle(
                            color: selectedMonth == point.month
                                ? Colors.white
                                : Colors.black,
                            fontWeight: selectedMonth == point.month
                                ? FontWeight.bold
                                : null,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          // SizedBox(
          //   width: 335.w,
          //   height: 334.h,
          //   child: SvgPicture.asset('assets/Graph.svg'),
          // ),
          Height(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transaction',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins",
                    fontSize: 18.sp),
              ),
              const Text(
                'See all',
                style: TextStyle(
                    color: AppColor.primaryColor, fontFamily: "Poppins"),
              )
            ],
          ),
          Height(height: 20.h),
          SizedBox(
            height: 150.h,
            width: double.infinity,
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return transactions[index];
              },
              itemCount: transactions.length,
            ),
          )
        ],
      ),
    ));
  }
}

int _getMonthIndex(String month) {
  switch (month) {
    case 'Jan':
      return 1;
    case 'Feb':
      return 2;
    case 'Mar':
      return 3;
    case 'Apr':
      return 4;
    case 'May':
      return 5;
    case 'Jun':
      return 6;
    // Add more cases for other months if needed
    default:
      return 0;
  }
}
