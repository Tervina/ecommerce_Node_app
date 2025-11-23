import 'package:ecommerce_flutter_app/features/product/data/services/contact_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'contact_event.dart';
import 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactService service;

  ContactBloc(this.service) : super(ContactInitial()) {
    on<SendContactEvent>((event, emit) async {
      emit(ContactLoading());

      try {
        final result = await service.sendContactMessage(
          name: event.name,
          email: event.email,
          phone: event.phone,
          message: event.message,
        );

        if (result) {
          emit(ContactSuccess());
        } else {
          emit(ContactFailure("Failed to send email"));
        }
      } catch (e) {
        emit(ContactFailure(e.toString()));
      }
    });
  }
}
