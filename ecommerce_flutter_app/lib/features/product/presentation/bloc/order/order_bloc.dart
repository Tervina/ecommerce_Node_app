// lib/presentation/bloc/order/order_bloc.dart
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/order_repository.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository repository;

  OrderBloc(this.repository) : super(OrderInitial()) {
    on<LoadOrders>((event, emit) async {
      emit(OrderLoading());
      try {
        final orders = await repository.getOrders(event.token);
        emit(OrderLoaded(orders));
      } catch (e) {
        emit(OrderError(e.toString()));
      }
    });

    // on<CreateOrderEvent>((event, emit) async {
    //   emit(OrderLoading());
    //   try {
    //     final order =
    //         await repository.createOrder(event.orderData, event.token);
    //     emit(OrderCreated(order));
    //   } catch (e) {
    //     emit(OrderError(e.toString()));
    //   }
    // });

    on<CreateOrderEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        final order =
            await repository.createOrder(event.orderData, event.token);
        emit(OrderCreated(order));
      } catch (e) {
// 💡 Change 1: Handle error safely to avoid the 'null is not a subtype of String' error
        String errorMessage = "An unknown error occurred.";
        if (e is DioError) {
          // Attempt to get the error message from the server response body
          errorMessage = (e.response?.data?['error'] as String? ?? e.message)!;
        } else {
          errorMessage = e.toString();
        }
        emit(OrderError(errorMessage));
      }
    });
  }
}
