import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _usuarioController = TextEditingController();

  TextEditingController _senhaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("images/login.png", width: 180),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Text(
            "UFF Caronas",
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
                fontSize: 40),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'E-mail UFF',
                  ),
                  controller: _usuarioController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Digite seu e-mail.";
                    }
                    if (!value.contains("@")) {
                      return "Digite um e-mail válido.";
                    }
                    if (!value.contains("uff.br")) {
                      return "Digite um e-mail da uff.";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "senha"),
                  controller: _senhaController,
                  obscureText: true,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Digite sua senha.";
                    } else if (value.length < 4) {
                      return "A senha deve ter mais de 4 dígitos.";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () {
                          _formKey.currentState!.validate();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ))),
                TextButton(
                    onPressed: () {}, child: const Text("Esqueceu a senha?")),
              ],
            ),
          ),
        ),
        Container(
            width: 200,
            padding: EdgeInsets.only(bottom: 10),
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surface),
                child: const Text(
                  "Registrar-se",
                ))),
      ],
    ));
  }
}
