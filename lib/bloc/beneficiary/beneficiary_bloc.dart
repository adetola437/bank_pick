import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../Model/beneficiary.dart';
import '../../controller.dart';
import '../../shared_preferences/session_manager.dart';

part 'beneficiary_event.dart';
part 'beneficiary_state.dart';

class BeneficiaryBloc extends Bloc<BeneficiaryEvent, BeneficiaryState> {
  BeneficiaryBloc() : super(BeneficiaryInitial()) {
    on<BeneficiaryEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetBeneficiaryEvent>(
      (event, emit) => getBeneficiary(event, emit),
    );
  }
}

getBeneficiary(GetBeneficiaryEvent event, emit) async {
  emit(LoadingBeneficiary());
  SessionManager session = SessionManager();
  String? uid = await session.getUid();
  String? userEmail = await session.getEmail();
  List<Beneficiary> beneficiary =
      await Controller.fetchBeneficiaries(uid!, userEmail!);
  emit(BeneficiarySuccessful(beneficiary: beneficiary));
}
