// // library router;
// //
// // import 'package:afex_mobile/features/assets/presentation/controllers/add_modey_via_ussd.dart';
// // import 'package:afex_mobile/features/assets/presentation/controllers/add_money_via_card.dart';
// // import 'package:afex_mobile/features/assets/presentation/controllers/add_new_card.dart';
// // import 'package:afex_mobile/features/auth/presentation/controllers/reset_password.dart';
// // import 'package:afex_mobile/features/home/presentation/controllers/home.dart';
// // import 'package:afex_mobile/features/market/presentation/controllers/buy_or_sell_security.dart';
// // import 'package:afex_mobile/features/market/presentation/controllers/markets_home.dart';
// // import 'package:afex_mobile/features/market/presentation/controllers/security.dart';
// // import 'package:afex_mobile/features/user/presentation/controllers/edit_personal_details.dart';
// // import 'package:afex_mobile/features/user/presentation/controllers/help_and_support.dart';
// // import 'package:afex_mobile/features/user/presentation/controllers/refer_earn.dart';
// // import 'package:afex_mobile/features/user/presentation/controllers/user_profile.dart';
// // import 'package:go_router/go_router.dart';
// //
// // import '../../features/assets/presentation/controllers/assets_home.dart';
// // import '../../features/assets/presentation/controllers/wallets.dart';
// // import '../../features/auth/auth.dart';
// // import '../../features/user/presentation/controllers/account_details.dart';
// // import '../../features/user/presentation/controllers/add_bank.dart';
// // import '../../features/user/presentation/controllers/begin_kyc.dart';
// // import '../../features/user/presentation/controllers/change_password.dart';
// // import '../../features/user/presentation/controllers/create_account_pin.dart';
// // import '../../features/user/presentation/controllers/edit_contact_details.dart';
// // import '../../features/user/presentation/controllers/faqs.dart';
// // import '../../features/user/presentation/controllers/kyc_aml_check.dart';
// // import '../../features/user/presentation/controllers/kyc_credentials.dart';
// // import '../../features/user/presentation/controllers/kyc_personal_information.dart';
// // import '../../features/user/presentation/controllers/kyc_personal_information_corporate.dart';
// // import '../../features/user/presentation/controllers/kyc_upload_documents.dart';
// // import '../../features/user/presentation/controllers/kyc_user_type.dart';
// // import '../../features/user/presentation/controllers/language.dart';
// // import '../../features/user/presentation/controllers/nok.dart';
// // import '../../features/user/presentation/controllers/notification.dart';
// // import '../../features/user/presentation/controllers/two_fa.dart';
// // import '../core.dart';
// //

// // final homeNavigatorKey = GlobalKey<NavigatorState>();
// // final marketNavigatorKey = GlobalKey<NavigatorState>();
// // final learnNavigatorKey = GlobalKey<NavigatorState>();
// // final assetsNavigatorKey = GlobalKey<NavigatorState>();
// // final moreNavigatorKey = GlobalKey<NavigatorState>();
// //

// import 'package:go_router/go_router.dart';
// import 'package:mapxmobile/features/auth/presentation/screens/controllers/change_password.dart';
// import 'package:mapxmobile/features/auth/presentation/screens/controllers/complete_registration.dart';
// import 'package:mapxmobile/features/auth/presentation/screens/controllers/confirm_2fa_code.dart';
// import 'package:mapxmobile/features/auth/presentation/screens/controllers/create_password.dart';
// import 'package:mapxmobile/features/auth/presentation/screens/controllers/enter_verify_code.dart';
// import 'package:mapxmobile/features/auth/presentation/screens/controllers/farmers_controllers.dart';
// import 'package:mapxmobile/features/auth/presentation/screens/controllers/forgot_password.dart';
// import 'package:mapxmobile/features/auth/presentation/screens/controllers/gps_hardware.dart';
// import 'package:mapxmobile/features/auth/presentation/screens/controllers/me.dart';
// import 'package:mapxmobile/features/auth/presentation/screens/controllers/overlapping_farmlands.dart';
// import 'package:mapxmobile/features/auth/presentation/screens/controllers/splash_screen.dart';
// import 'package:mapxmobile/features/auth/presentation/screens/controllers/two_factor_authentication.dart';
// import 'package:mapxmobile/features/auth/presentation/screens/controllers/welcome_screen.dart';

