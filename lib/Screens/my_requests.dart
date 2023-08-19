import 'package:bank_pick/Model/request_model.dart';
import 'package:bank_pick/Widget/header_row.dart';
import 'package:bank_pick/Widget/height.dart';
import 'package:bank_pick/Widget/user_requests.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/request/request_bloc.dart';

class MyRequests extends StatefulWidget {
  const MyRequests({super.key});

  @override
  State<MyRequests> createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Height(height: 10.h),
            const HeaderRow(
                leading: Icons.arrow_back_ios,
                text: 'My Requests',
                trailing: Icons.pending),
            SizedBox(
              height: 800.h,
              width: 335.w,
              child: BlocBuilder<RequestBloc, RequestState>(
                builder: (context, state) {
                  if (state is RequestSuccessful) {
                    List<RequestModel> requests = state.requests;
                    return ListView.builder(
                        itemCount: state.requests.length,
                        itemBuilder: (ctx, index) {
                          return UserRequests(
                              amount: requests[index].amount,
                              description: requests[index].description,
                              email: requests[index].email,
                              name: requests[index].name,
                              status: requests[index].status,
                              time: requests[index].time);
                        });
                  }
                  return Container();
                },
              ),
            )
          ],
        ),
      ))),
    );
  }
}
