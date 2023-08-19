part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class InitiateTransactionEvent extends TransactionEvent {
  final String userEmail;
  final num senderBalance;
  final String email;
  final String description;
  final num amount;
  const InitiateTransactionEvent(
      {required this.userEmail,
      required this.senderBalance,
      required this.amount,
      required this.description,
      required this.email});

  @override
  List<Object> get props => [];
}

// class GetBeneficiaryEvent extends TransactionEvent {}
