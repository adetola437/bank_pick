import 'package:bank_pick/Widget/header_row.dart';
import 'package:bank_pick/Widget/height.dart';
import 'package:bank_pick/Widget/light_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _dayController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  DateTime? _selectedDate;
  @override
  void initState() {
    super.initState();
    _dayController = TextEditingController();
  }

  @override
  void dispose() {
    _dayController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dayController.text = picked.day.toString();
        _monthController.text = picked.month.toString();
        _yearController.text = picked.year.toString();
      });
    }
  }

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
                text: 'Edit Profile',
                trailing: Icons.space_bar),
            Height(height: 32.h),
            Padding(
              padding: EdgeInsets.only(left: 103.w),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 90.h,
                    width: 90.w,
                    child: Image.asset(
                      'assets/pic2.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Height(height: 22.h),
                  Text(
                    'Tanya Myroniuk',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500),
                  ),
                  Height(height: 10.h),
                  LightText(text: 'Senior Designer'),
                ],
              ),
            ),
            Height(height: 32.h),
            Text(
              'Full Name',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: "Poppins",
                  color: AppColor.primaryText),
            ),
            TextFormField(
              decoration: InputDecoration(
                  enabledBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.primaryText, width: 0)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.primaryText, width: 0)),
                  prefixIcon: Image.asset('assets/person.png')),
            ),
            Height(height: 22.h),
            Text(
              'Email Address',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: "Poppins",
                  color: AppColor.primaryText),
            ),
            TextFormField(
              decoration: InputDecoration(
                  enabledBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.primaryText, width: 0)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.primaryText, width: 0)),
                  prefixIcon: Image.asset('assets/person.png')),
            ),
            Height(height: 22.h),
            Text(
              'Phone Number',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: "Poppins",
                  color: AppColor.primaryText),
            ),
            TextFormField(
              decoration: InputDecoration(
                  enabledBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.primaryText, width: 0)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.primaryText, width: 0)),
                  prefixIcon: Image.asset('assets/Path.png')),
            ),
            Height(height: 22.h),
            Text(
              'Birth Date',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: "Poppins",
                  color: AppColor.primaryText),
            ),
            Height(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 82.w,
                  height: 24.h,
                  child: TextFormField(
                    controller: _dayController,
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColor.primaryText, width: 0)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColor.primaryText, width: 0)),
                      //  labelText: 'Day',
                    ),
                  ),
                ),
                SizedBox(
                  width: 82.w,
                  height: 24.h,
                  child: TextFormField(
                    controller: _monthController,
                    readOnly: true,
                    onTap: () => {},
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColor.primaryText, width: 0)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColor.primaryText, width: 0)),
                      //  labelText: 'Day',
                    ),
                  ),
                ),
                SizedBox(
                  width: 82.w,
                  height: 24.h,
                  child: TextFormField(
                    controller: _yearController,
                    readOnly: true,
                    onTap: () => {},
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColor.primaryText, width: 0)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColor.primaryText, width: 0)),
                      //  labelText: 'Day',
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
