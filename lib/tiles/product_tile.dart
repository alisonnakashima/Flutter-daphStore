import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daphstore_app/datas/product_data.dart';
import 'package:daphstore_app/screens/product_screen.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {

  final String type;
  final ProductData productData;

  ProductTile(this.type, this.productData);

  @override
  Widget build(BuildContext context) {
    //print(productData.price);
    //print(productData.image);
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ProductScreen(productData))
        );
      },
      child: Card(
        child: type == "grid" ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              AspectRatio(
                aspectRatio: 1.1,
                child: Image.network(productData.image[0] as String,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget> [
                      Text(
                        productData.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "R\$ ${productData.price.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                )
              )
            ],
          )
          : Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Image.network(
                productData.image[0] as String,
                fit: BoxFit.cover,
                height: 250.0,
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget> [
                  Text(
                    productData.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(
                    "R\$ ${productData.price.toStringAsFixed(2)}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}