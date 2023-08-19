import 'package:bank_pick/Widget/header_row.dart';
import 'package:bank_pick/Widget/height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Widget/transaction.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
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
        tranType: 'Debit'),
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
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Height(height: 10.h),
            HeaderRow(
                leading: Icons.arrow_back_ios,
                text: 'Transaction History',
                trailing: Icons.history),
            Height(height: 22.h),
            Text(
              'All History',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
            Height(height: 10.h),
            SizedBox(
              height: 600.h,
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
      )),
    );
  }
}
