// import 'package:flutter/material.dart';
// import 'package:xds/xds.dart';

// import '../core.dart';

// class AppTheme {
//   static ThemeData light = ThemeData(
//     scaffoldBackgroundColor: const Color(0xffF8F9FA),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         disabledBackgroundColor: xDS.colors.xDSAred7.withOpacity(0.2),
//         disabledForegroundColor: xDS.colors.xDSENeutral1,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.r),
//         ),
//         elevation: 0,
//         fixedSize: Size(343.sp, 56.sp),
//         backgroundColor: xDS.colors.xDSAred7,
//         textStyle: xDS.xdsTypography.dynamicStyle(
//           letterSpacing: -0.8,
//           fontSize: 16.sp,
//           height: 1,
//           fontWeight: FontWeight.w500,
//           color: Colors.white,
//         ),
//       ),
//     ),
//     tabBarTheme: TabBarTheme(
//       indicator: BoxDecoration(
//         borderRadius: BorderRadius.circular(8.r),
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0xff101828).withOpacity(0.04),
//             offset: const Offset(0, 1),
//             blurRadius: 2.r,
//             spreadRadius: 0.r,
//           ),
//         ],
//       ),
//       labelColor: xDS.colors.xDSAred6,
//       unselectedLabelColor: const Color(0xff8F8E91),
//       labelStyle: xDS.xdsTypography.dynamicStyle(
//         fontSize: 12.sp,
//         fontWeight: FontWeight.w600,
//       ),
//       unselectedLabelStyle: xDS.xdsTypography.dynamicStyle(
//         fontSize: 12.sp,
//         fontWeight: FontWeight.w500,
//       ),
//     ),
//     textButtonTheme: TextButtonThemeData(
//       style: TextButton.styleFrom(
//         foregroundColor: xDS.colors.xDSAred6,
//         textStyle: xDS.xdsTypography.dynamicStyle(
//           fontSize: 12.sp,
//           fontWeight: FontWeight.w500,
//           height: 20 / 12,
//           color: xDS.colors.xDSAred6,
//         ),
//       ),
//     ),
//     outlinedButtonTheme: OutlinedButtonThemeData(
//       style: OutlinedButton.styleFrom(
//         elevation: 0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.r),
//         ),
//         textStyle: xDS.xdsTypography.dynamicStyle(
//           fontSize: 12.sp,
//           height: 16 / 12,
//           fontWeight: FontWeight.w500,
//           color: Colors.white,
//         ),
//       ),
//     ),
//     bottomSheetTheme: BottomSheetThemeData(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(24.r),
//         ),
//       ),
//     ),
//     appBarTheme: AppBarTheme(
//       iconTheme: IconThemeData(color: xDS.colors.xDSENeutral8),
//       elevation: 0,
//       centerTitle: false,
//       color: Colors.white,
//       titleTextStyle: TextStyle(
//         fontSize: 20.sp,
//         fontWeight: FontWeight.w600,
//         color: const Color(0xff2B2930),
//       ),
//     ),
//     dialogTheme: DialogTheme(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.r),
//       ),
//     ),
//     fontFamily: 'Switzer',
//     checkboxTheme: CheckboxThemeData(
//       fillColor: MaterialStateProperty.all(xDS.colors.xDSAred6),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(4.r),
//       ),
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       hintStyle: xDS.xdsTypography
//           .mdBody16px()
//           .copyWith(color: xDS.colors.xDSENeutral6),
//       contentPadding: REdgeInsets.all(18),
//       fillColor: Colors.white,
//       focusColor: Colors.black,
//       filled: true,
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8.r),
//         borderSide: BorderSide(
//           color: xDS.colors.xDSCNeutral5,
//         ),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8.r),
//         borderSide: BorderSide(
//           color: xDS.colors.xDSCNeutral5,
//           width: 2,
//         ),
//       ),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8.r),
//         borderSide: BorderSide(
//           color: xDS.colors.xDSCNeutral5,
//         ),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8.r),
//         borderSide: BorderSide(
//           color: xDS.colors.xDSAred6,
//         ),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8.r),
//         borderSide: BorderSide(
//           color: xDS.colors.xDSAred6,
//           width: 2,
//         ),
//       ),
//     ),
//     textTheme: TextTheme(

//         //  headlineLarge: xDS.xdsTypography.heading24px(),
//         labelSmall: xDS.xdsTypography
//             .rgBody16px()
//             .copyWith(color: xDS.colors.xDSNeutral5),
//         labelMedium: xDS.xdsTypography
//             .rgBody16px()
//             .copyWith(color: xDS.colors.xDSNeutral5),
//         titleMedium: TextStyle(
//             color: xDS.colors.xDSWNeutral10,
//             fontSize: xDS.xdsTypography.mdBody16px().fontSize)
//         //xDS.xdsTypography
//         //    .smRgBody12px()
//         //   .copyWith(color: const Color(0xff8F8E91), height: 19 / 12),
//         ),
//   );
//   static ThemeData dark = ThemeData(fontFamily: 'Switzer');
// }
