import 'package:bank_pick/Widget/button.dart';
import 'package:bank_pick/Widget/header_row.dart';
import 'package:bank_pick/Widget/height.dart';
import 'package:bank_pick/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Model/language.dart';
import '../Widget/language_selection.dart';

List<LanguageModel> language = [
  LanguageModel(image: 'assets/usa.png', language: 'English'),
  LanguageModel(image: 'assets/aus.png', language: 'Australia'),
  LanguageModel(image: 'assets/fran.png', language: 'France'),
  LanguageModel(image: 'assets/span.png', language: 'Spanish'),
  LanguageModel(image: 'assets/america.png', language: 'America'),
  LanguageModel(image: 'assets/viet.png', language: 'Vietnam')
];

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  String? selectedLanguage;
  // LanguageSelect languageSelect = language.first;

  // toggleLanguage(LanguageSelect language) {
  //   languageSelect = language;
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Height(height: 10.h),
            HeaderRow(
                leading: Icons.arrow_back_ios,
                text: 'Language',
                trailing: Icons.home),
            Height(height: 32.h),
            SizedBox(
              height: 44.h,
              width: 335.w,
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'Search Language',
                    hintStyle: const TextStyle(
                        fontFamily: 'Poppins', color: AppColor.primaryText),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColor.primaryText,
                    ),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                    enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(color: Colors.white))),
              ),
            ),
            Height(height: 32.h),
            SizedBox(
              height: 500.h,
              width: 335.w,
              child: ListView.builder(
                  itemCount: language.length,
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedLanguage = language[index].language;
                        });
                      },
                      child: LanguageSelect(
                          image: language[index].image,
                          visible: selectedLanguage == language[index].language,
                          language: language[index].language),
                    );
                  }),
            ),
            // Height(height: 0.h),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context, selectedLanguage);
                },
                child: Button(text: 'Select'))
          ],
        ),
      )),
    );
  }
}
