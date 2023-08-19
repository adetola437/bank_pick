part of 'request_bloc.dart';

abstract class RequestEvent extends Equatable {
  const RequestEvent();

  @override
  List<Object> get props => [];
}

class SaveRequestEvent extends RequestEvent {
  final String email;
  final String name;
  final String description;
  final num amount;

  const SaveRequestEvent(
      {required this.amount,
      required this.description,
      required this.email,
      required this.name});
  @override
  List<Object> get props => [];
}

class GetUserRequestEvent extends RequestEvent {}

class AcceptRequestEvent extends RequestEvent {
  final String requestId;
  final String senderId;
  final num amount;

  final List<RecipientRequest>? requests;

  const AcceptRequestEvent({
    required this.amount,
    required this.senderId,
    required this.requestId,
    this.requests,
  });
  @override
  List<Object> get props => [];
}

class RejectRequestEvent extends RequestEvent {
  final String requestId;
  final String senderId;  
  final List<RecipientRequest>? requests;


  const RejectRequestEvent({required this.senderId, required this.requestId,    this.requests,
});
  @override
  List<Object> get props => [];
}
