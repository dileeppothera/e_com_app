import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future getProductDetails(String id) async {
  final response = await http.get(
    Uri.parse('https://omanphone.smsoman.com/api/productdetails?id=$id'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
  );
  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    debugPrint("server returns body ");
    var responseJson = jsonDecode(response.body);
    // return (responseJson as List)
    //     .map((p) => ProductDetail.fromJson(p))
    //     .toList();
    return ProductDetail.fromJson(jsonDecode(response.body));
  } else {
    print("didnt get body");
    debugPrint("Couldnt get body");

    throw Exception('Failed to get body.');
  }
}

class ProductDetail {
  ProductDetail({
    required this.name,
    required this.description,
    required this.images,
    required this.price,
    required this.id,
    this.attr,
  });

  String name;
  String id;
  double price;
  List<dynamic> images;
  dynamic attr;

  String? description;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        id: json['id'],
        name: json["name"],
        description: json["description"],
        images: json["image"],
        price: json["price"],
        attr: json["attrs"],
      );
}
