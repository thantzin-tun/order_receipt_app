import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:order_flutter/data/orderData.dart';
import 'package:order_flutter/model/order/order_model.dart';

class OrderRepository {
  Future<Order> getOrder() async {
    final jsonString = await rootBundle.loadString("assets/dummy-data.json");
    //JSON string to a Map
    final jsonMap = json.decode(jsonString);
    // Map to an Order model
    final order = Order.fromJson(jsonMap); 

    return order;
  }
}
