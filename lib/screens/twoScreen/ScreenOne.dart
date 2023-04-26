import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:order_flutter/bloc/order/order_cubit.dart';
import 'package:order_flutter/screens/task_screen.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({super.key});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  OrderCubit orderCubit = OrderCubit(Get.find());
  @override
  void initState() {
    super.initState();
    orderCubit.getOrder();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Container(
            child: const Expanded(
              child: OrderScreenPage(),
            ),
          ),
          Container(
            width: 400,
            height: double.infinity,
            color: Colors.purple,
            child: const Center(child: Text("Screen One",style: TextStyle(color: Colors.white,fontSize: 20),)),
          ),
        ],
      ),
    );
  }
}