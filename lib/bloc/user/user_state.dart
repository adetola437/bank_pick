part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];

  num? get getBalance => null;
  String? get getName => null;
  String? get userEmail {
    return null;
  }
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoadingError extends UserState {}

class UserSetPin extends UserState {
   User user;
   UserSetPin({required this.user});
}

class UserLoaded extends UserState {
  final User user;
  const UserLoaded(this.user);

  @override
  List<Object> get props => [];

  @override
  num get getBalance => user.balance;
  @override
  String get userEmail => user.email;
  @override
  String get getName => user.name;
}
