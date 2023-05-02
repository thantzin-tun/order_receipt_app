// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:cart/bloc/order/order_cubit.dart';
// import 'package:cart/main.dart';
// import 'package:cart/model/language/language.dart';
// import 'package:cart/model/order/order_model.dart';
// import 'package:cart/utils/colors.dart';
// import 'package:cart/utils/fonts.dart';
import "package:get/get.dart";
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

//Locallization
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:order_flutter/bloc/order/order_cubit.dart';
import 'package:order_flutter/main.dart';
import 'package:order_flutter/model/language/language.dart';
import 'package:order_flutter/model/order/order_model.dart';
import 'package:order_flutter/utils/colors.dart';
import 'package:order_flutter/utils/fonts.dart';

// ignore: must_be_immutable
class OrderEditScreen extends StatefulWidget {
  final dynamic userWidth;
  final dynamic hideColumn;

  const OrderEditScreen(
      {this.userWidth = null, this.hideColumn = null, Key? myKey})
      : super(key: myKey);

  @override
  State<OrderEditScreen> createState() => _OrderScreenPageState();
}

class _OrderScreenPageState extends State<OrderEditScreen> {
  OrderCubit orderCubit = OrderCubit(Get.find());

  bool id = false;
  bool item_name = false;
  bool price = true;
  bool qty = false;
  bool total = false;

  //Text
  String itemName = "";
  double itemPrice = 0.0;
  double ItemQty = 0;

  //Form UserInput Value
  final _itemNameController = TextEditingController();
  final _itemPriceController = TextEditingController();
  final _ItemQtyController = TextEditingController();

