import 'package:bank_pick/controller.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../Model/transaction_history.dart';
import '../../shared_preferences/session_manager.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial()) {
    on<HistoryEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetHistoryEvent>(
      (event, emit) => getHistory(event, emit),
    );
  }
}

getHistory(GetHistoryEvent event, emit) async {
  emit(LoadingHistory());
  SessionManager session = SessionManager();
  String? uid = await session.getUid();
  String? userEmail = await session.getEmail();
  List<TransactionHistory> transactionHistory =
      await Controller.fetchTransactionHistory(uid!, userEmail!);
  emit(LoadedHistory(
      transactionHistory: transactionHistory
        ..sort((a, b) => b.transactionTime!.compareTo(a.transactionTime!))));

  // emit(LoadedHistory(transactionHistory: transactionHistory.sort((a,b)=>b.transactionTime.compareTo(a.transactionTime!))));
}
