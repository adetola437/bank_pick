import 'package:bank_pick/Database/firebase.dart';
import 'package:bank_pick/Model/user.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../shared_preferences/session_manager.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetUserEvent>(
      (event, emit) => _getUser(event, emit),
    );
    on<AddPinEvent>(
      (event, emit) => _addPin(event, emit),
    );
    on<CheckTokenEvent>(
      (event, emit) => _checkToken(event, emit),
    );
  }
}

_checkToken(CheckTokenEvent event, emit) async {
  try {
    final sharedPrefernce = SessionManager();
    RemoteDatabase database = RemoteDatabase();
    String? uid = await sharedPrefernce.getUid();
    String? token = await sharedPrefernce.getMessagingToken();
    User user = await database.getUser(uid!);

    //print(user.token);
    if (user.token != token || user.token == null) {
      final DocumentReference userRef2 =
          FirebaseFirestore.instance.collection('users').doc(uid);

      // Get the existing balance from the document

      await userRef2.update({'token': token});
    }
  } catch (e) {}
}

_getUser(GetUserEvent event, emit) async {
  emit(UserLoading());
  try {
    final sharedPrefernce = SessionManager();
    RemoteDatabase database = RemoteDatabase();
    String? uid = await sharedPrefernce.getUid();
    User user = await database.getUser(uid!);

    print(user.balance);
    if (user.pin != 0 || user.pin == null) {
      emit(UserLoaded(user));
    } else {
      emit(UserSetPin(user: user));
    }
  } catch (e) {
    print(e);
    emit(UserLoadingError());
  }
}
// _addTOPaystack(GetUserEvent event, emit)async{
//   Paystack pay = Paystack();
//   pay.addCustomerToPaystack(event.email, event.name);

// }
_addPin(AddPinEvent event, emit) async {
  emit(UserLoading());
  final sharedPrefernce = SessionManager();
  String? uid = await sharedPrefernce.getUid();
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(event.user.toJson());
    emit(UserLoaded(event.user));
    print(event.user.pin);
  } catch (e) {
    emit(UserLoadingError());
    print(e);
  }
}