  //Customer UserInputValue
  final _customerNameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void _hideColumns() {
    if (id && item_name && price && qty && total ||
        !id && !item_name && !price && !qty && !total) {
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
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _itemNameController.dispose();
    _itemPriceController.dispose();
    _ItemQtyController.dispose();
    super.dispose();
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
          backgroundColor: Colors.blue,
          title: Text(
            AppLocalizations.of(context)!.order_edit,
            // screenWidth.toString(),
            style: const TextStyle(color: Colors.white),
          ),
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
              //Api Header,Footer and Item for OrderForm Loop of OrderSuccessState
              Footer footer = state.order.order.footer;
              Header header = state.order.order.header;
              List<Item> item = state.order.order.item;
              double totalTax = state.totalTax;
              String taxList = state.taxNames;
              double totalDiscount = state.totalDiscount;
              String discountNames = state.discountNames;
              //End

              //Dynamci Form
              final List<TextEditingController> _discountControllers =
                  List.generate(
                footer.discount.length,
                (_) => TextEditingController(),
              );

              final List<TextEditingController> _taxControllers = List.generate(
                footer.tax.length,
                (_) => TextEditingController(),
              );

              List<Widget> _discountFields() {
                List<Widget> fields = [];
                for (int i = 0; i < footer.discount.length; i++) {
                  _discountControllers[i].text =
                      footer.discount[i].rate.toString();
                  fields.add(InputField(_discountControllers[i],
                      footer.discount[i].discount_name, true, null, true));
                }
                return fields;
              }

              List<Widget> _taxFields() {
                List<Widget> fields = [];
                for (int i = 0; i < footer.tax.length; i++) {
                  _taxControllers[i].text = footer.tax[i].tax_amount.toString();
                  fields.add(InputField(_taxControllers[i],
                      footer.tax[i].tax_name, true, null, true));
                }
                return fields;
              }

              //End Dynamic Form

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
                            GestureDetector(
                              onTap: () {
                                _customerNameController.text =
                                    header.customer_name;
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                          "${AppLocalizations.of(context)!.customer_name}"),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InputField(_customerNameController,
                                                "", false, null, true)
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            print(_customerNameController.text);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue),
                                          child: const Text(
                                            "Change Customer Name",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Row(
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
                              ),
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
                  const SizedBox(
                    height: 30,
                  ),
                  //Header End
                  const Divider(
                    color: Colors.black,
                    thickness: 1.0,
                  ),
                  //Middle Start

                  Expanded(
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: screenWidth > 768 ? 350 : 140,
                            child: Text(AppLocalizations.of(context)!.item,
                                style: screenWidth > 768
                                    ? itemTabledFontSize
                                    : itemMobileFontSize),
                          ),
                          Container(
                            width: screenWidth > 768 ? 120 : 80,
                            child: Text(AppLocalizations.of(context)!.price,
                                style: screenWidth > 768
                                    ? itemTabledFontSize
                                    : itemMobileFontSize),
                          ),
                          Container(
                            width: screenWidth > 768 ? 180 : 80,
                            child: Text(AppLocalizations.of(context)!.qty,
                                style: screenWidth > 768
                                    ? itemTabledFontSize
                                    : itemMobileFontSize),
                          ),
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
                              child: Slidable(
                                key: ValueKey(index.toInt()),
                                startActionPane: ActionPane(
                                  extentRatio: 0.2,
                                  motion: const BehindMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (BuildContext context) {
                                        orderCubit
                                            .deleteOrder(item[index].item_id);
                                      },
                                      backgroundColor: Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                endActionPane: ActionPane(
                                  motion: const BehindMotion(),
                                  children: [
                                    SlidableAction(
                                      flex: 2,
                                      onPressed: (BuildContext context) {
                                        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                        _itemNameController.text =
                                            item[index].item_name;
                                        _itemPriceController.text =
                                            item[index].item_price.toString();
                                        _ItemQtyController.text =
                                            item[index].item_qty.toString();
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                Form(
                                                  key: formKey,
                                                  child: AlertDialog(
                                                    title:
                                                        const Text("Edit Form"),
                                                    actionsPadding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    content:
                                                        SingleChildScrollView(
                                                            child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        InputField(
                                                            _itemNameController,
                                                            "Item Name",
                                                            false,
                                                            2,
                                                            false),
                                                        InputField(
                                                            _itemPriceController,
                                                            "Item Name",
                                                            true,
                                                            null,
                                                            false),
                                                        InputField(
                                                            _ItemQtyController,
                                                            "Item Name",
                                                            true,
                                                            null,
                                                            false),
                                                      ],
                                                    )),
                                                    actions: [
                                                      ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .blue),
                                                          onPressed: () {
                                                            if (formKey
                                                                    .currentState
                                                                    ?.validate() ??
                                                                true) {
                                                              formKey
                                                                  .currentState
                                                                  ?.save();
                                                              print(
                                                                  _itemNameController
                                                                      .text);
                                                              print(
                                                                  _itemPriceController
                                                                      .text);
                                                              print(
                                                                  _ItemQtyController
                                                                      .text);
                                                            }
                                                          },
                                                          child: const Text(
                                                            "Edit",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ))
                                                    ],
                                                  ),
                                                ));
                                      },
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      icon: Icons.edit,
                                      label: 'Edit',
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: screenWidth > 768 ? 350 : 140,
                                      child: Text(item[index].item_name,
                                          style: screenWidth > 768
                                              ? itemTabledFontSize
                                              : itemMobileFontSize),
                                    ),
                                    Container(
                                      width: screenWidth > 768 ? 120 : 80,
                                      child: Center(
                                        child: Text("${item[index].item_price}",
                                            style: screenWidth > 768
                                                ? itemTabledFontSize
                                                : itemMobileFontSize),
                                      ),
                                    ),
                                    Container(
                                      width: screenWidth > 768 ? 180 : 80,
                                      child: Text("${item[index].item_qty}",
                                          style: screenWidth > 768
                                              ? itemTabledFontSize
                                              : itemMobileFontSize),
                                    ),
                                    Container(
                                      child: Text(
                                          "${item[index].item_total_price}",
                                          style: screenWidth > 768
                                              ? itemTabledFontSize
                                              : itemMobileFontSize),
                                    ),
                                  ],
                                ),
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
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                              "${AppLocalizations.of(context)!.discount}"),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: _discountFields(),
                                            ),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                for (var d
                                                    in _discountControllers) {
                                                  print(d.text);
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.blue),
                                              child: const Text(
                                                "Change Discount",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                    size: 15.0,
                                  )),
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
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                              "${AppLocalizations.of(context)!.tax}"),
                                          content: SingleChildScrollView(
                                            child: Expanded(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: _taxFields()),
                                            ),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                for (var t in _taxControllers) {
                                                  print(t.text);
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.blue),
                                              child: const Text(
                                                "Change Tax",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                    size: 15.0,
                                  )),
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
                    color: Colors.blue,
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

  TextFormField InputField(controller, hintText, isNumber, line, suffix) {
    return TextFormField(
      controller: controller,
      maxLines: line,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        focusColor: Colors.blue,
        hintText: hintText,
        suffix: suffix ? Text(hintText) : null,
        border: const UnderlineInputBorder(),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
      cursorColor: Colors.blue,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "Empty!";
        }
        return null;
      },
      onSaved: (value) {},
    );
  }
}
