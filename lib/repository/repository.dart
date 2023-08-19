import 'package:bank_pick/Database/firebase.dart';
import 'package:bank_pick/Model/user.dart';

import '../shared_preferences/session_manager.dart';

class Repository {
  RemoteDatabase database = RemoteDatabase();
  final sharedPrefernce = SessionManager();
  Future<User> getUser(String uid) async {
    return await database.getUser(uid);
  }

}
