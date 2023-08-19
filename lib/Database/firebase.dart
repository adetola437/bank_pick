import 'dart:convert';

import 'package:bank_pick/Model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class RemoteDatabase {
  Future<void> sendPushNotification(
      String deviceToken, String title, String body) async {
    const url =
        'https://fcm.googleapis.com/v1/projects/bankpick-1a20b/messages:send';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ya29.a0AbVbY6M1g1NNg7ktCfuFeryM_iI3i4uR7xt_bYktwzzXahrmT2Bxgcw30NN58QRnVyMeviduKYJ5qX8LnsqMjt6n2f4UY0LD5HxTgbe8BSgOFWHmbWbtSEVL8DWKqpueaemHGirJoGy27ESwQ_6YGdRzWEr7aCgYKAWASARASFQFWKvPlZeOg-TIGsCHuED_u0IXQ7g0163',
    };

    final message = {
      'message': {
        'token': deviceToken,
        'notification': {
          'title': title,
          'body': body,
        },
      },
    };

    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(message));

    if (response.statusCode == 200) {
      print('Push notification sent successfully.');
    } else {
      print('Failed to send push notification. Error: ${response.body}');
    }
  }

  Future<User> getUser(String uid) async {
    // String? uid = await sharedPrefernce.getUid();

    final CollectionReference reference =
        FirebaseFirestore.instance.collection('users');
    final data = await reference.doc(uid).get();
    data.data();
    return User.fromJson(data.data() as Map<String, dynamic>);
  }
}
