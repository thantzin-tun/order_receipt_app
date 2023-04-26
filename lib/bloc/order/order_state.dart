part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrderSuccessState extends OrderState {
  final Order order;
  OrderSuccessState(this.order);
  @override
  List<Object> get props => [order];
}

class OrderErrorState extends OrderState {}
