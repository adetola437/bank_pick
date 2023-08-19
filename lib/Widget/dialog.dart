// import 'package:flutter/material.dart';
// import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

// class Dialog extends StatefulWidget {
//   const Dialog({super.key});

//   @override
//   State<Dialog> createState() => _DialogState();
// }

// class _DialogState extends State<Dialog> {
//   void showPinInputDialog(BuildContext context) {
//     String pin = ''; // Variable to hold the entered PIN

//     showAnimatedDialog(
//       context: context,
//       barrierDismissible: true,
//       animationType: DialogTransitionType.slideFromBottomFade,
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Enter PIN'),
//           content: TextField(
//             onChanged: (value) => pin = value,
//             obscureText: true,
//             keyboardType: TextInputType.number,
//             decoration: const InputDecoration(
//               hintText: 'PIN',
//             ),
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context); // Close the dialog
//                 // Validate the entered PIN and perform necessary actions
//                 if (validatePin(pin)) {
//                   // PIN is valid, proceed with the transaction
//                   // Implement your transaction logic here
//                 } else {
//                   // PIN is invalid, show an error message or perform other actions
//                   // Implement your error handling logic here
//                 }
//               },
//               child: const Text('Submit'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   bool validatePin(String pin) {
//     // Implement your pin validation logic here
//     // Return true if the entered PIN is valid, false otherwise
//     return true;
//   }

// // Call the showPinInputDialog method wherever you want to display the dialog, for example:

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Container(
//             child: ElevatedButton(
//                 onPressed: () {
//                   showPinInputDialog(context);
//                 },
//                 child: const Text('press'))),
//       ),
//     );
//   }
// }
