part of 'beneficiary_bloc.dart';

abstract class BeneficiaryState extends Equatable {
  const BeneficiaryState();
  
  @override
  List<Object> get props => [];
}

class BeneficiaryInitial extends BeneficiaryState {}
class LoadingBeneficiary extends BeneficiaryState{}
class BeneficiarySuccessful extends BeneficiaryState {
  final List<Beneficiary> beneficiary;
  const BeneficiarySuccessful({required this.beneficiary});
  @override
  List<Object> get props => [beneficiary];
}
class BeneficiaryError extends BeneficiaryState{}
