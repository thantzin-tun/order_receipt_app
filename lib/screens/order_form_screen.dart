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
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:order_flutter/bloc/order/order_cubit.dart';
import 'package:order_flutter/main.dart';
import 'package:order_flutter/model/language/language.dart';
import 'package:order_flutter/model/order/order_model.dart';
import 'package:order_flutter/screens/order_edit_screen.dart';
import 'package:order_flutter/utils/colors.dart';
import 'package:order_flutter/utils/fonts.dart';

// ignore: must_be_immutable
class OrderScreenPage extends StatefulWidget {
  final dynamic userWidth;
  final dynamic hideColumn;

  const OrderScreenPage(
      {this.userWidth = null, this.hideColumn = null, Key? myKey})
      : super(key: myKey);

  @override
  State<OrderScreenPage> createState() => _OrderScreenPageState();
}

class _OrderScreenPageState extends State<OrderScreenPage> {
  OrderCubit orderCubit = OrderCubit(Get.find());

  bool id = false;
  bool item_name = false;
  bool price = true;
  bool qty = false;
  bool total = false;

  void _hideColumns() {
    if (id && item_name && price && qty && total || !id && !item_name && !price && !qty && !total) {
      return;
    } else {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    orderCubit.getOrder();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    List<DataColumn> columns = [];

    if (!id) {
      columns.add(DataColumn(
          label: Text(
        "#",
        style: screenWidth > 768 ? itemTabledFontSize : itemMobileFontSize,
      )));
    }

    if (!item_name) {
      columns.add(DataColumn(
          label: Text(
        AppLocalizations.of(context)!.item,
        style: screenWidth > 768 ? itemTabledFontSize : itemMobileFontSize,
      )));
    }
    if (!price) {
      columns.add(DataColumn(
          label: Text(
        AppLocalizations.of(context)!.price,
        style: screenWidth > 768 ? itemTabledFontSize : itemMobileFontSize,
      )));
    }
    if (!qty) {
      columns.add(DataColumn(
          label: Text(
        AppLocalizations.of(context)!.qty,
        style: screenWidth > 768 ? itemTabledFontSize : itemMobileFontSize,
      )));
    }
    if (!total) {
      columns.add(DataColumn(
          label: Text(
        AppLocalizations.of(context)!.total,
        style: screenWidth > 768 ? itemTabledFontSize : itemMobileFontSize,
      )));
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(
            AppLocalizations.of(context)!.order_form,
            // screenWidth.toString(),
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            Row(
              children: [
                DropdownButton(
                  onChanged: (Language? language) {
                    MyApp.setLocale(
                        context, Locale(language!.languageCode, ""));
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
                                          fontSize: 16,
                                          color: dropDownTextColor),
                                    )
                                  ],
                                ),
                              ))
                      .toList(),
                ),
                const SizedBox(width: 20),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, StateSetter setInnerState) =>
                                  AlertDialog(
                                actions: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.teal),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Cancel",
                                          style: TextStyle(
                                              color: elevatedButtonTextColor))),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.teal),
                                      onPressed: () {
                                        setInnerState(() {});
                                        _hideColumns();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        "Change",
                                        style: TextStyle(
                                            color: elevatedButtonTextColor),
                                      ))
                                ],
                                content: SingleChildScrollView(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        CheckboxListTile(
                                          value: id,
                                          onChanged: (bool? newValue) {
                                            setInnerState(() {
                                              id = !id;
                                            });
                                          },
                                          activeColor: Colors.teal,
                                          title: const Text("No."),
                                        ),
                                        CheckboxListTile(
                                          value: item_name,
                                          activeColor: Colors.teal,
                                          onChanged: (bool? newValue) {
                                            setInnerState(() {
                                              item_name = !item_name;
                                            });
                                          },
                                          title: const Text("Item"),
                                        ),
                                        CheckboxListTile(
                                          value: price,
                                          activeColor: Colors.teal,
                                          onChanged: (bool? newValue) {
                                            setInnerState(() {
                                              price = !price;
                                            });
                                          },
                                          title: const Text("Price"),
                                        ),
                                        CheckboxListTile(
                                          value: qty,

                                          activeColor: Colors.teal,
                                          onChanged: (bool? newValue) {
                                            setInnerState(() {
                                              qty = !qty;
                                            });
                                          },
                                          // checkColor: Colors.teal,
                                          title: const Text("Quantity"),
                                        ),
                                        CheckboxListTile(
                                          value: total,
                                          activeColor: Colors.teal,
                                          onChanged: (bool? newValue) {
                                            setInnerState(() {
                                              total = !total;
                                            });
                                          },
                                          title: const Text("Total"),
                                        ),
                                      ]),
                                ),
                                clipBehavior: Clip.none,
                                elevation: 2,
                                title: const Text("Choose hide column"),
                              ),
                            );
                          });
                    },
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    )),
                    IconButton(onPressed:(){
                      Get.to(() => const OrderEditScreen());
                    }, icon: const Icon(Icons.edit,color: Colors.white,))
              ],
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
                  // Header Start
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

                  //Middle Start

                  // Expanded(
                  //   child: SizedBox(
                  //     width: double.infinity,
                  //     child: SingleChildScrollView(
                  //       scrollDirection: Axis.vertical,
                  //         child: DataTable(
                  //           horizontalMargin: 0,
                  //           dataRowHeight: 80,
                  //           headingRowHeight: 40.0,
                  //           columns: columns,
                  //           rows: List<DataRow>.generate(
                  //             item.length,
                  //             (index) => DataRow(
                  //               cells: [
                  //               if (!id)
                  //                 DataCell(
                  //                   Text(
                  //                   "${index + 1}",
                  //                   style: screenWidth > 768
                  //                       ? itemTabledFontSize
                  //                       : itemMobileFontSize,
                  //                                                   )),
                  //               if (!item_name)
                  //                 DataCell(
                  //                   Text(item[index].item_name,
                  //                     softWrap: true,
                  //                     textAlign: TextAlign.start,
                  //                     style: screenWidth > 768
                  //                         ? itemTabledFontSize
                  //                         : itemMobileFontSize)),
                  //               if (!price)
                  //                 DataCell(
                  //                   Text(item[index].item_price.toString(),
                  //                     textAlign: TextAlign.center,
                  //                     softWrap: true,
                  //                     style: screenWidth > 768
                  //                         ? itemTabledFontSize
                  //                         : itemMobileFontSize)),
                  //               if (!qty)
                  //                 DataCell(
                  //                   Text(item[index].item_qty.toString(),
                  //                     style: screenWidth > 768
                  //                         ? itemTabledFontSize
                  //                         : itemMobileFontSize)),
                  //               if (!total)
                  //                 DataCell(
                  //                   Text(
                  //                     item[index].item_total_price.toString(),
                  //                     style: screenWidth > 768
                  //                         ? itemTabledFontSize
                  //                         : itemMobileFontSize)),
                  //             ]),
                  //           ),
                  //         ),
                  //     ),
                  //   ),
                  // ),

                  Expanded(
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if(!id)
                            Container(
                              width: screenWidth > 768 ? 100 : 20,
                              child: Text("#",
                                  style: screenWidth > 768
                                      ? itemTabledFontSize
                                      : itemMobileFontSize),
                            ),
                          if(!item_name)
                            Container(
                              width: screenWidth > 768 ? 350 : 140,
                              child: Text(AppLocalizations.of(context)!.item,
                                  style: screenWidth > 768
                                      ? itemTabledFontSize
                                      : itemMobileFontSize),
                            ),
                          if(!price)
                            Container(
                              width: screenWidth > 768 ? 120 : 80,
                              child: Text(AppLocalizations.of(context)!.price,
                                  style: screenWidth > 768
                                      ? itemTabledFontSize
                                      : itemMobileFontSize),
                            ),
                          if(!qty)  
                            Container(
                              width: screenWidth > 768 ? 180 : 80,
                              child: Text(AppLocalizations.of(context)!.qty,
                                  style: screenWidth > 768
                                      ? itemTabledFontSize
                                      : itemMobileFontSize),
                            ),
                          if(!total)  
                            Container(
                              child: Text(AppLocalizations.of(context)!.total,
                                  style: screenWidth > 768
                                      ? itemTabledFontSize
                                      : itemMobileFontSize),
                            ),
                        ],
                      ),
                      // const SizedBox(height: 30,),
                      const Divider(
                        color: Colors.black,
                        thickness: 1.0,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: item.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: screenWidth > 768 ? 90 : 70,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  if(!id)
                                    Container(
                                      width: screenWidth > 768 ? 100 : 20,
                                      child: Text("${index + 1}",
                                          style: screenWidth > 768
                                              ? itemTabledFontSize
                                              : itemMobileFontSize),
                                    ),
                                  if(!item_name)  
                                    Container(
                                      width: screenWidth > 768 ? 350 : 140,
                                      child: Text(item[index].item_name,
                                          style: screenWidth > 768
                                              ? itemTabledFontSize
                                              : itemMobileFontSize),
                                    ),
                                  if(!price)  
                                    Container(
                                      width: screenWidth > 768 ? 120 : 80,
                                      child: Center(
                                        child: Text("${item[index].item_price}",
                                            style: screenWidth > 768
                                                ? itemTabledFontSize
                                                : itemMobileFontSize),
                                      ),
                                  ),
                                if(!qty)
                                  Container(
                                       color: Colors.amberAccent,
                                      width: screenWidth > 768 ? 180 : 80,
                                      child: Text("${item[index].item_qty}",
                                          style: screenWidth > 768
                                              ? itemTabledFontSize
                                              : itemMobileFontSize),
                                    ),
                                if(!total)    
                                  Container(
                                    child: Text(
                                        "${item[index].item_total_price}",
                                        style: screenWidth > 768
                                            ? itemTabledFontSize
                                            : itemMobileFontSize),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ]),
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
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                  // AppLocalizations.of(context)!.discount,
                                  "${AppLocalizations.of(context)!.discount} ($discountNames)",
                                  style: screenWidth > 768
                                      ? FooterFont.tabletFooterFont
                                      : FooterFont.mobileFooterFont),
                              Text(" - ${totalDiscount.toStringAsFixed(2)}",
                                  style: screenWidth > 768
                                      ? FooterFont.tabletFooterFont
                                      : FooterFont.mobileFooterFont),
                            ],
                          ),
                          const SizedBox(height: 5),
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
                          const SizedBox(height: 5),
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
