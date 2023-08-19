import 'package:bank_pick/Screens/edit_profile.dart';
import 'package:bank_pick/Widget/header_row.dart';
import 'package:bank_pick/Widget/height.dart';
import 'package:bank_pick/Widget/light_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Widget/my_profile_container.dart';
import '../bloc/user/user_bloc.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          children: [
            Height(height: 10.h),
            const HeaderRow(
                leading: Icons.arrow_back_ios,
                text: 'My Profile',
                trailing: Icons.person_4),
            Height(height: 32.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70.h,
                  width: 70.w,
                  child: Image.asset(
                    'assets/pic.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Width(22.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    Height(height: 5.h),
                    LightText(text: 'Senior Designer')
                  ],
                )
              ],
            ),
            Height(height: 32.h),
            MyProfileContainer(
              image: 'assets/p1.svg',
              text: 'Personal Information',
              widget: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const EditProfile();
                    }));
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 16.w,
                  )),
            ),
            MyProfileContainer(
              image: 'assets/p2.svg',
              text: 'Payment Preferences',
              widget: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 16.w,
                  )),
            ),
            MyProfileContainer(
              image: 'assets/p3.svg',
              text: 'Banks and Cards',
              widget: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 16.w,
                  )),
            ),
            MyProfileContainer(
                image: 'assets/p4.svg',
                text: 'Notifications',
                widget: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Container(
                    height: 18.h,
                    width: 18.w,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20.r)),
                    child: const Center(
                      child: Text(
                        '2',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )),
            MyProfileContainer(
              image: 'assets/p5.svg',
              text: 'Message Center',
              widget: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 16.w,
                  )),
            ),
            MyProfileContainer(
              image: 'assets/p7.svg',
              text: 'Address',
              widget: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 16.w,
                  )),
            ),
            MyProfileContainer(
              image: 'assets/p6.svg',
              text: 'Settings',
              widget: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 16.w,
                  )),
            )
          ],
        ),
      )),
    );
  }
}
