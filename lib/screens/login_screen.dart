import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onThemeChanged;
  const LoginScreen({super.key, required this.onThemeChanged});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Chave para o Form
  String? _verificationId;
  bool showCodeField = false; // Variável para controlar a exibição do campo de código

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  final _auth = FirebaseAuth.instance;


  // final _googleSignInLauncher = :


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
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: widget.onThemeChanged, // Alterna o tema ao clicar no botão
          ),
        ],
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
                    keyboardType: TextInputType.name,
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
                              _sendVerificationCode();
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

  void _sendVerificationCode() async {
    final String phoneNumber = _phoneController.text.trim();

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {
        // Automatically verifies the code
        // Optionally handle this scenario
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro: ${e.message}")),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
          showCodeField = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Código de verificação enviado")),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  void _onSucess() {

  }

  void _onFail() {

  }

}
