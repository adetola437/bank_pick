import 'package:bank_pick/Screens/language.dart';
import 'package:bank_pick/Screens/my_profile.dart';
import 'package:bank_pick/Widget/header_row.dart';
import 'package:bank_pick/Widget/height.dart';
import 'package:bank_pick/Widget/setitngs_container.dart';
import 'package:bank_pick/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../Widget/bold_text.dart';
import '../Widget/light_text.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String language = 'English';
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: HeaderRow(
                leading: Icons.arrow_back_ios,
                text: "Settings",
                trailing: Icons.exit_to_app),
          ),
          Height(height: 32.h),
          Text(
            'General',
            style: TextStyle(fontSize: 14.sp, color: AppColor.primaryText),
          ),
          Height(height: 32.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BoldText(
                text: 'Language',
              ),
              Row(
                children: [
                  LightText(text: language),
                  Width(16.w),
                  IconButton(
                      onPressed: () async {
                        final lang = await Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return const Language();
                        }));
                        setState(() {
                          language = lang;
                        });
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColor.linear,
                        size: 16.w,
                      ))
                ],
              )
            ],
          ),
          const Divider(),
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const MyProfile();
                }));
              },
              child: SettingsContainer(text: 'My Profile')),
          SettingsContainer(text: 'Contact Us'),
          Height(height: 10.h),
          LightText(text: 'Security'),
          Height(height: 15.h),
          SettingsContainer(text: 'Change Password'),
          SettingsContainer(text: 'Privacy Policy'),
          LightText(text: 'Choose what data you share with us'),
          Height(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BoldText(text: 'Biometrics'),
              FlutterSwitch(
                width: 45.0,
                height: 25.0,
                //  valueFontSize: 25.0,
                //  toggleSize: 45.0,
                value: status,
                //   borderRadius: 30.0,
                //  padding: 8.0,
                // showOnOff: true,
                onToggle: (val) {
                  setState(() {
                    status = val;
                  });
                },
              ),
            ],
          )
        ],
      ),
    ));
  }
}
