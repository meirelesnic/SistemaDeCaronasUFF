import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uff_caronas/controller/UsuarioController.dart';
import 'package:uff_caronas/model/DAO/VeiculoDAO.dart';
import 'package:uff_caronas/model/modelos/Usuario.dart';
import 'package:uff_caronas/model/modelos/Veiculo.dart';
import 'package:uff_caronas/view/mainScreen.dart';
import 'package:uff_caronas/controller/AutenticaçãoController.dart';
import 'package:uff_caronas/view/perfil.dart';
import '../model/DAO/AvaliacaoDAO.dart';
import '../model/Services/googleAuthenticator.dart';

Usuario? user;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static const routeName = "/login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "image/login.png",
              width: 180,
            ),
            SizedBox(height: 90),
            Text(
              "UFF Caronas",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
                fontSize: 40,
              ),
            ),
            SizedBox(height: 80),
            ElevatedButton.icon(
              onPressed: () async {
                var autenticacaocontroller = AutenticacaoController();
                var usuarioController = UsuarioController();
                if (await autenticacaocontroller.googleAutenticar(context)) {
                  var currentUser = googleSignIn.currentUser;
                  user = Usuario(id: currentUser!.id, nome: currentUser.displayName!, email: currentUser.email, fotoUrl: currentUser.photoUrl!);
                  if(await usuarioController.usuarioExiste(user!.id)){
                    var usuarioBanco = await usuarioController.recuperarUsuario(user!.id);
                    user?.nome = usuarioBanco!.nome;
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return MainScreen();
                        },
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        transitionDuration: Duration(milliseconds: 250),
                      ),
                    );
                  } else {
                    usuarioController.salvarUsuario(user!.id, user!.nome, user!.email, user!.fotoUrl);
                    AvaliacaoDAO.verificarECriarDocumento(user!.id);
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return MainScreen();
                        },
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        transitionDuration: Duration(milliseconds: 250),
                      ),
                    );
                  }
                } else {
                  googleSignIn.disconnect();
                }
              },
              icon: FaIcon(FontAwesomeIcons.google),
              label: const Text(
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
    );
  }
}
