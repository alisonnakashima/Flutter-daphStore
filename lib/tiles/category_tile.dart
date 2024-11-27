import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {

  late final DocumentSnapshot snapshot;

  // Construtor para inicializar a variável snapshot
  CategoryTile({required this.snapshot});

  @override
  Widget build(BuildContext context) {

    // Converte os dados do snapshot para um Map
    final data = snapshot.data() as Map<String, dynamic>;

    return ListTile(
      leading: CircleAvatar(
        radius: 25.0,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(data["icon"]),
      ),
      title: Text(data["title"]),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {

      },
    );
  }
}