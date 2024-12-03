import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:daphstore_app/datas/product_data.dart';

class ProductScreen extends StatefulWidget {
  final ProductData productData;

  ProductScreen(this.productData);

  @override
  _ProductScreenState createState() => _ProductScreenState(productData);

}

class _ProductScreenState extends State<ProductScreen>{
  final ProductData productData;
  late String? selectedSmell = productData.smells[0];

  _ProductScreenState(this.productData);
  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(productData.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: CarouselSlider(
                items: productData.image.map((url) => Center(
                  child: Image.network(url),
                )).toList(),
                options: CarouselOptions(
                  aspectRatio: 0.9,
                  initialPage: 0,
                  autoPlay: false,
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  productData.title,
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500
                  ),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${productData.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 16.0),
                //PRECISA FAZER O TRATAMENTO DO MENU DE OPÇÕES PARA O CASO
                //DE NÃO HAVER OPÇÕES SELECIONÁVEIS, PELO PRODUTO SER ÚNICO OU
                //100% CUSTOMIZÁVEL. NÃO EXIBIR O QUE ESTÁ NO CONDICIONAL
                if(productData.smells[0] != "")
                  const Text(
                    "Selecione um aroma",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                const SizedBox(height: 16.0),
                DropdownMenu<String>(
                  initialSelection: selectedSmell,
                  dropdownMenuEntries: productData.smells.map((e) {
                    return DropdownMenuEntry<String>(
                        value: e,
                        label: e.toString()
                    );
                  }).toList(),
                  onSelected: (value) {
                    setState(() {
                      selectedSmell = value;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  height: 44.0,
                  child: ElevatedButton(
                    onPressed: selectedSmell != "" && selectedSmell != null ?
                        (){} : null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: primaryColor,
                      textStyle: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    child: const Text("Adicionar ao carrinho",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text("Descrição",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  ),
                ),
                Text(productData.description,
                  style: const TextStyle(
                    fontSize: 16.0
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
