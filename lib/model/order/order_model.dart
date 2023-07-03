// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class Order {
  Order({
    required this.order,
  });
  OrderClass order;
  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable()
class OrderClass {
  OrderClass({
    required this.header,
    required this.item,
    required this.footer,
  });

  Header header;
  List<Item> item;
  Footer footer;

  factory OrderClass.fromJson(Map<String, dynamic> json) =>
      _$OrderClassFromJson(json);
  Map<String, dynamic> toJson() => _$OrderClassToJson(this);
}

//Header Object
@JsonSerializable()
class Header {
  Header({
    required this.customer_name,
    required this.order_no,
    required this.order_date,
    required this.cahier_name,
  });

  String customer_name;
  String order_no;
  String order_date;
  String cahier_name;

  factory Header.fromJson(Map<String, dynamic> json) => _$HeaderFromJson(json);
  Map<String, dynamic> toJson() => _$HeaderToJson(this);
}

//Footer Object
@JsonSerializable()
class Footer {
  Footer({
    required this.sub_total,
    required this.discount,
    required this.tax,
    required this.grand_total,
  });

  double sub_total;
  List<Discount> discount;
  List<Tax> tax;
  double grand_total;

  factory Footer.fromJson(Map<String, dynamic> json) => _$FooterFromJson(json);
  Map<String, dynamic> toJson() => _$FooterToJson(this);
}

//For Item Array of object
@JsonSerializable()
class Item {
  Item({
    required this.item_id,
    required this.item_name,
    required this.item_price,
    required this.item_qty,
    required this.item_total_price,
  });

  int item_id;
  String item_name;
  double item_price;
  int item_qty;
  double item_total_price;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class Tax {
  String tax_name;
  double tax_amount;

  Tax({required this.tax_name, required this.tax_amount});

  factory Tax.fromJson(Map<String, dynamic> json) => _$TaxFromJson(json);
  Map<String, dynamic> toJson() => _$TaxToJson(this);
}

@JsonSerializable()
class Discount {
  String discount_name;
  double rate;
  String status;

  Discount(
      {required this.discount_name, required this.rate, required this.status});

  factory Discount.fromJson(Map<String, dynamic> json) =>
      _$DiscountFromJson(json);
  Map<String, dynamic> toJson() => _$DiscountToJson(this);
}
