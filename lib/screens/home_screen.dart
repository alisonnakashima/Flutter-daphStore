import 'package:daphstore_app/tabs/products_tab.dart';
import 'package:flutter/material.dart';
import '../tabs/home_tab.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController();

  void _toggleTheme() {
    // Lógica para alternar entre os temas claro e escuro
    setState(() {
      // Trocar entre temas aqui
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController, _toggleTheme),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos/Categorias"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController, _toggleTheme),
          body: ProductsTab(),
        ),
      ],
    );
  }
}
