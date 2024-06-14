import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uff_caronas/model/DAO/AvaliacaoDAO.dart';
import 'package:uff_caronas/view/custom_widgets/avaliacaoCard.dart';
import 'package:uff_caronas/view/login.dart';

import '../model/modelos/Avaliacao.dart';

class VerAvaliacao extends StatefulWidget {
  final bool isMotorista;
  final String userId;
  const VerAvaliacao({super.key, required this.isMotorista, required this.userId});

  @override
  State<VerAvaliacao> createState() => _VerAvaliacaoState();
}

class _VerAvaliacaoState extends State<VerAvaliacao> {
  late Future<List<Avaliacao>> _avaliacoesFuture;
  double media = 0;

  @override
  void initState() {
    print(widget.userId);
    super.initState();
    _getMedia();
    _avaliacoesFuture = _carregarAvaliacoes();
    //AvaliacaoDAO.gerarAvaliacoesParaTodosUsuarios();
    //AvaliacaoDAO.salvarAvaliacao('1', widget.isMotorista, "Teste Silva", 3, 'comentario de teste');
  }

  Future<void> _getMedia() async{
    media = await AvaliacaoDAO.getMedia(widget.userId, widget.isMotorista);
    setState(() {
      
    });
  }

  Future<List<Avaliacao>> _carregarAvaliacoes() async {
    return await AvaliacaoDAO.resgatarAvaliacoes(widget.userId, widget.isMotorista);
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
                    Text('Passageiro',
                      style: Theme.of(context).textTheme.headlineSmall,
                    )
                  ],
                ),
                Row(
                  children: [
                    Text('${media}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Icon(Icons.star_rounded)
                  ],
                )
              ],
            ),
            const SizedBox(height: 35,),
            Expanded(
              child: FutureBuilder<List<Avaliacao>>(
                future: _avaliacoesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro ao carregar avaliações: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Nenhuma avaliação encontrada.'));
                  } else {
                    List<Avaliacao> avaliacoes = snapshot.data!;
                    return ListView.builder(
                      itemCount: avaliacoes.length,
                      itemBuilder: (context, index) {
                        return AvaliacaoCard(avaliacao: avaliacoes[index],);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}