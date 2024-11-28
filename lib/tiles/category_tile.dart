import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daphstore_app/screens/category_screen.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {

  late final DocumentSnapshot snapshot;

  // Construtor para inicializar a variável snapshot
  CategoryTile({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    print("category_tile");
    return ListTile(
      leading: CircleAvatar(
        radius: 25.0,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage((snapshot.data()! as Map<String, dynamic>)["icon"]),
      ),
      title: Text((snapshot.data()! as Map<String, dynamic>)["title"]),
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CategoryScreen(snapshot))
        );
      },
    );
  }
}