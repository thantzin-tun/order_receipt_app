// import 'package:cart/bloc/order/order_cubit.dart';
// import 'package:cart/main.dart';
// import 'package:cart/model/language/language.dart';
// import 'package:cart/model/order/order_model.dart';
// import 'package:cart/utils/colors.dart';
// import 'package:cart/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:get/get.dart";

//Locallization
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:order_flutter/bloc/order/order_cubit.dart';
import 'package:order_flutter/main.dart';
import 'package:order_flutter/model/language/language.dart';
import 'package:order_flutter/model/order/order_model.dart';
import 'package:order_flutter/utils/colors.dart';
import 'package:order_flutter/utils/fonts.dart';

// ignore: must_be_immutable
class OrderScreenPage extends StatefulWidget {
  final dynamic userWidth;

  const OrderScreenPage({this.userWidth = null, Key? myKey})
      : super(key: myKey);

  @override
  State<OrderScreenPage> createState() => _OrderScreenPageState();
}

class _OrderScreenPageState extends State<OrderScreenPage> {
  OrderCubit orderCubit = OrderCubit(Get.find());

  @override
  void initState() {
    super.initState();
    orderCubit.getOrder();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(
            AppLocalizations.of(context)!.order_form,
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: DropdownButton(
                onChanged: (Language? language) {
                  MyApp.setLocale(context, Locale(language!.languageCode, ""));
                },
                underline: const SizedBox(),
                icon: const Icon(
                  Icons.language,
                  color: Colors.white,
                ),
                items: Language.languageList()
                    .map<DropdownMenuItem<Language>>(
                        (e) => DropdownMenuItem<Language>(
                              value: e,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    e.flag,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    e.name,
                                    style: const TextStyle(
                                        fontSize: 16, color: dropDownTextColor),
                                  )
                                ],
                              ),
                            ))
                    .toList(),
              ),
            )
          ],
        ),
        body: BlocBuilder<OrderCubit, OrderState>(
          bloc: orderCubit,
          builder: (context, state) {
            if (state is OrderInitial) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.teal,
              ));
            } else if (state is OrderSuccessState) {

              Footer footer = state.order.order.footer;
              Header header = state.order.order.header;
              List<Item> item = state.order.order.item;
              double totalTax = state.totalTax;
              String taxList = state.taxNames;
              double totalDiscount = state.totalDiscount;
              String discountNames = state.discountNames;
              return Container(
                width: widget.userWidth != null
                    ? widget.userWidth
                    : double.infinity,
                padding: const EdgeInsets.all(10),
                child: Column(children: <Widget>[
                  //Header Start
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                Text(AppLocalizations.of(context)!.cashier_name,
                                    style: (screenWidth > 768)
                                        ? HeaderFont.tabletHeaderFont
                                        : (screenWidth > 992)
                                            ? HeaderFont.webHeaderFont
                                            : HeaderFont.mobileHeaderFont),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  header.cahier_name,
                                  style: screenWidth > 768
                                      ? HeaderFont.tabletHeaderFont
                                      : screenWidth > 1024
                                          ? HeaderFont.webHeaderFont
                                          : HeaderFont.mobileHeaderFont,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.customer_name,
                                  style: screenWidth > 768
                                      ? HeaderFont.tabletHeaderFont
                                      : screenWidth > 1024
                                          ? HeaderFont.webHeaderFont
                                          : HeaderFont.mobileHeaderFont,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  header.customer_name,
                                  style: screenWidth > 768
                                      ? HeaderFont.tabletHeaderFont
                                      : screenWidth > 1024
                                          ? HeaderFont.webHeaderFont
                                          : HeaderFont.mobileHeaderFont,
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.order_number,
                                  style: screenWidth > 768
                                      ? HeaderFont.tabletHeaderFont
                                      : screenWidth > 1024
                                          ? HeaderFont.webHeaderFont
                                          : HeaderFont.mobileHeaderFont,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  header.order_no,
                                  style: screenWidth > 768
                                      ? HeaderFont.tabletHeaderFont
                                      : screenWidth > 1024
                                          ? HeaderFont.webHeaderFont
                                          : HeaderFont.mobileHeaderFont,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.order_date,
                                  style: screenWidth > 768
                                      ? HeaderFont.tabletHeaderFont
                                      : screenWidth > 1024
                                          ? HeaderFont.webHeaderFont
                                          : HeaderFont.mobileHeaderFont,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  header.order_date,
                                  style: screenWidth > 768
                                      ? HeaderFont.tabletHeaderFont
                                      : screenWidth > 1024
                                          ? HeaderFont.webHeaderFont
                                          : HeaderFont.mobileHeaderFont,
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  //Header End
                  const Divider(
                    color: Colors.black,
                    thickness: 1.0,
                  ),

                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTableTheme(
                          data: DataTableThemeData(
                            horizontalMargin: 10,
                            columnSpacing: 20.0,
                            dataRowHeight: 80.0,
                            headingRowHeight: 50.0,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.transparent),
                            ),
                          ),
                          child: DataTable(
                            columns: [
                              DataColumn(
                                  label: Text(
                                "#",
                                style: screenWidth > 768
                                    ? itemTabledFontSize
                                    : itemMobileFontSize,
                              )),
                              DataColumn(
                                  label: Text(
                                      AppLocalizations.of(context)!.item,
                                      textAlign: TextAlign.center,
                                      style: screenWidth > 768
                                          ? itemTabledFontSize
                                          : itemMobileFontSize)),
                              DataColumn(
                                label: Text(AppLocalizations.of(context)!.qty,
                                    style: screenWidth > 768
                                        ? itemTabledFontSize
                                        : itemMobileFontSize),
                                numeric: true,
                              ),
                              DataColumn(
                                  label: Text(
                                      AppLocalizations.of(context)!.total,
                                      style: screenWidth > 768
                                          ? itemTabledFontSize
                                          : itemMobileFontSize),
                                  numeric: true),
                            ],
                            rows: List<DataRow>.generate(
                              item.length,
                              (index) => DataRow(cells: [
                                DataCell(Text(
                                  "${index + 1}",
                                  style: screenWidth > 768
                                      ? itemTabledFontSize
                                      : itemMobileFontSize,
                                )),
                                DataCell(Text(item[index].item_name,
                                    softWrap: true,
                                    textAlign: TextAlign.start,
                                    style: screenWidth > 768
                                        ? itemTabledFontSize
                                        : itemMobileFontSize)),
                                DataCell(Text(item[index].item_qty.toString(),
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                    style: screenWidth > 768
                                        ? itemTabledFontSize
                                        : itemMobileFontSize)),
                                DataCell(Text(
                                    item[index].item_total_price.toString(),
                                    style: screenWidth > 768
                                        ? itemTabledFontSize
                                        : itemMobileFontSize)),
                              ]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  //Middle End
                  //Footer Start
                  const Divider(
                    color: Colors.black,
                    thickness: 2.0,
                  ),
                  Container(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)!.sub_total,
                                style: screenWidth > 768
                                    ? FooterFont.tabletFooterFont
                                    : FooterFont.mobileFooterFont,
                              ),
                              Text(
                                "${footer.sub_total.toStringAsFixed(2)}",
                                style: screenWidth > 768
                                    ? FooterFont.tabletFooterFont
                                    : FooterFont.mobileFooterFont,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                  // AppLocalizations.of(context)!.discount,
                                  "${AppLocalizations.of(context)!.discount} ($discountNames)",
                                  style: screenWidth > 768
                                      ? FooterFont.tabletFooterFont
                                      : FooterFont.mobileFooterFont),
                              Text(
                                " - ${totalDiscount.toStringAsFixed(2)}",
                                  style: screenWidth > 768
                                      ? FooterFont.tabletFooterFont
                                      : FooterFont.mobileFooterFont),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                // AppLocalizations.of(context)!.tax,
                                "${AppLocalizations.of(context)!.tax} ($taxList)",
                                style: screenWidth > 768
                                    ? FooterFont.tabletFooterFont
                                    : FooterFont.mobileFooterFont,
                                softWrap: true,
                              ),
                              Text(
                                // footer.tax[1],
                                " + ${totalTax.toStringAsFixed(2)}",
                                style: screenWidth > 768
                                    ? FooterFont.tabletFooterFont
                                    : FooterFont.mobileFooterFont,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      )),
                  Container(
                    color: Color.fromARGB(255, 186, 243, 243),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context)!.grand_total,
                              style: screenWidth > 768
                                  ? FooterFont.tabletFooterFont
                                  : FooterFont.mobileFooterFont,
                            ),
                            Text("${footer.grand_total.toStringAsFixed(2)}",
                                style: screenWidth > 768
                                    ? FooterFont.tabletFooterFont
                                    : FooterFont.mobileFooterFont),
                          ],
                        )
                      ],
                    ),
                  )
                  //Footer End
                ]),
              );
            }
            return const Text("Something wrong!");
          },
        ),
      ),
    );
  }
}
