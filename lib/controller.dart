import 'package:bank_pick/Model/request_model.dart';
import 'package:bank_pick/Model/transaction_history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Model/beneficiary.dart';
import 'Model/recipient_request.dart';

class Controller {
  static Future<List<Beneficiary>> fetchBeneficiaries(
      String uid, String userEmail) async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('beneficiary')
          .doc(uid)
          .collection('beneficiaries')
          .get();

      final List<Beneficiary> beneficiaries = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>?;

        if (data != null) {
          final email = data['email'] as String?;
          final name = data['name'] as String?;
          final initials = data['initials'] as String?;

          if (email != null && name != null && initials != null) {
            return Beneficiary(
              email: email,
              name: name,
              initials: initials,
            );
          } else {
            throw Exception('Invalid beneficiary data');
          }
        } else {
          throw Exception('No data available for the document');
        }
      }).toList();
      print(beneficiaries);
      return beneficiaries;
    } catch (error) {
      print('Error fetching beneficiaries: $error');
      return [];
    }
  }

  static Future<List<TransactionHistory>> fetchTransactionHistory(
      String uid, String userEmail) async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('transactions')
          .doc(uid)
          .collection('user_transactions')
          .get();

      final List<TransactionHistory> history = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>?;

        if (data != null) {
          final email = data['email'] as String?;
          final name = data['name'] as String?;
          final amount = data['amount'] as double?;
          final description = data['description'] as String?;
          final transactionTime = DateTime.parse(data['transactionTime']);
          final type = data['type'] as String?;

          if (email != null && name != null) {
            return TransactionHistory(
                email: email,
                name: name,
                type: type,
                amount: amount!,
                description: description!,
                transactionTime: transactionTime);
          } else {
            throw Exception('Invalid beneficiary data');
          }
        } else {
          throw Exception('No data available for the document');
        }
      }).toList();

      print(history);
      return history;
    } catch (error) {
      print('Error fetching beneficiaries: $error');
      return [];
    }
  }

 

static Future<List<RequestModel>> fetchUserRequests(
    String uid) async {
  try {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('requests')
        .doc(uid)
        .collection('user_requests')
        .get();

    final List<RequestModel> requests = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>?;

      if (data != null) {
        return RequestModel.fromJson(data);
      } else {
        throw Exception('No data available for the document');
      }
    }).toList();

    print(requests);
    return requests;
  } catch (error) {
    print('Error fetching requests: $error');
    return [];
  }
}

static Future<List<RecipientRequest>> fetchPendingRequests(
    String uid) async {
  try {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('transactions')
        .doc(uid)
        .collection('pending_requests')
        .get();

    final List<RecipientRequest> pendingRequests = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>?;

      if (data != null) {
        return RecipientRequest.fromJson(data);
      } else {
        throw Exception('No data available for the document');
      }
    }).toList();

    print(pendingRequests);
    return pendingRequests;
  } catch (error) {
    print('Error fetching pending requests: $error');
    return [];
  }
}



  // static Future<List<TransactionHistory>> fetchSortedTransactions(
  //     String uid, String userEmail,
  //     {bool ascending = true}) async {
  //   try {
  //     final QuerySnapshot snapshot = await FirebaseFirestore.instance
  //         .collection('transactions')
  //         .doc(uid)
  //         .collection(userEmail)
  //         .orderBy('transactionTime',
  //             descending:
  //                 !ascending) // Sort by transactionTime in ascending or descending order
  //         .get();
  //     print(snapshot.docs.length);
  //     final List<TransactionHistory> transactions = snapshot.docs.map((doc) {
  //       print(doc);
  //       return TransactionHistory.fromJson(doc.data() as Map<String, dynamic>);
  //     }).toList();
  //     print(transactions);
  //     return transactions;
  //   } catch (error) {
  //     print('Error fetching sorted transactions: $error');
  //     return [];
  //   }
  // }
static Future<bool> isPinNull(String userId) async {
  try {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    final userData = snapshot.data();
    final pin = userData?['pin'] as String?;

    return pin == null;
  } catch (e) {
    print('Error checking pin field: $e');
    return false; 
  }
}
  
}
