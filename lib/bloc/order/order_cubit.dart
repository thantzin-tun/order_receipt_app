import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_flutter/data/orderData.dart';
import 'package:order_flutter/model/order/order_model.dart';
import 'package:order_flutter/repository/order_repository.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository orderRepository;

  OrderCubit(this.orderRepository) : super(OrderInitial());

  //Get Order
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
        if (d.status == "percent") {
          totalDiscount += value.order.footer.sub_total * d.rate / 100;
        } else {
          totalDiscount += d.rate;
        }
      }
      List<String> discountNames = [];
      for (var d in value.order.footer.discount) {
        discountNames.add(d.discount_name);
      }
      String discountNameList = discountNames.join(" + ");

      emit(OrderSuccessState(value,
          totalTax: totalTax,
          totalDiscount: totalDiscount,
          taxNames: taxNameList,
          discountNames: discountNameList));
    }).catchError((error) => print("Try again"));
  }

  //delete Order
  void deleteOrder(int index) {
    OrderSuccessState currentState = state as OrderSuccessState;
    currentState.order.order.item.removeWhere((item) => item.item_id == index);
  }
}
