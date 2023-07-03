import 'package:flutter/material.dart';
import 'package:order_flutter/screens/order_form_screen.dart';

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({super.key});

  @override
  State<ScreenTwo> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Container(
            width: 400,
            height: double.infinity,
            color: Colors.green,
            child: const Center(
                child: Text(
              "My name is Mg Thant Zin Tun",
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
          ),
          Container(
            child: const Expanded(
              child: OrderScreenPage(),
            ),
          )
        ],
      ),
    );
  }
}
