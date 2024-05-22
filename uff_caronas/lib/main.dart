import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uff_caronas/view/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uff_caronas/view/mainScreen.dart';
import 'firebase_options.dart';
import 'model/Services/googleAuthenticator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UFF Caronas',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF002147)),
          useMaterial3: true,
        ),
        //Verificar se esta autenticado
        // ...
        //Se nao estiver autenticado
        home: const Login(),
        //Se tiver autenticado
        //home: const Home(),
        routes: {
          Login.routeName: (context) => Login(),
        },
      ),
    );
  }
}