// import '../../features/auth/presentation/screens/controllers/Farm_details_controller.dart';
// import '../../features/auth/presentation/screens/controllers/capture_controller.dart';
// import '../../features/auth/presentation/screens/controllers/edit_farmers_profile_controller.dart';
// import '../../features/auth/presentation/screens/controllers/farm_name_controller.dart';
// import '../../features/auth/presentation/screens/controllers/farmer_profile_controller.dart';
// import '../../features/auth/presentation/screens/controllers/home_controller.dart';
// import '../../features/auth/presentation/screens/controllers/login.dart';
// import '../../features/auth/presentation/screens/controllers/notification_controller.dart';
// import '../../features/auth/presentation/screens/controllers/register_farmers_controller.dart';
// import '../../features/auth/presentation/screens/controllers/take_point_controller.dart';
// import '../core.dart';

// final rootNavigatorKey = GlobalKey<NavigatorState>();
// final taboneNavigatorKey = GlobalKey<NavigatorState>();
// final tabtwoNavigatorKey = GlobalKey<NavigatorState>();
// final tabthreeNavigatorKey = GlobalKey<NavigatorState>();

// final rootScaffoldKey = GlobalKey<ScaffoldState>();

// final GoRouter routeConfig = GoRouter(
//   debugLogDiagnostics: true,
//   // initialLocation: EnterVerificationCodeScreen.route,
//   navigatorKey: rootNavigatorKey,
//   routes: [
//     GoRoute(
//       path: "/",
//       pageBuilder: (context, state) => _buildPage(const SplashScreen()),
//       // routes: [
//       // GoRoute(

//       // )
//       //  ]
//     ),
//         GoRoute(
//       path: HomeScreen.route,
//      // name: "/$RegisterFarmersScreen.route",
//       builder: (BuildContext context, GoRouterState state) {
//         return const HomeScreen();
//       },
//     ),

//     GoRoute(
//       path: LoginScreen.route,
//       pageBuilder: (context, state) => _buildPage(const LoginScreen()),
//     ),
//     GoRoute(
//       path: MeScreen.route,
//       pageBuilder: (context, state) => _buildPage(const MeScreen()),
//     ),
//     GoRoute(
//       path: ForgotPasswordScreen.route,
//       name: ForgotPasswordScreen.route,
//       pageBuilder: (context, state) => _buildPage(const ForgotPasswordScreen()),
//     ),
//     GoRoute(
//       path: GPSHardwareScreen.route,
//       name: GPSHardwareScreen.route,
//       pageBuilder: (context, state) => _buildPage(const GPSHardwareScreen()),
//     ),
//     GoRoute(
//       path: CompleteRegistrationScreen.route,
//       name: CompleteRegistrationScreen.route,
//       pageBuilder: (context, state) =>
//           _buildPage(const CompleteRegistrationScreen()),
//     ),
//        GoRoute(
//       path: RegisterFarmersScreen.route,
//      // name: "/$RegisterFarmersScreen.route",
//       builder: (BuildContext context, GoRouterState state) {
//         return const RegisterFarmersScreen();
//       },
//     ), 
//       GoRoute(
//       path: NotificationScreen.route,
//       // name: "/$RegisterFarmersScreen.route",
//      pageBuilder: (context, state) => _buildPage(const NotificationScreen()),
//     ),
//     GoRoute(
//       path: FarmDetailsScreen.route,
//       // name: "/$RegisterFarmersScreen.route",
//       pageBuilder: (context, state) => _buildPage(const FarmDetailsScreen()),
//     ),
//          GoRoute(
//       path: FarmerProfileScreen.route,
//      // name: "/$RegisterFarmersScreen.route",
//       builder: (BuildContext context, GoRouterState state) {
//         return const FarmerProfileScreen();
//       },
//       routes: [
//            GoRoute(
//       path: EditFarmerProfileScreen.route,
//      // name: "/$RegisterFarmersScreen.route",
//       builder: (BuildContext context, GoRouterState state) {
//         return const EditFarmerProfileScreen();
//       },
//     ),
//          GoRoute(
//       path: TakePointScreen.route,
//      // name: "/$RegisterFarmersScreen.route",
//       builder: (BuildContext context, GoRouterState state) {
//         return const TakePointScreen();
//       },
//     ),
//      GoRoute(
//       path: CaptureScreen.route,
//      // name: "/$RegisterFarmersScreen.route",
//       builder: (BuildContext context, GoRouterState state) {
//         return const CaptureScreen();
//       },
//     ),
  
