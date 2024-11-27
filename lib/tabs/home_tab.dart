import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/src/painting/image_stream.dart';

class HomeTab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack() => Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 100, 110),
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
            const SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("Novidades",
                  style: TextStyle(fontSize: 26.0, color: Colors.white),
                ),
                centerTitle: true,
              ),
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
