import 'package:bank_pick/Model/recipient_request.dart';
import 'package:bank_pick/Model/request_model.dart';
import 'package:bank_pick/controller.dart';
import 'package:bank_pick/shared_preferences/session_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  RequestBloc() : super(RequestInitial()) {
    on<RequestEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SaveRequestEvent>(
      (event, emit) => saveRequest(event, emit),
    );
    on<GetUserRequestEvent>(
      (event, emit) => getUserRequests(event, emit),
    );
    on<AcceptRequestEvent>(
      (event, emit) => acceptRequest(event, emit),
    );
    on<RejectRequestEvent>(
      (event, emit) => rejectRequest(event, emit),
    );
  }
}

saveRequest(SaveRequestEvent event, emit) async {
  emit(const RequestLoading(recipietRequests: []));
  SessionManager manager = SessionManager();
  String? userUid = await manager.getUid();
  String? name = await manager.getName();
  emit(const RequestLoading(recipietRequests: []));

  RequestModel userRequest = RequestModel(
      email: event.email,
      amount: event.amount,
      description: event.description,
      name: event.name,
      time: DateTime.now(),
      status: 'Pending');
  RecipientRequest recipientRequest = RecipientRequest(
      senderUid: userUid!,
      email: event.email,
      amount: event.amount,
      description: event.description,
      name: event.name,
      time: DateTime.now(),
      status: 'Pending',
      requestId: '');
  saveMyRequest(recipientRequest, userRequest, userUid);
  List<RequestModel> requests = await Controller.fetchUserRequests(userUid);
  List<RecipientRequest> recipientRequests =
      await Controller.fetchPendingRequests(userUid);
  emit(RequestSuccessful(
      requests: requests, recipietRequests: recipientRequests));
  // saveUserRequest(request, userUid!);
  // saveRequestTo(request, request.email);
  //emit(RequestLoaded(requests: requests))
}

// void saveUserRequest(RequestModel request, String uid) async {
//   try {
//     final CollectionReference transactionCollection =
//         FirebaseFirestore.instance.collection('requests');

//     final DocumentReference userDocument = transactionCollection.doc(uid);

//     final CollectionReference userTransactionCollection =
//         userDocument.collection('user_requests');

//     // Add the transaction to the user's transaction subcollection
//     await userTransactionCollection.add(request.toJson());

//     print('My request saved successfully!');
//   } catch (error) {
//     print('Error saving my request: $error');
//   }
// }

// void saveRequestTo(RequestModel request, String email) async {
//   try {
//     final uid = await getCreditUid(email);
//     final CollectionReference transactionCollection =
//         FirebaseFirestore.instance.collection('transactions');

//     final DocumentReference userDocument = transactionCollection.doc(uid);

//     final CollectionReference userTransactionCollection =
//         userDocument.collection('pending_requests');

//     // Add the transaction to the user's transaction subcollection
//     await userTransactionCollection.add(request.toJson());

//     print('pending request saved successfully!');
//   } catch (error) {
//     print('Error saving pending request: $error');
//   }
// }

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

void saveMyRequest(
    RecipientRequest recipient, RequestModel request, String senderUid) async {
  try {
    String uid = await getCreditUid(request.email);
    CollectionReference senderCollection = FirebaseFirestore.instance
        .collection('requests')
        .doc(senderUid)
        .collection('user_requests');

    CollectionReference recipientCollection = FirebaseFirestore.instance
        .collection('transactions')
        .doc(uid)
        .collection('pending_requests');

    DocumentReference docRef = await senderCollection.add(request.toJson());

    // Access the generated document ID
    String requestId = docRef.id;
    recipient.requestId = docRef.id;
    print('Request saved with ID: $requestId');

    // Save the same request with the same ID to the recipient's collection
    await recipientCollection.doc(requestId).set(recipient.toJson());

    print('Request also saved in recipient\'s collection');
  } catch (error) {
    print('Error saving request: $error');
  }
}

getUserRequests(GetUserRequestEvent event, emit) async {
  emit(const RequestLoading(recipietRequests: []));
  SessionManager manager = SessionManager();
  String? userUid = await manager.getUid();
  List<RequestModel> requests = await Controller.fetchUserRequests(userUid!);
  List<RecipientRequest> recipientRequests =
      await Controller.fetchPendingRequests(userUid);
  emit(RequestSuccessful(
      requests: requests..sort((a, b) => b.time.compareTo(a.time)),
      recipietRequests: recipientRequests
        ..sort((a, b) => b.time.compareTo(a.time))));
}

