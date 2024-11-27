import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:daphstore_app/tiles/category_tile.dart';

class ProductsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection("produtos").get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              "Nenhum produto encontrado.",
              style: TextStyle(fontSize: 18.0),
            ),
          );
        } else {
          // Cria os tiles divididos
          final dividedTiles = ListTile.divideTiles(
            tiles: snapshot.data!.docs.map((doc) {
              return CategoryTile(snapshot: doc);
            }),
            color: Colors.grey[500],
          ).toList();

          // Retorna a lista com os divisores aplicados
          return ListView(children: dividedTiles);
        }
      },
    );
  }
}
