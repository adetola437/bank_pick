part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionSuccessful extends TransactionState {
  final List<TransactionHistory> history;
  const TransactionSuccessful({required this.history});

  @override
  List<Object> get props => [history];
}

class TransactionError extends TransactionState {
  final String error;
  const TransactionError({required this.error});

  @override
  List<Object> get props => [];
}
// class LoadingBeneficiary extends TransactionState{}
// class GetBeneficiary extends TransactionState {
//   final List<Beneficiary> beneficiary;
//   const GetBeneficiary({required this.beneficiary});
//   @override
//   List<Object> get props => [beneficiary];
// }
