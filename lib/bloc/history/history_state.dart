part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class LoadingHistory extends HistoryState {}

class LoadedHistory extends HistoryState {
  final List<TransactionHistory> transactionHistory;

  const LoadedHistory({required this.transactionHistory});
}
class LoadingHistoryError extends HistoryState {}
