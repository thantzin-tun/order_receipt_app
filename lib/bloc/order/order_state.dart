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
  final double totalTax;
  final String taxNames;
  final double totalDiscount;
  final String discountNames;
  const OrderSuccessState(this.order,{required this.totalTax,required this.taxNames,required this.totalDiscount, required this.discountNames});
  @override
  List<Object> get props => [order];
}

class OrderErrorState extends OrderState {}
