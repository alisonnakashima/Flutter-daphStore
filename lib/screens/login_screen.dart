import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Chave para o Form
  bool showCodeField = false; // Variável para controlar a exibição do campo de código
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 26.0,
        ),
        title: const Text("DaphStore App"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey, // Associa a chave ao formulário
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      hintText: "Ex: Roberto de Souza ",
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "Insira seu nome";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(width: 8.0),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _phoneController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            hintText: "Ex: +55 44 987654321",
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (text) {
                            if (text == null || text.isEmpty || !text.contains("+55")) {
                              return "Telefone inválido!(DDI + DDD + número)";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      TextButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            setState(() {
                              showCodeField = true;
                            });
                          }
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: primaryColor,
                          textStyle: const TextStyle(fontSize: 14.0),
                        ),
                        child: const Text("Enviar SMS"),
                      ),
                    ],
                  ),
                  if (showCodeField) ...[
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            decoration: const InputDecoration(
                              hintText: "Insira o código recebido",
                            ),
                            keyboardType: TextInputType.number,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return "Nenhum código inserido.";
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        TextButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              // Lógica para verificar o código
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Código verificado com sucesso!")),
                              );
                            }
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: primaryColor,
                            textStyle: const TextStyle(fontSize: 14.0),
                          ),
                          child: const Text("Verificar código"),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: primaryColor,
                  textStyle: const TextStyle(fontSize: 16.0),
                ),
                child: const Text("Login com Google"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSucess() {

  }

  void _onFail() {

  }

}
