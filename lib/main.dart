// import 'package:cart/api/product_api.dart';
// import 'package:cart/bloc/cart/cart_bloc.dart';
// import 'package:cart/bloc/order/order_cubit.dart';
// import 'package:cart/bloc/product/product_cubit.dart';
// import 'package:cart/repository/order_repository.dart';
// import 'package:cart/repository/product_repository.dart';
// import 'package:cart/screens/get/get_screen.dart';
// import 'package:cart/screens/order_screen.dart';
// import 'package:cart/screens/responsive_screen.dart';
// import 'package:cart/screens/responsive_screenThree.dart';
// import 'package:cart/screens/responsive_screenTwo.dart';
// import 'package:cart/screens/task_screen.dart';
// import 'package:cart/screens/twoScreen/ScreenOne.dart';
// import 'package:cart/screens/twoScreen/ScreenTwo.dart';
// import 'package:cart/utils/responsive.dart';
// import 'package:flutter/material.dart';
// import 'package:cart/screens/product_home.dart';
import "package:dio/dio.dart";
import 'package:flutter/material.dart';
import 'package:order_flutter/bloc/order/order_cubit.dart';
import 'package:order_flutter/repository/order_repository.dart';
import 'package:order_flutter/screens/task_screen.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import "package:get/get.dart";
import "package:flutter_bloc/flutter_bloc.dart";

//For localization
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import "package:intl/intl.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale; // default language

  void setLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Dio dio = Dio();
    OrderRepository orderRepository = OrderRepository();
    dio.interceptors.add(PrettyDioLogger(
      responseBody: true,
      requestBody: true,
      error: true,
      compact: true,
      requestHeader: true,
    ));
    Get.put(orderRepository);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home:  MultiBlocProvider(providers: [
        BlocProvider<OrderCubit>(
          create: (context) => OrderCubit(orderRepository),
        ),
      ], child: const OrderScreenPage()),
    );
  }
}
