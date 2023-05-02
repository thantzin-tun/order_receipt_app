// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      order: OrderClass.fromJson(json['order'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'order': instance.order,
    };

OrderClass _$OrderClassFromJson(Map<String, dynamic> json) => OrderClass(
      header: Header.fromJson(json['header'] as Map<String, dynamic>),
      item: (json['item'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      footer: Footer.fromJson(json['footer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderClassToJson(OrderClass instance) =>
    <String, dynamic>{
      'header': instance.header,
      'item': instance.item,
      'footer': instance.footer,
    };

Header _$HeaderFromJson(Map<String, dynamic> json) => Header(
      customer_name: json['customer_name'] as String,
      order_no: json['order_no'] as String,
      order_date: json['order_date'] as String,
      cahier_name: json['cahier_name'] as String,
    );

Map<String, dynamic> _$HeaderToJson(Header instance) => <String, dynamic>{
      'customer_name': instance.customer_name,
      'order_no': instance.order_no,
      'order_date': instance.order_date,
      'cahier_name': instance.cahier_name,
    };

Footer _$FooterFromJson(Map<String, dynamic> json) => Footer(
      sub_total: (json['sub_total'] as num).toDouble(),
      discount: (json['discount'] as List<dynamic>)
          .map((e) => Discount.fromJson(e as Map<String, dynamic>))
          .toList(),
      tax: (json['tax'] as List<dynamic>)
          .map((e) => Tax.fromJson(e as Map<String, dynamic>))
          .toList(),
      grand_total: (json['grand_total'] as num).toDouble(),
    );

Map<String, dynamic> _$FooterToJson(Footer instance) => <String, dynamic>{
      'sub_total': instance.sub_total,
      'discount': instance.discount,
      'tax': instance.tax,
      'grand_total': instance.grand_total,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      item_id: json['item_id'] as int,
      item_name: json['item_name'] as String,
      item_price: (json['item_price'] as num).toDouble(),
      item_qty: json['item_qty'] as int,
      item_total_price: (json['item_total_price'] as num).toDouble(),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'item_id': instance.item_id,
      'item_name': instance.item_name,
      'item_price': instance.item_price,
      'item_qty': instance.item_qty,
      'item_total_price': instance.item_total_price,
    };

Tax _$TaxFromJson(Map<String, dynamic> json) => Tax(
      tax_name: json['tax_name'] as String,
      tax_amount: (json['tax_amount'] as num).toDouble(),
    );

Map<String, dynamic> _$TaxToJson(Tax instance) => <String, dynamic>{
      'tax_name': instance.tax_name,
      'tax_amount': instance.tax_amount,
    };

Discount _$DiscountFromJson(Map<String, dynamic> json) => Discount(
      discount_name: json['discount_name'] as String,
      rate: (json['rate'] as num).toDouble(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$DiscountToJson(Discount instance) => <String, dynamic>{
      'discount_name': instance.discount_name,
      'rate': instance.rate,
      'status': instance.status,
    };