acceptRequest(AcceptRequestEvent event, emit) async {
  emit(RequestLoading(recipietRequests: event.requests ?? []));
  SessionManager manager = SessionManager();
  String? userUid = await manager.getUid();
  try {
    final DocumentReference userRef = FirebaseFirestore.instance
        .collection('transactions')
        .doc(userUid)
        .collection('pending_requests')
        .doc(event.requestId);
    final DocumentReference senderRef = FirebaseFirestore.instance
        .collection('requests')
        .doc(event.senderId)
        .collection('user_requests')
        .doc(event.requestId);
    final senderSnapshot =
        FirebaseFirestore.instance.collection('users').doc(event.senderId);

    final recipientSnapshot =
        FirebaseFirestore.instance.collection('users').doc(userUid);

    final senderDoc = await senderSnapshot.get();
    final recipientDoc = await recipientSnapshot.get();

    final senderData = senderDoc.data();
    final recipientData = recipientDoc.data();

    if (senderData != null && recipientData != null) {
      final senderBalance = senderData['balance'] as num;
      final recipientBalance = recipientData['balance'] as num;

      if (recipientBalance >= event.amount) {
        // Deduct requested amount from sender's balance
        final updatedSenderBalance = senderBalance + event.amount;

        // Add accepted amount to recipient's balance
        final updatedRecipientBalance = recipientBalance - event.amount;

        // Update sender's balance
        await senderSnapshot.update(
          {'balance': updatedSenderBalance},
        );

        // Update recipient's balance
        await recipientSnapshot.update(
          {'balance': updatedRecipientBalance},
        );

        // List<RequestModel> requests =
        //     await Controller.fetchUserRequests(userUid!);
        // List<RecipientRequest> recipientRequests =
        //     await Controller.fetchPendingRequests(userUid);
        await userRef.update({'status': 'Accepted'});
        await senderRef.update({'status': 'Accepted'});
        List<RequestModel> requests =
            await Controller.fetchUserRequests(userUid!);
        List<RecipientRequest> recipientRequests =
            await Controller.fetchPendingRequests(userUid);
        emit(RequestSuccessful(
            requests: requests..sort((a, b) => b.time.compareTo(a.time)),
            recipietRequests: recipientRequests
              ..sort((a, b) => b.time.compareTo(a.time))));
        print('Balances updated successfully!');
      } else {
        emit(RequestError(error: 'Insufficient Balance'));
      }
    }
  } catch (e) {
    print(e);
  }
}

rejectRequest(RejectRequestEvent event, emit) async {
  emit(RequestLoading(recipietRequests: event.requests ?? []));
  SessionManager manager = SessionManager();
  String? userUid = await manager.getUid();
  try {
    final DocumentReference userRef = FirebaseFirestore.instance
        .collection('transactions')
        .doc(userUid)
        .collection('pending_requests')
        .doc(event.requestId);
    final DocumentReference senderRef = FirebaseFirestore.instance
        .collection('requests')
        .doc(event.senderId)
        .collection('user_requests')
        .doc(event.requestId);
    await userRef.update({'status': 'Rejected'});
    await senderRef.update({'status': 'Rejected'});
    // final senderSnapshot =
    //     FirebaseFirestore.instance.collection('users').doc(event.senderId);

    // final recipientSnapshot =
    //     FirebaseFirestore.instance.collection('users').doc(userUid);
    // await senderSnapshot.update({'status': 'Rejected'});
    // await recipientSnapshot.update({'status': 'Rejected'});
    List<RequestModel> requests = await Controller.fetchUserRequests(userUid!);
    List<RecipientRequest> recipientRequests =
        await Controller.fetchPendingRequests(userUid);

    emit(RequestSuccessful(
        requests: requests..sort((a, b) => b.time.compareTo(a.time)),
        recipietRequests: recipientRequests
          ..sort((a, b) => b.time.compareTo(a.time))));
    print('successful');
  } catch (e) {
    print(e);
  }
}
