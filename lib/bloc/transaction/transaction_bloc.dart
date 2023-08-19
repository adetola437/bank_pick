import 'package:bank_pick/Database/firebase.dart';
import 'package:bank_pick/Model/beneficiary.dart';
import 'package:bank_pick/shared_preferences/session_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../Model/transaction_history.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial()) {
    on<TransactionEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<InitiateTransactionEvent>(
      (event, emit) => initiateTransaction(event, emit),
    );
    // on<GetBeneficiaryEvent>(
    //   (event, emit) => getBeneficiary(event, emit),
    // );
  }
}

initiateTransaction(InitiateTransactionEvent event, emit) async {
  emit(TransactionLoading());
  // Paystack pay = Paystack();
  // //pay.initiateTransfer(event.email, event.amount, event.description);
  // pay.createTransferRecipient(event.email, 'name');
  // pay.initiateTransfer(event.amount, event.description);
  late Beneficiary ben;
  late TransactionHistory transactionHistory;
  late TransactionHistory creditTransaction;
  SessionManager session = SessionManager();
  RemoteDatabase remoteDatabase = RemoteDatabase();
  String? uid = await session.getUid();
  String? token = await session.getMessagingToken();

  try {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: event.email)
        .get();
    final QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: event.userEmail)
        .get();

    final List<QueryDocumentSnapshot> documents = snapshot.docs;
    final List<QueryDocumentSnapshot> userDocuments = userSnapshot.docs;
    if (documents.isEmpty) {
      emit(const TransactionError(error: 'Email does not exists'));
    } else {
      for (final doc in documents) {
        final String userId = doc.id;
        final DocumentReference userRef =
            FirebaseFirestore.instance.collection('users').doc(userId);

        // Get the existing balance from the document
        final DocumentSnapshot userSnapshot = await userRef.get();
        //print(userSnapshot.get('balance'));
        final double existingBalance = userSnapshot.get('balance').toDouble();
        if (event.email != event.userEmail) {
          if (event.amount < event.senderBalance) {
            if (event.amount > 0) {
              final double newBalance = existingBalance + event.amount;

              // Update the balance field
              await userRef.update({'balance': newBalance});
              for (final docs in userDocuments) {
                final String userId = docs.id;
                final DocumentReference userRef2 =
                    FirebaseFirestore.instance.collection('users').doc(userId);

                // Get the existing balance from the document
                final DocumentSnapshot userSnapshot2 = await userRef2.get();
                //print(userSnapshot.get('balance'));
                final double existingBalance =
                    userSnapshot2.get('balance').toDouble();
                final double newBalance = existingBalance - event.amount;

                // Update the balance field
                await userRef2.update({'balance': newBalance});
                String receiverFullName = userSnapshot.get('name');
                String userFullName = userSnapshot2.get('name');
                List<String> nameParts = receiverFullName.split(' ');

                final String firstName = nameParts[0];
                final String lastName =
                    nameParts.length > 1 ? nameParts[1] : '';
                final String in1 = firstName[0];
                final String in2 = nameParts.length > 1 ? lastName[0] : '';
                ben = Beneficiary(
                    email: event.email,
                    initials: (in1 + in2).toUpperCase(),
                    name: receiverFullName);
                transactionHistory = TransactionHistory(
                    transactionTime: DateTime.now(),
                    amount: event.amount,
                    description: event.description,
                    email: event.email,
                    name: receiverFullName);
                creditTransaction = TransactionHistory(
                    amount: event.amount,
                    description: event.description,
                    email: event.userEmail,
                    transactionTime: DateTime.now(),
                    type: 'credit',
                    name: userFullName);
                saveBeneficiary(ben, uid!);
                saveTransactionHistory(transactionHistory, uid);
                saveCreditTransactionHistory(creditTransaction, event.email);
              }
              remoteDatabase.sendPushNotification(token!, 'Debit',
                  'You have Successfully sent ${event.amount} to ${event.email}');
              String creditToken = await getCreditDeviceToken(event.email);
              print(creditToken);
              remoteDatabase.sendPushNotification(creditToken, 'Credit',
                  'You have Successfully Received ${event.amount}\$ from ${event.userEmail}');

              emit(const TransactionSuccessful(history: []));
            } else {
              emit(const TransactionError(error: 'Enter a valid amount!'));
            }
          } else {
            emit(const TransactionError(error: 'Insufficient Balance'));
          }
        } else {
          emit(const TransactionError(error: 'Receiver cannot be You!'));
        }

        // Calculate the new balance
      }
    }
  } catch (e) {
    emit(TransactionError(error: '$e'));
  }
}

void saveBeneficiary(Beneficiary beneficiary, String uid) async {
  try {
    final String beneficiaryId =
        beneficiary.email; // Use the email as the unique identifier

    await FirebaseFirestore.instance
        .collection('beneficiary')
        .doc(uid)
        .collection('beneficiaries')
        .doc(beneficiaryId)
        .set(beneficiary.toJson());

    print('Beneficiary saved successfully!');
  } catch (error) {
    print('Error saving beneficiary: $error');
  }
}

Future<String> getCreditUid(String email) async {
  String? uid;
  final QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: email)
      .get();
  final QuerySnapshot userSnapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: email)
      .get();
  final List<QueryDocumentSnapshot> documents = snapshot.docs;
  for (final doc in documents) {
    final String userId = doc.id;
    final DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(userId);
    final DocumentSnapshot userSnapshot = await userRef.get();
    //print(userSnapshot.get('balance'));
    uid = userSnapshot.get('uid');
  }
  return uid!;
}

Future<String> getCreditDeviceToken(String email) async {
  String? token;
  final QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: email)
      .get();
  final QuerySnapshot userSnapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: email)
      .get();
  final List<QueryDocumentSnapshot> documents = snapshot.docs;
  for (final doc in documents) {
    final String userId = doc.id;
    final DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(userId);
    final DocumentSnapshot userSnapshot = await userRef.get();
    //print(userSnapshot.get('balance'));
    token = userSnapshot.get('token');
  }
  return token!;
}

void saveTransactionHistory(TransactionHistory transaction, String uid) async {
  try {
    final CollectionReference transactionCollection =
        FirebaseFirestore.instance.collection('transactions');

    final DocumentReference userDocument = transactionCollection.doc(uid);

    final CollectionReference userTransactionCollection =
        userDocument.collection('user_transactions');

    // Add the transaction to the user's transaction subcollection
    await userTransactionCollection.add(transaction.toJson());

    print('Transaction saved successfully!');
  } catch (error) {
    print('Error saving transaction: $error');
  }
}

void saveCreditTransactionHistory(
    TransactionHistory transaction, String email) async {
  try {
    final uid = await getCreditUid(email);
    final CollectionReference transactionCollection =
        FirebaseFirestore.instance.collection('transactions');

    final DocumentReference userDocument = transactionCollection.doc(uid);

    final CollectionReference userTransactionCollection =
        userDocument.collection('user_transactions');

    // Add the transaction to the user's transaction subcollection
    await userTransactionCollection.add(transaction.toJson());

    print('Transaction saved successfully!');
  } catch (error) {
    print('Error saving transaction: $error');
  }
}


// getBeneficiary(GetBeneficiaryEvent event, emit) async {
//   emit(LoadingBeneficiary());
//   SessionManager session = SessionManager();
//   String? uid = await session.getUid();
//   String? userEmail = await session.getEmail();
//   List<Beneficiary> beneficiary =
//       await Controller.fetchBeneficiaries(uid!, userEmail!);
//   emit(GetBeneficiary(beneficiary: beneficiary));
// }
