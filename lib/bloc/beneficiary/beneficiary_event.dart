part of 'beneficiary_bloc.dart';

abstract class BeneficiaryEvent extends Equatable {
  const BeneficiaryEvent();

  @override
  List<Object> get props => [];
}
class GetBeneficiaryEvent extends BeneficiaryEvent {}