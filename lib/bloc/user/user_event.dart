part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserEvent extends UserEvent {}
class CheckTokenEvent extends UserEvent {}

class AddPinEvent extends UserEvent {
  User user;
  AddPinEvent({required this.user});
}

class AddUserToPaystackEvent extends UserEvent {
  final String email;
  final String name;
  const AddUserToPaystackEvent({required this.email, required this.name});

  @override
  List<Object> get props => [];
}
