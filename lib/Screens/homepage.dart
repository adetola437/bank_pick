import 'package:badges/badges.dart' as badges;
import 'package:bank_pick/Model/transaction_history.dart';
import 'package:bank_pick/Screens/my_requests.dart';
import 'package:bank_pick/Screens/pending_requests.dart';
import 'package:bank_pick/Screens/pin_login.dart';
import 'package:bank_pick/Screens/request.dart';
import 'package:bank_pick/Screens/send.dart';
import 'package:bank_pick/Screens/transaction_history.dart';
import 'package:bank_pick/Screens/transaction_receipt.dart';
import 'package:bank_pick/Widget/action_container.dart';
import 'package:bank_pick/Widget/atm_number.dart';
import 'package:bank_pick/Widget/height.dart';
import 'package:bank_pick/Widget/nav_container.dart';
import 'package:bank_pick/Widget/transaction_history.dart';
import 'package:bank_pick/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../Widget/transaction.dart';
import '../bloc/beneficiary/beneficiary_bloc.dart';
import '../bloc/history/history_bloc.dart';
import '../bloc/request/request_bloc.dart';
import '../bloc/user/user_bloc.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // List<TransactionHistory> history = [
  //   TransactionHistory(
  //       amount: 20,
  //       description: 'description',
  //       email: 'email',
  //       transactionTime: DateTime.now(),
  //       name: 'name')
  // ];
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
  void onRefresh() async {
    context.read<UserBloc>().add(GetUserEvent());
    context.read<BeneficiaryBloc>().add(GetBeneficiaryEvent());
    context.read<HistoryBloc>().add(GetHistoryEvent());
    context.read<RequestBloc>().add(GetUserRequestEvent());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        onRefresh();
      },
      child: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(top: 10.h, right: 20.w, left: 20.w),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingError) {
              return const Center(child: Text('An Error Occured'));
            }
            // if (state is UserSetPin) {
            //   Navigator.of(context).pushAndRemoveUntil(
            //     MaterialPageRoute(builder: (context) => const PinLogin()),
            //     (Route<dynamic> route) => false,
            //   );
            // }
            if (state is UserLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                ),
              );
            }
            if (state is UserLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 50.h,
                              child: Image.asset(
                                'assets/pic.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Width(16.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome back,',
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                                Height(height: 10.h),
                                BlocBuilder<UserBloc, UserState>(
                                  builder: (context, state) {
                                    if (state is UserLoaded) {
                                      return Text(
                                        state.user.name,
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w500),
                                      );
                                    }
                                    return Container();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        GestureDetector(onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return const PendingRequests();
                          }));
                        }, child: BlocBuilder<RequestBloc, RequestState>(
                          builder: (context, state) {
                            if (state is RequestSuccessful) {
                              return Stack(
                                children: [
                                  NavContainer(icon: Icons.notifications_none),
                                  state.recipietRequests
                                          .where((element) =>
                                              element.status == 'Pending')
                                          .toList()
                                          .isNotEmpty
                                      ? Positioned(
                                          top: 0,
                                          right: 0,
                                          child: badges.Badge(
                                            badgeContent: Text(
                                              state.recipietRequests
                                                  .where((element) =>
                                                      element.status ==
                                                      'Pending')
                                                  .toList()
                                                  .length
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            badgeStyle: const badges.BadgeStyle(
                                                badgeColor: Colors.red),
                                          ),
                                        )
                                      : Container(),
                                ],
                              );
                            }
                            return Container();
                          },
                        ))
                      ],
                    ),
                  ),
                  Height(height: 32.h),
                  Container(
                    height: 199.h,
                    width: 355.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.r),
                        gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 37, 37, 61),
                              Color.fromARGB(255, 29, 17, 107)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 17.h),
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
                            style:
                                TextStyle(color: Colors.white, fontSize: 13.sp),
                          ),
                          Height(height: 16.h),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Expiry Date',
                                    style: TextStyle(
                                        color: AppColor.primaryText,
                                        fontSize: 9.sp),
                                  ),
                                  Height(height: 5.h),
                                  Text(
                                    '24/2000',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13.sp),
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
                                        color: AppColor.primaryText,
                                        fontSize: 9.sp),
                                  ),
                                  Height(height: 5.h),
                                  Text(
                                    '294',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13.sp),
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
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13.sp),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return const Send();
                          }));
                        },
                        child: ActionContainer(
                          image: 'assets/arrowUp.svg',
                          text: 'Sent',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return const Request();
                          }));
                        },
                        child: ActionContainer(
                          image: 'assets/down.svg',
                          text: 'Receive',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return const MyRequests();
                          }));
                        },
                        child: BlocBuilder<RequestBloc, RequestState>(
                          builder: (context, state) {
                            if (state is RequestSuccessful) {
                              return Stack(
                                children: [
                                  ActionContainer(
                                    image: 'assets/cash.svg',
                                    text: 'My Requests',
                                  ),
                                  state.requests
                                          .where((element) =>
                                              element.status == 'Pending')
                                          .toList()
                                          .isNotEmpty
                                      ? Positioned(
                                          top: 0,
                                          right: 0,
                                          child: badges.Badge(
                                            badgeContent: Text(
                                              state.requests
                                                  .where((element) =>
                                                      element.status ==
                                                      'Pending')
                                                  .toList()
                                                  .length
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            badgeStyle: const badges.BadgeStyle(
                                                badgeColor: Colors.red),
                                          ),
                                        )
                                      : Container(),
                                ],
                              );
                            }
                            return Container();
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return const PinLogin();
                          }));
                        },
                        child: ActionContainer(
                          image: 'assets/cloud.svg',
                          text: 'TopUp',
                        ),
                      ),
                    ],
                  ),
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return const Transactions();
                          }));
                        },
                        child: const Text(
                          'See all',
                          style: TextStyle(
                              color: AppColor.primaryColor,
                              fontFamily: "Poppins"),
                        ),
                      )
                    ],
                  ),
                  Height(height: 20.h),
                  SizedBox(
                    height: 178.h,
                    width: double.infinity,
                    child: BlocBuilder<HistoryBloc, HistoryState>(
                      builder: (context, state) {
                        if (state is LoadedHistory) {
                          List<TransactionHistory> history =
                              state.transactionHistory;

                          return ListView.builder(
                            itemBuilder: (ctx, index) {
                              return GestureDetector(
                                child: TransactionHistoryWidget(
                                    tranType: history[index].type!,
                                    name: history[index].name,
                                    price: history[index].amount,
                                    subtitile: history[index].description,
                                    title: history[index].email),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return TransactionReceipt(
                                        amount: history[index].amount,
                                        description: history[index].description,
                                        email: history[index].email,
                                        name: history[index].name,
                                        transactionTime: DateTime.now(),
                                        type: history[index].type);
                                  }));
                                },
                              );
                            },
                            itemCount: history.length,
                          );
                        }
                        return Container();
                      },
                    ),
                  )
                ],
              );
            }
            return Container();
          },
        ),
      )),
    );
  }
}
