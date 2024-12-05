import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daphstore_app/datas/product_data.dart';

class CartProduct {

  late String cartId;
  late String category;
  late String productId;

  late int quantity;
  late String smells;

  late ProductData productData;

  CartProduct.fromDocument(DocumentSnapshot snapshot) {
    cartId = snapshot.id;
    category = snapshot["category"]!;
    productId = snapshot["productId"]!;
    quantity = snapshot["quantity"]!;
    smells = snapshot["smells"]!;
  }

  Map<String, dynamic> toMap(){
    return{
      "category": category,
      "productID": productId,
      "quantity": quantity,
      "smells": smells,
      "product": productData.toResumedMap()
    };
  }

}