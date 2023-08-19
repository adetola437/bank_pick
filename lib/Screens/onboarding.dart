import 'package:bank_pick/Screens/signin.dart';
import 'package:bank_pick/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Model/slider_model.dart';
import '../Widget/button.dart';
import '../Widget/slider.dart';
import '../Widget/slider_text.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool lastPage = false;
  int currentIndex = 0;
  final PageController _controller = PageController();
  final PageController _controller2 = PageController();
  List<SliderWidget> sliderList = [
    SliderWidget(
      slider:
          SliderModel(imagePath: 'assets/on1.svg', title: '', description: ''),
    ),
    SliderWidget(
      slider:
          SliderModel(imagePath: 'assets/on2.svg', title: '', description: ''),
    ),
    SliderWidget(
      slider:
          SliderModel(imagePath: 'assets/on3.svg', title: '', description: ''),
    ),
  ];
  List<SliderText> sliderNote = [
    SliderText(
      slider: SliderModel(
          title: 'Fastest Payment In The World',
          description:
              'Integrate multiple payment methods to help you up the process quickly'),
    ),
    SliderText(
      slider: SliderModel(
          title: 'The most secure platform\n for customer',
          description:
              'Built-in Fingerprint, face recognition and more, keeping you completely safe.'),
    ),
    SliderText(
      slider: SliderModel(
          title: 'Payment for everything is\n easy and convenient',
          description:
              'Integrate multiple payment methods to help you up the process quickly'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 375.h,
              child: Padding(
                padding: const EdgeInsets.only(top: 76),
                child: PageView.builder(
                    controller: _controller,
                    itemCount: sliderList.length,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (value) => setState(() {
                          currentIndex = value;

                          // lastPage = value == 2;
                        }),
                    itemBuilder: (context, index) {
                      return sliderList[index];
                    }),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    List.generate(3, (index) => dotContainer(index, context)),
              ),
            ),
            SizedBox(
              height: 36.h,
            ),
            SizedBox(
              width: 282.w,
              height: 138.h,
              child: PageView.builder(
                  controller: _controller2,
                  itemCount: sliderList.length,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (value) => setState(() {
                        currentIndex = value;
                        lastPage = value == 2;
                      }),
                  itemBuilder: (context, index) {
                    return sliderNote[index];
                  }),
            ),
            SizedBox(
              height: 50.h,
            ),
            lastPage == false
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        if (currentIndex <= 1) {
                          currentIndex++;

                          print(currentIndex);

                          _controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                          _controller2.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        }

                        // print(lastPage);
                      });
                    },
                    child: Button(
                      text: 'Next',
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const SignIn(),
                      ));
                    },
                    child: Button(text: 'Get Started'),
                  )
          ],
        ),
      ),
    );
  }

  Widget dotContainer(index, context) {
    return Container(
      height: 10,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: currentIndex == index ? 25 : 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? AppColor.primaryColor : Colors.grey,
      ),
    );
  }
}
