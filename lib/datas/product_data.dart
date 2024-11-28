import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductData {
  late String category;
  late String id;

  late String title;
  late String description;

  late double price;
  late List<dynamic> image;
  late List<dynamic> smells;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    // final data = snapshot.data() as Map<String, dynamic>;
    id = snapshot.id;
    title = snapshot["title"];
    description = snapshot["description"];
    price = snapshot["price"] + 0.00;
    image = snapshot["image"];
    smells = snapshot["types"];

  }

  Map<String, dynamic> toResumedMap(){
    return {
      "title": title,
      "description": description,
      "price": price
    };
  }

}
