// import '../core.dart';

// class UnFIlledButton extends StatelessWidget {
//   int height;
//   Function tappped;
//   String title;
//   UnFIlledButton({
//     required this.height,
//     required this.title,
//     required this.tappped,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return OutlinedButton(
//       onPressed: () {
//         tappped();
//       },
//       style: OutlinedButton.styleFrom(
//         fixedSize: Size(double.maxFinite, height.h),
//         side: BorderSide(
//             color: context.colors.xDSAred7), // Set the border color to red
//         // minimumSize:
//         //     Size(double.infinity, height.h), // Set the button height to 56
//       ),
//       child: Center(
//         child: title.toText(
//             style: context.typography
//                 .mdBody16px()
//                 .copyWith(color: context.colors.xDSAred7)),
//       ),
//     );
//   }
// }
