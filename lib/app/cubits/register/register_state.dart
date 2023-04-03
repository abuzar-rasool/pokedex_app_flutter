part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}


class RegisterLoading extends RegisterState {}

class RegisterSucess extends RegisterState {}

class RegisterFailure extends RegisterState {
  final String errorMessage;
  const RegisterFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}