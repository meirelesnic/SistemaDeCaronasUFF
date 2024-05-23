import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uff_caronas/view/custom_widgets/veiculoCard.dart';
import '../model/DAO/VeiculoDAO.dart';
import '../model/modelos/Veiculo.dart';
import 'login.dart';

class MeusVeiculos extends StatefulWidget {
  const MeusVeiculos({Key? key}) : super(key: key);

  @override
  State<MeusVeiculos> createState() => _MeusVeiculosState();
}

class _MeusVeiculosState extends State<MeusVeiculos> {
  List<Veiculo> veiculos = [];

  @override
  void initState() {
    super.initState();
    _carregarVeiculos();
  }

  Future<void> _carregarVeiculos() async {
    veiculos = await VeiculoDAO().recuperarVeiculosPorUsuario(user!.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add',
        child: Icon(
          Icons.add,
          size: screenSize.height * (1 / 25),
        ),
      ),
      body: Column(
        children: [
          SafeArea(
            child: Container(
              height: screenSize.height * (130.0 / 800.0),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                border: Border(
                  right: BorderSide(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    width: 2.0,
                  ),
                  left: BorderSide(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    width: 2.0,
                  ),
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    width: 2.0,
                  ),
                ),
              ),
              child: Container(
                width: screenSize.width,
                alignment: AlignmentDirectional.center,
                margin: EdgeInsets.symmetric(
                    horizontal: screenSize.width * (25 / 360)),
                child: Text(
                  'Meus Veículos',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                      fontSize: screenSize.height * (33 / 800)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: veiculos.length,
              itemBuilder: (context, index) {
                return VeiculoCard(veiculo: veiculos[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}