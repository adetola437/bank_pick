// import 'package:easy_localization/easy_localization.dart';

// // import 'package:flutter_dotenv/flutter_dotenv.dart';

// import 'config/di/app_initializer.dart';
// // import 'config/flavor/flavor.dart';
// import 'core/core.dart';
// import 'mapx_app.dart';


// void main() async {
  
//   await AppInitializer.initGetIt();
//   // await dotenv.load(fileName: "assets/.env");
//   // BuildFlavor.init(
//   //   flavor: Flavor.debug,
//   //   baseUrl: dotenv.env['STAGING_URL']??'',
//   //   appName: dotenv.env['APP_NAME_TEST']??'',
//   //   encKey: dotenv.env['OMS_ENC_KEY_STAGING']??'',
//   //   vector: dotenv.env['OMS_VECTOR_KEY_STAGING']??'',
//   // );
//   runApp(
//     EasyLocalization(
//       supportedLocales: const [Locale('en')],
//       path: 'assets/translations',
//       fallbackLocale: const Locale('en'),
//       child: const MapXApp(),
//     ),
//   );
//   //FlutterNativeSplash.remove();
// }
