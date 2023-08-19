// import 'package:easy_localization/easy_localization.dart';
// import 'package:responsive_framework/breakpoint.dart';
// import 'package:responsive_framework/responsive_breakpoints.dart';

// import 'config/flavor/flavor.dart';
// import 'core/core.dart';
// import 'core/theme/theme.dart';

// export 'package:responsive_framework/responsive_framework.dart';

// class MapXApp extends StatelessWidget {
//   const MapXApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(375, 812),
//       minTextAdapt: false,
//       splitScreenMode: false,
//      // scaleByHeight: true,
//       rebuildFactor: (old, data) {
//         return true;
//       },
//       builder: (context, child) => Listener(
//         onPointerMove: (event) {
//           KeyboardService.dismiss();
//         },
//         child: MaterialApp.router(
//           title: env.appName,
//           debugShowCheckedModeBanner: false,
//           routerConfig: routeConfig,
//           theme: AppTheme.light,
//           // darkTheme: AppTheme.dark,
//           themeMode: ThemeMode.light,
//           localizationsDelegates: context.localizationDelegates,
//           supportedLocales: context.supportedLocales,
//           locale: context.locale,
//           builder: (context, child) => ResponsiveBreakpoints.builder(
//             child: child!,
//             breakpoints: [
//               const Breakpoint(start: 0, end: 450, name: MOBILE),
//               const Breakpoint(start: 451, end: 800, name: TABLET),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
