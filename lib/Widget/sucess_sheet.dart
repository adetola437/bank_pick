import 'package:bank_pick/Screens/home.dart';
import 'package:bank_pick/Widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionSuccessScreen extends StatefulWidget {
  const TransactionSuccessScreen({super.key});

  @override
  _TransactionSuccessScreenState createState() =>
      _TransactionSuccessScreenState();
}

class _TransactionSuccessScreenState extends State<TransactionSuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _scaleAnimation =
        Tween<double>(begin: 0, end: 1).animate(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0.w),
              child: SizedBox(
                  height: 120.h,
                  width: 120.w,
                  child: SvgPicture.asset(
                    'assets/suc.svg',
                    color: Colors.green,
                  )),
            ),
            Text(
              'Transaction Successful',
              style: TextStyle(
                  color: Colors.green, fontSize: 20.sp, fontFamily: 'Poppins'),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Successful transaction animation widget
                  // Add your desired animation widget here

                  // const SizedBox(height: 16),

                  // Done button
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Button(text: 'Done')),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Usage: Show the modal bottom sheet
void showTransactionSuccessBottomSheet(BuildContext context) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.r),
    ),
    isDismissible: false,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return const TransactionSuccessScreen();
    },
  );
}
