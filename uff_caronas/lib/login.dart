import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:uff_caronas/Services/googleAuthenticator.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static const routeName = "/login";

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "UFF Caronas",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: ()  {
                      final provider =
                          Provider.of<GoogleSignProvider>(context, listen: false);
                      provider.googleLogin();
                      //materialpageroute
                    },
                    icon: FaIcon(FontAwesomeIcons.google),
                    label: Text(
                      "Sign in with Google",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
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
