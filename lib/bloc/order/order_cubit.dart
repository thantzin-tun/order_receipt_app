import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:order_flutter/model/order/order_model.dart';
import 'package:order_flutter/repository/order_repository.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {

  final OrderRepository orderRepository;
  OrderCubit(this.orderRepository) : super(OrderInitial());

  void getOrder() {
    emit(OrderInitial());
    orderRepository
        .getOrder()
        .then((value) => 
        emit(OrderSuccessState(value)))
        .catchError((error) => print("Try again"));
  }

}
