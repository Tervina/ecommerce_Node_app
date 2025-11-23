import 'package:equatable/equatable.dart';

abstract class ContactState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactSuccess extends ContactState {}

class ContactFailure extends ContactState {
  final String error;
  ContactFailure(this.error);

  @override
  List<Object?> get props => [error];
}
