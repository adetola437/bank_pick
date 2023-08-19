import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Screens/splash_screen.dart';
import 'bloc/autthentication/authentication_bloc.dart';
import 'bloc/beneficiary/beneficiary_bloc.dart';
import 'bloc/history/history_bloc.dart';
import 'bloc/request/request_bloc.dart';
import 'bloc/transaction/transaction_bloc.dart';
import 'bloc/user/user_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.getInitialMessage();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(),
          ),
          BlocProvider<TransactionBloc>(
            create: (context) => TransactionBloc(),
          ),
          BlocProvider<HistoryBloc>(
            create: (context) => HistoryBloc(),
          ),
          BlocProvider<BeneficiaryBloc>(
            create: (context) => BeneficiaryBloc(),
          ),
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(),
          ),
          BlocProvider<RequestBloc>(
            create: (context) => RequestBloc(),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => const MaterialApp(
            home: SplashScreen(),
          ),
        ));
  }
}

// class MyBlocObserver extends BlocObserver {
//   @override
//   void onEvent(Bloc bloc, Object? event) {
//     log('on Event $event fired');
//     super.onEvent(bloc, event);
//   }

//   @override
//   void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
//     log('on Error: $error fired');

//     super.onError(bloc, error, stackTrace);
//   }

//   @override
//   void onChange(BlocBase bloc, Change change) {
//     log('on Change: current state: ${change.currentState}, next state: ${change.nextState}');
//     super.onChange(bloc, change);
//   }

//   @override
//   void onTransition(Bloc bloc, Transition transition) {
//     log('onTransition: current state: ${transition.currentState}, next state: ${transition.nextState}');
//     super.onTransition(bloc, transition);
//   }
// }
