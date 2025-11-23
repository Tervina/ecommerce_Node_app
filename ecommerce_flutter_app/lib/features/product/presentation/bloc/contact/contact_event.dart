import 'package:equatable/equatable.dart';

abstract class ContactEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendContactEvent extends ContactEvent {
  final String name;
  final String email;
  final String phone;
  final String message;

  SendContactEvent({
    required this.name,
    required this.email,
    required this.phone,
    required this.message,
  });

  @override
  List<Object?> get props => [name, email, phone, message];
}