//      GoRoute(
//       path: FarmNameScreen.route,
//      // name: "/$RegisterFarmersScreen.route",
//       builder: (BuildContext context, GoRouterState state) {
//         return const FarmNameScreen();
//       },
//     ),
//       ]
//     ),
//     GoRoute(
//       path: TwoFactorAuthenticationScreen.route,
//       name: TwoFactorAuthenticationScreen.route,
//       pageBuilder: (context, state) =>
//           _buildPage(const TwoFactorAuthenticationScreen()),
//     ),
//     GoRoute(
//       path: Confirm2FACodeScreen.route,
//       name: Confirm2FACodeScreen.route,
//       pageBuilder: (context, state) => _buildPage(const Confirm2FACodeScreen()),
//     ),
//     GoRoute(
//       path: OverlappingFarmlandsScreen.route,
//       name: OverlappingFarmlandsScreen.route,
//       pageBuilder: (context, state) =>
//           _buildPage(const OverlappingFarmlandsScreen()),
//     ),
//     GoRoute(
//       path: ChangePasswordScreen.route,
//       name: ChangePasswordScreen.route,
//       pageBuilder: (context, state) => _buildPage(const ChangePasswordScreen()),
//     ),
//     GoRoute(
//       path: CreatePasswordScreen.route,
//       name: CreatePasswordScreen.route,
//       pageBuilder: (context, state) => _buildPage(const CreatePasswordScreen()),
//     ),
//     GoRoute(
//       path: EnterVerificationCodeScreen.route,
//       pageBuilder: (context, state) =>
//           _buildPage(const EnterVerificationCodeScreen()),
//     ),
//     GoRoute(
//       path: WelcomeScreen.route,
//       pageBuilder: (context, state) => CustomTransitionPage(
//         child: const WelcomeScreen(),
//         transitionDuration: 500.milliseconds(),
//         transitionsBuilder: (
//           BuildContext context,
//           Animation<double> animation,
//           Animation<double> secondaryAnimation,
//           Widget child,
//         ) {
//           const begin = Offset(0.0, 1.0);
//           const end = Offset.zero;
//           const curve = Curves.ease;
//           var tween =
//               Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//           final curvedAnimation = CurvedAnimation(
//             parent: animation,
//             curve: curve,
//           );
//           return SlideTransition(
//             position: tween.animate(curvedAnimation),
//             child: child,
//           );
//         },
//       ), // _buildPage(const WelcomeScreen()),
//     ),
//     // StatefulShellRoute.indexedStack(
//     //   builder: (context, state, navigationShell) =>
//     //       ScaffoldWithNestedNavigation(
//     //     navigationShell: navigationShell,
//     //   ),
//     //   branches: [
//     //     StatefulShellBranch(
//     //       navigatorKey: taboneNavigatorKey,
//     //       routes: [
//     //         GoRoute(
//     //           path: '/A',
//     //           pageBuilder: (context, state) => const NoTransitionPage(
//     //             child: Scaffold(
//     //               body: SafeArea(
//     //                 child: FlutterLogo(
//     //                   style: FlutterLogoStyle.markOnly,
//     //                 ),
//     //               ),
//     //             ),
//     //           ),
//     //         ),
//     //       ],
//     //     ),
//     //     StatefulShellBranch(
//     //       navigatorKey: tabtwoNavigatorKey,
//     //       routes: [
//     //         GoRoute(
//     //           path: '/B',
//     //           pageBuilder: (context, state) => const NoTransitionPage(
//     //             child: Scaffold(
//     //               body: SafeArea(
//     //                 child: FlutterLogo(
//     //                   style: FlutterLogoStyle.markOnly,
//     //                 ),
//     //               ),
//     //             ),
//     //           ),
//     //         )
//     //       ],
//     //     ),
//     //     StatefulShellBranch(
//     //       navigatorKey: tabthreeNavigatorKey,
//     //       routes: [
//     //         GoRoute(
//     //           path: '/C',
//     //           pageBuilder: (context, state) => const NoTransitionPage(
//     //             child: Scaffold(
//     //               body: SafeArea(
//     //                 child: FlutterLogo(
//     //                   style: FlutterLogoStyle.markOnly,
//     //                 ),
//     //               ),
//     //             ),
//     //           ),
//     //         )
//     //       ],
//     //     ),
//     //   ],
//     // ),
//     // GoRoute(
//     //   path: '/',
//     //   pageBuilder: (context, state) => _buildPage(const HomeScreen()),
//     // ),
//     // StatefulShellRoute.indexedStack(
//     //   builder: (context, state, navigationShell) =>
//     //       ScaffoldWithNestedNavigation(
//     //     navigationShell: navigationShell,
//     //   ),
//     //   branches: [
//     //     StatefulShellBranch(
//     //       navigatorKey: taboneNavigatorKey,
//     //       routes: [
//     //         GoRoute(
//     //           path: HomeScreen.route,
//     //           pageBuilder: (context, state) =>  NoTransitionPage(
//     //             child: Scaffold(
//     //               appBar: AppBar(),
//     //               body: SafeArea(
//     //                 child: FlutterLogo(),
//     //               ),
//     //             ),
//     //           ),
//     //         ),
//     //       ],
//     //     ),
//     //     StatefulShellBranch(
//     //       navigatorKey: tabtwoNavigatorKey,
//     //       routes: [
//     //         GoRoute(
//     //           path: '/B',
//     //           pageBuilder: (context, state) => const NoTransitionPage(
//     //             child: Scaffold(
//     //               body: SafeArea(
//     //                 child: FlutterLogo(
//     //                   style: FlutterLogoStyle.markOnly,
//     //                 ),
//     //               ),
//     //             ),
//     //           ),
//     //         )
//     //       ],
//     //     ),
//     //     StatefulShellBranch(
//     //       navigatorKey: tabthreeNavigatorKey,
//     //       routes: [
//     //         GoRoute(
//     //           path: '/C',
//     //           pageBuilder: (context, state) => const NoTransitionPage(
//     //             child: Scaffold(
//     //               body: SafeArea(
//     //                 child: FlutterLogo(
//     //                   style: FlutterLogoStyle.markOnly,
//     //                 ),
//     //               ),
//     //             ),
//     //           ),
//     //         )
//     //       ],
//     //     ),
//     //   ],
//     // ),
//   ],
// );

