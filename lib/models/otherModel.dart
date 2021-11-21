import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Product>> getProduct() async {
  final response = await http.get(
    Uri.parse('https://omanphone.smsoman.com/api/homepage'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
  );
  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    debugPrint("server returns body ");
    var responseJson = jsonDecode(response.body);
    return (responseJson as List).map((p) => Product.fromJson(p)).toList();
    // return Product.fromJson(jsonDecode(response.body));
  } else {
    print("didnt get body");
    debugPrint("Couldnt get body");

    throw Exception('Failed to get body.');
  }
}

List<Product> welcomeFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

class Product {
  Product({
    required this.type,
    required this.data,
    required this.subtype,
  });

  String type;
  Data data;
  String? subtype;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        type: json["type"],
        data: Data.fromJson(json["data"]),
        subtype: json["subtype"] == null ? null : json["subtype"],
      );
}

class Data {
  Data({
    required this.id,
    required this.title,
    required this.items,
    required this.type,
    required this.file,
  });

  String id;
  String? title;
  List<Item> items;
  String? type;
  String? file;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"] == null ? null : json["title"],
        items:
            List<Item>.from(json["items"]?.map((x) => Item.fromJson(x)) ?? []),
        // List<Catimage>.from(
        //     json["catimages"].map((x) => Catimage.fromJson(x)))
        type: json["type"],
        file: json["file"] == null ? null : json["file"],
      );
}

class Item {
  Item({
    required this.name,
    required this.id,
    required this.sku,
    required this.image,
    required this.price,
    required this.storage,
    required this.productTag,
    required this.preorder,
  });

  String name;
  String id;
  String sku;
  String image;
  double price;
  dynamic storage;
  String? productTag;
  String preorder;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
        id: json["id"],
        sku: json["sku"],
        image: json["image"],
        price: json["price"].toDouble(),
        storage: json["storage"],
        productTag: json["product_tag"],
        preorder: json["preorder"],
      );
}

enum StorageEnum { THE_128_GB, THE_64_GB }

final storageEnumValues = EnumValues(
    {"128 GB": StorageEnum.THE_128_GB, "64 GB": StorageEnum.THE_64_GB});

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
