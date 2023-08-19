import 'package:bank_pick/Model/recipient_request.dart';
import 'package:bank_pick/Widget/height.dart';
import 'package:bank_pick/bloc/request/request_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors.dart';

class RecipientRequestsWidget extends StatefulWidget {
  final String email;
  final String name;
  final String description;
  final DateTime time;
  String status;
  final num amount;
  final String requestId;
  final String senderUid;
  final RequestStateEnum requestState;
  RecipientRequestsWidget(
      {required this.senderUid,
      required this.amount,
      required this.description,
      required this.email,
      required this.name,
      required this.status,
      required this.time,
      this.requestState = RequestStateEnum.success,
      required this.requestId,
      super.key});

  @override
  State<RecipientRequestsWidget> createState() =>
      _RecipientRequestsWidgetState();
}

class _RecipientRequestsWidgetState extends State<RecipientRequestsWidget> {
  bool _isExpanded = false;
  String _selectedOption = '';
  void _selectOption(String option) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: Text('Are you sure you want to select $option?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                setState(() {
                  _selectedOption = option;
                });

                // Perform action based on the selected option
                if (option == 'Yes') {
                  // Do something for "Yes" option
                  List<RecipientRequest> requests =
                      context.read<RequestBloc>().state.requestList();
                  requests
                      .where((element) => element.requestId == widget.requestId)
                      .first
                      .requestState = RequestStateEnum.loading;
                  context.read<RequestBloc>().add(
                        AcceptRequestEvent(
                          amount: widget.amount,
                          senderId: widget.senderUid,
                          requestId: widget.requestId,
                          requests: requests,
                        ),
                      );
                } else if (option == 'No') {
                  // Do something for "No" option List<RecipientRequest> requests =
                  List<RecipientRequest> requests =
                      context.read<RequestBloc>().state.requestList();
                  requests
                      .where((element) => element.requestId == widget.requestId)
                      .first
                      .requestState = RequestStateEnum.loading;
                  context.read<RequestBloc>().add(
                        RejectRequestEvent(
                          senderId: widget.senderUid,
                          requestId: widget.requestId,
                          requests: requests,
                        ),
                      );
                }
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    String fullName = widget.name;
    List<String> nameParts = fullName.split(' ');

    final String firstName = nameParts[0];
    final String lastName = nameParts.length > 1 ? nameParts[1] : '';
    final String in1 = firstName[0];
    final String in2 = nameParts.length > 1 ? lastName[0] : '';
    return GestureDetector(
      onTap: _toggleExpanded,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: _isExpanded ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2.0,
              blurRadius: 5.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
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
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )),
                ),
                Width(10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$${widget.amount.toString()}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0.sp,
                        color: _isExpanded ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      widget.email,
                      style: TextStyle(
                          color: AppColor.primaryText, fontSize: 14.sp),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(width: 10.0),
            widget.requestState == RequestStateEnum.loading
                ? const CircularProgressIndicator()
                : widget.status == 'Pending'
                    ? Row(
                        children: [
                          IconButton(
                            onPressed: () => _selectOption('Yes'),
                            icon: Icon(
                              Icons.check_circle,
                              size: 36,
                              color: _selectedOption == 'Yes'
                                  ? Colors.green
                                  : (_isExpanded ? Colors.white : Colors.black),
                            ),
                          ),
                          IconButton(
                            onPressed: () => _selectOption('No'),
                            icon: Icon(
                              Icons.cancel,
                              size: 36,
                              color: _selectedOption == 'No'
                                  ? Colors.red
                                  : (_isExpanded ? Colors.white : Colors.black),
                            ),
                          ),
                        ],
                      )
                    : (widget.status == 'Accepted'
                        ? Icon(
                            Icons.check_circle,
                            size: 36.w,
                            color: Colors.green,
                          )
                        : Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: 36.w,
                          )),
          ],
        ),
      ),
    );
  }
}
