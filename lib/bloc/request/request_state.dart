part of 'request_bloc.dart';

abstract class RequestState extends Equatable {
  const RequestState();

  @override
  List<Object> get props => [];

  List<RecipientRequest> requestList() => [];
}

class RequestInitial extends RequestState {}

class RequestLoading extends RequestState {
  final List<RecipientRequest> recipietRequests;

  const RequestLoading({required this.recipietRequests});
}

class RequestSuccessful extends RequestState {
  List<RequestModel> requests;
  List<RecipientRequest> recipietRequests;
  RequestSuccessful({required this.requests, required this.recipietRequests});
  @override
  List<Object> get props => [requests];

  @override
  List<RecipientRequest> requestList() => recipietRequests;
}

class RequestError extends RequestState {
  String error;
  RequestError({required this.error});
  @override
  List<Object> get props => [error];
}

// class UserRequestLoaded extends RequestState {
//   List<RequestModel> requests;
//   UserRequestLoaded({required this.requests});
//   @override
//   List<Object> get props => [requests];
// }
