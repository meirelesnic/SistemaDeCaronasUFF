import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../model/Services/googleAuthenticator.dart';

class AutenticacaoController {

  Future<bool> googleAutenticar(BuildContext context) async {
    final provider = Provider.of<GoogleSignProvider>(context, listen: false);
    return await provider.googleLogin();
  }

}