import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daphstore_app/datas/product_data.dart';
import 'package:flutter/material.dart';
import '../tiles/product_tile.dart';

class CategoryScreen extends StatelessWidget {

  final DocumentSnapshot snapshot;
  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {

    // Converte os dados para um Map<String, dynamic>
    // Assim, para utilizar basta chamar a variável e o nome do campo desejado
    // quase com na leitura de JSON file
    // final data = snapshot.data() as Map<String, dynamic>;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text((snapshot.data() as Map<String, dynamic>)["title"]),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget> [
              Tab(icon: Icon(Icons.grid_on),),
              Tab(icon: Icon(Icons.list),),
            ],
          ),
        ),
        body: FutureBuilder <QuerySnapshot> (
          future: FirebaseFirestore.instance.collection("produtos").
            doc(snapshot.id).collection("itens").get(),
          builder: (context, snapshot) {
            print("category_screen");
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator(),);
            } else {
              return TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  GridView.builder(
                    padding: const EdgeInsets.all(4.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index){
                        return ProductTile("grid", ProductData.fromDocument(
                            snapshot.data!.docs[index] )
                        );
                    },
                  ),
                  ListView.builder(
                    padding: EdgeInsets.all(4.0),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return ProductTile(
                        "list",
                        ProductData.fromDocument(snapshot.data!.docs[index] )
                      );
                    }
                  )
                ]
              );
            }
          }
        )
      ),
    );
  }
}