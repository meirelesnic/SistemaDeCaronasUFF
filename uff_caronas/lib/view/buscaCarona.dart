import 'package:flutter/material.dart';
import 'package:uff_caronas/model/DAO/CaronaDAO.dart';
import '../model/modelos/Carona.dart';
import 'custom_widgets/BuscaCaronaListBuilder.dart';

class BuscaCarona extends StatefulWidget {
  final List<double> origemCoord;
  final List<double> destinoCoord;
  final String dataCarona;

  const BuscaCarona({super.key, 
    required this.dataCarona,
    required this.origemCoord,
    required this.destinoCoord});

  @override
  State<BuscaCarona> createState() => _BuscaCaronaState();
}

class _BuscaCaronaState extends State<BuscaCarona> {
  List<Carona> caronas = [];

  @override
  void initState() {
    super.initState();
    //_carregarCaronas(widget.dataCarona);
  }

  //TESTE IMPLEMENTAR O FILTRO AQUI
  Future<void> _carregarCaronas(data, oLat, oLon, dLat, dLon) async {
    caronas = await CaronaDAO().buscarCaronasPorDataEVagas(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.background,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Buscar Caronas',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.background
              )
            ),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(widget.dataCarona,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
              ),
            ),
            Expanded(
              child: FutureBuilder<void>(
                future: _carregarCaronas(
                  widget.dataCarona,
                  widget.origemCoord[0],
                  widget.origemCoord[1],
                  widget.destinoCoord[0],
                  widget.destinoCoord[1],
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Erro ao carregar caronas: ${snapshot.error}'),
                    );
                  } else if (caronas.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          Text('Nenhuma carona encontrada para esta data'),
                          Text('linha 2'),
                        ],
                      ),
                    );
                  } else {
                    return BuscaCaronaListBuilder(caronas: caronas);
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
