import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uff_caronas/controller/UsuarioController.dart';
import 'package:uff_caronas/model/DAO/AvaliacaoDAO.dart';
import 'package:uff_caronas/view/custom_widgets/fazerAvaliacaoCard.dart';
import 'package:uff_caronas/view/mainScreen.dart';
import '../model/modelos/Carona.dart';
import '../model/modelos/Usuario.dart';
import 'login.dart';

class FazerAvaliacao extends StatefulWidget {
  final bool isMotorista;
  final Carona carona;
  const FazerAvaliacao({super.key, required this.isMotorista, required this.carona});

  @override
  State<FazerAvaliacao> createState() => _FazerAvaliacaoState();
}

class _FazerAvaliacaoState extends State<FazerAvaliacao> {
  UsuarioController _usuarioController = UsuarioController();
  bool isPassageirosLoading = true;
  List<Usuario> passageiros = [];
  List<String> comentarios = [];
  List<int> notas = [];
  List<bool> notasBool =  [];
  List<bool> comentariosBool = [];

  @override
  void initState() {
    if(!widget.isMotorista){
      if (widget.carona.passageirosIds != null) {
        fetchPassageiros(widget.carona.passageirosIds!);
      }
    }else{
      fetchPassageiros([widget.carona.motoristaId]);
    }
    super.initState();
  }

  void fetchPassageiros(List<String> passageirosIds) async {
    List<Usuario> fetchedPassageiros = [];
    for (String id in passageirosIds) {
      Usuario? usuario = await _usuarioController.recuperarUsuario(id);
      if (usuario != null) {
        fetchedPassageiros.add(usuario);
      }
    }
    setState(() {
      passageiros = fetchedPassageiros;
      comentarios = List<String>.filled(passageirosIds.length, ' ');
      notas = List<int>.filled(passageirosIds.length,-1);
      notasBool =  List<bool>.filled(passageirosIds.length, false);
      comentariosBool =  List<bool>.filled(passageirosIds.length, false);
      isPassageirosLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * (26/360)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Avaliação',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    widget.isMotorista ? 
                    Text('Motorista',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ) :
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Passageiro',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text('Obrigatório avaliar todos',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 35,),
            isPassageirosLoading ?
            Center(
              child: CircularProgressIndicator(),
            )
            :
            passageiros.isEmpty ?
            Center(
              child: Text('Não houveram passageiros na carona'),
            )
            :
            Expanded(
              child: ListView.builder(
                itemCount: passageiros.length,
                itemBuilder: (context, index){
                  
                  return FazerAvaliacaoCard(
                    key: ValueKey(passageiros[index].id),
                    usuario: passageiros[index],
                    notaCallback: (int nota){
                      print(nota);
                      print(index);
                      notasBool[index] = true;
                      notas[index] = nota;
                    },
                    comentarioCallback: (String? comentario){
                      print(comentario);
                      if(comentario!.isEmpty){
                        print('vazio');
                        comentariosBool[index] = false;
                      }else{
                        comentariosBool[index] = true;
                        comentarios[index] = comentario;
                      }
                    },
                  );
                }
              )
            ),
            Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: screenSize.width,
                  height: screenSize.height * (45 / 800),
                  child: FilledButton(
                    onPressed: () {
                      if(notasBool.every((element) => element == true) && comentariosBool.every((element) => element == true)){
                        for (int i = 0; i < passageiros.length; i++) {
                          AvaliacaoDAO.salvarAvaliacao(
                            passageiros[i].id,
                            widget.isMotorista,
                            user!.nome,
                            notas[i],
                            comentarios[i]
                            );
                        }
                        AvaliacaoDAO.definirAvaliacaoUsuario(user!.id, widget.carona.id);
                        Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return const MainScreen();
                          },
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 250),
                        ),
                      );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Por favor, preencha todos os campos obrigatórios.'),
                            duration: Duration(seconds: 5),
                            backgroundColor: Theme.of(context).colorScheme.error
                          ),
                        );
                      }
                    },
                    child: Text('Fazer Avaliação'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}