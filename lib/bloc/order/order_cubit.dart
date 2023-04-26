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

    orderRepository.getOrder().then((value) {
      //For Tax Information
      List<String> taxNames = [];
      double totalTax = 0.0;
      for (var tax in value.order.footer.tax) {
        totalTax += tax.tax_amount;
      }
      for (var tax in value.order.footer.tax) {
        taxNames.add(tax.tax_name);
      }
      String taxNameList = taxNames.join(" + ");


      // Discount Information
       double totalDiscount = 0.0;
      for (var d in value.order.footer.discount) {
        totalDiscount += value.order.footer.sub_total * d.rate / 100;
      }
      List<String> discountNames = [];
      for (var d in value.order.footer.discount) {
        discountNames.add(d.discount_name);
      }
      String discountNameList = discountNames.join(" + ");

      emit(OrderSuccessState(value,totalTax: totalTax,taxNames: taxNameList,discountNames: discountNameList,totalDiscount: totalDiscount));
    }).catchError((error) => print("Try again"));
  }
}