// Page _buildPage(Widget child) {
//   return Platform.isIOS
//       ? CupertinoPage(child: child)
//       : MaterialPage(child: child);
// }

// PageRoute buildPageRoute(Widget child) {
//   return Platform.isIOS
//       ? CupertinoPageRoute(builder: (context) => child)
//       : MaterialPageRoute(builder: (context) => child);
// }

// // class ScaffoldWithNestedNavigation extends StatelessWidget {
// //   const ScaffoldWithNestedNavigation({
// //     super.key,
// //     required this.navigationShell,
// //   });

// //   final StatefulNavigationShell navigationShell;

// //   void _goBranch(int index) {
// //     navigationShell.goBranch(index,
// //         initialLocation: index == navigationShell.currentIndex);
// //   }

//   // @override
//   // Widget build(BuildContext context) {
//   //   return ScaffoldWithNavigationBar(
//   //     body: navigationShell,
//   //     selectedIndex: navigationShell.currentIndex,
//   //     onDestinationSelected: _goBranch,
//   //   );
//   // }
// //}

// // enum Tabs { home, two, three }

// // class ScaffoldWithNavigationBar extends StatelessWidget {
// //   const ScaffoldWithNavigationBar({
// //     super.key,
// //     required this.body,
// //     required this.selectedIndex,
// //     required this.onDestinationSelected,
// //   });

// //   final Widget body;
// //   final int selectedIndex;
// //   final ValueChanged<int> onDestinationSelected;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       key: rootScaffoldKey,
// //       body: const FlutterLogo(),
// //       bottomNavigationBar: BottomAppBar(
// //         height: 80.sp,
// //         color: Colors.white,
// //         child: Row(
// //           mainAxisSize: MainAxisSize.max,
// //           children: Tabs.values
// //               .map(
// //                 (e) => Expanded(
// //                   child: InkWell(
// //                     splashColor: Colors.transparent,
// //                     highlightColor: Colors.transparent,
// //                     onTap: () => onDestinationSelected(e.index),
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.center,
// //                       children: [
// //                         (e.index == selectedIndex
// //                                 ? '${e.name}_active'
// //                                 : '${e.name}_inactive')
// //                             .svgPicture(
// //                           width: 24.sp,
// //                           height: 24.sp,
// //                           fit: BoxFit.fill,
// //                         ),
// //                         4.h.heightBox,
// //                         e.name.toTitleCase().toText(
// //                               translate: false,
// //                               style: context.typography.dynamicStyle(
// //                                 fontSize: 10.sp,
// //                                 height: 13.2 / 12,
// //                                 color: e.index == selectedIndex
// //                                     ? context.colors.xDSCNeutral12
// //                                     : context.colors.xDSCNeutral7,
// //                               ),
// //                             ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               )
// //               .toList(),
// //         ).paddingAll(16),
// //       ),
// //     );
// //   }
// // }




// // GoRoute(
// //       path: '/',
// //       builder: (BuildContext context, GoRouterState state) {
// //         return const HomeScreen();
// //       },
// //     ),
// //  
   
// //  
