import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSignIn = GoogleSignIn();

class GoogleSignProvider extends ChangeNotifier {

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future<bool> googleLogin() async {
    final googleUser = await googleSignIn.signIn();

    if(googleUser == null) return false;

    final email = googleUser.email;
    if (!email.endsWith('@id.uff.br')) {
      // Email não é do domínio desejado, fazer algo (por exemplo, mostrar uma mensagem de erro)
      return false;
    }

    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    notifyListeners();

    return true;
  }

}