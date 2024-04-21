import 'package:flutter/material.dart';
import 'package:uff_caronas/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UFF Caronas',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromRGBO(103, 80, 164, 1)),
        useMaterial3: true,
      ),
      //Verificar se esta autenticado
      // ...
      //Se nao estiver autenticado
      home: const Login(),
      //Se tiver autenticado
      //home: const Home(),
    );
  }
}
