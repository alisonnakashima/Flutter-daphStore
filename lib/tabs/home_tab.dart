import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daphstore_app/main.dart';
import 'package:daphstore_app/utils/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/src/painting/image_stream.dart';

class HomeTab extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).primaryColor;

    Widget _buildBodyBack() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Color.fromARGB(255, 253, 181, 168)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
          )
      ),
    );
    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget> [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: const FlexibleSpaceBar(
                title: Text("Novidades",
                  style: TextStyle(
                    fontSize: 26.0,
                    color: Colors.black,
                  ),
                ),
                centerTitle: true,
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.brightness_6),
                  onPressed: (){

                  }, // Alterna o tema ao clicar no botão
                ),
              ],
            ),
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection("home").orderBy("pos").get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                } else {
                  return SliverMasonryGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    childCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var doc = snapshot.data!.docs[index];
                      return FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: (doc.data() as Map<String, dynamic>)["image"],
                        fit: BoxFit.cover,
                      );
                    }
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
