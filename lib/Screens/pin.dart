import 'package:bank_pick/Widget/height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PinInputPage extends StatefulWidget {
  const PinInputPage({super.key});

  @override
  _PinInputPageState createState() => _PinInputPageState();
}

class _PinInputPageState extends State<PinInputPage> {
  String pin = '';

  void _addDigit(String digit) {
    setState(() {
      if (pin.length < 4) {
        pin += digit;
      }
    });
  }

  void _removeDigit() {
    setState(() {
      if (pin.isNotEmpty) {
        pin = pin.substring(0, pin.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PIN Input'),
      ),
      body: Column(
        //  mainAxisSize: MainAxisSize.min,

        children: [
          Height(height: 32.h),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Enter your four-digit PIN',
              style: TextStyle(fontSize: 18.0, fontFamily: 'Poppins'),
            ),
          ),
          Text(
            'PIN: $pin',
            style: const TextStyle(fontSize: 18.0),
          ),
          Container(
            height: 500.h,
            width: 335.w,
            child: Column(
              children: [
                SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildPinDigitButton('1'),
                      _buildPinDigitButton('2'),
                      _buildPinDigitButton('3'),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildPinDigitButton('4'),
                      _buildPinDigitButton('5'),
                      _buildPinDigitButton('6'),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildPinDigitButton('7'),
                      _buildPinDigitButton('8'),
                      _buildPinDigitButton('9'),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildPinDigitButton('', icon: Icons.backspace),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPinDigitButton(String digit, {IconData? icon}) {
    final isBackspace = icon == Icons.backspace;
    const textStyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
    return InkWell(
      onTap: isBackspace ? _removeDigit : () => _addDigit(digit),
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: isBackspace ? Colors.red : Colors.blue,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: icon != null
              ? Icon(
                  icon,
                  color: Colors.white,
                )
              : Text(
                  digit,
                  style: textStyle.copyWith(color: Colors.white),
                ),
        ),
      ),
    );
  }
}
