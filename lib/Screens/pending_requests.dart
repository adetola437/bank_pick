import 'package:bank_pick/Model/recipient_request.dart' hide RequestState;
import 'package:bank_pick/Widget/recipient_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Widget/header_row.dart';
import '../Widget/height.dart';
import '../bloc/request/request_bloc.dart';
import '../bloc/user/user_bloc.dart';

class PendingRequests extends StatefulWidget {
  const PendingRequests({super.key});

  @override
  State<PendingRequests> createState() => _PendingRequestsState();
}

class _PendingRequestsState extends State<PendingRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Height(height: 10.h),
              const HeaderRow(
                  leading: Icons.arrow_back_ios,
                  text: 'Pending Requests',
                  trailing: Icons.pending),
              Expanded(
                child: BlocConsumer<RequestBloc, RequestState>(
                  listener: (context, state) {
                    if (state is RequestSuccessful) {
                      context.read<UserBloc>().add(GetUserEvent());
                    }
                    if (state is RequestError) {
                      Fluttertoast.showToast(msg: state.error);
                      context.read<RequestBloc>().add(GetUserRequestEvent());
                    }
                  },
                  builder: (context, state) {
                    print(state);
                    if (state is RequestSuccessful) {
                      List<RecipientRequest> recipientRequest =
                          state.recipietRequests;
                      return ListView.builder(
                          itemCount: state.recipietRequests.length,
                          itemBuilder: (ctx, index) {
                            return RecipientRequestsWidget(
                              amount: recipientRequest[index].amount,
                              description: recipientRequest[index].description,
                              email: recipientRequest[index].email,
                              name: recipientRequest[index].name,
                              status: recipientRequest[index].status,
                              time: recipientRequest[index].time,
                              senderUid: recipientRequest[index].senderUid,
                              requestId: recipientRequest[index].requestId,
                              requestState:
                                  state.recipietRequests[index].requestState,
                            );
                          });
                    }
                    if (state is RequestLoading) {
                      return state.recipietRequests.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: state.recipietRequests.length,
                              itemBuilder: (ctx, index) {
                                return RecipientRequestsWidget(
                                  amount: state.recipietRequests[index].amount,
                                  description:
                                      state.recipietRequests[index].description,
                                  email: state.recipietRequests[index].email,
                                  name: state.recipietRequests[index].name,
                                  status: state.recipietRequests[index].status,
                                  time: state.recipietRequests[index].time,
                                  senderUid:
                                      state.recipietRequests[index].senderUid,
                                  requestId:
                                      state.recipietRequests[index].requestId,
                                  requestState: state
                                      .recipietRequests[index].requestState,
                                );
                              });
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
