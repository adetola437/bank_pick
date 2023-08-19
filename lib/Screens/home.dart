import 'package:bank_pick/Screens/settings.dart';
import 'package:bank_pick/Screens/statistics.dart';
import 'package:bank_pick/bloc/history/history_bloc.dart';
import 'package:bank_pick/bloc/request/request_bloc.dart';
import 'package:bank_pick/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Widget/bottom_app.dart';
import '../bloc/beneficiary/beneficiary_bloc.dart';
import '../bloc/user/user_bloc.dart';
import 'homepage.dart';
import 'my_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    context.read<UserBloc>().add(GetUserEvent());
    context.read<BeneficiaryBloc>().add(GetBeneficiaryEvent());
    context.read<HistoryBloc>().add(GetHistoryEvent());
    context.read<RequestBloc>().add(GetUserRequestEvent());
    context.read<UserBloc>().add(CheckTokenEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
          index: _selectedIndex,
          children: const [Homepage(), MyCards(), Statistics(), Settings()]),
      bottomNavigationBar: BottomAppBar(
          color: AppColor.backGround,
          height: 80.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Row(
              //  mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                  child: BottomApp(
                    imageUrl: 'assets/bt2.svg',
                    text: 'Home',
                    color: _selectedIndex == 0
                        ? AppColor.primaryColor
                        : AppColor.primaryText,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                  child: BottomApp(
                    imageUrl: 'assets/bt3.svg',
                    text: 'My Cards',
                    color: _selectedIndex == 1
                        ? AppColor.primaryColor
                        : AppColor.primaryText,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                  child: BottomApp(
                    imageUrl: 'assets/stat.svg',
                    text: 'Statistics',
                    color: _selectedIndex == 2
                        ? AppColor.primaryColor
                        : AppColor.primaryText,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 3;
                    });
                  },
                  child: BottomApp(
                    imageUrl: 'assets/bt4.svg',
                    text: 'Settings',
                    color: _selectedIndex == 3
                        ? AppColor.primaryColor
                        : AppColor.primaryText,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
