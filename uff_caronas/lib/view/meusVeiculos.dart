import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uff_caronas/view/custom_widgets/veiculoCard.dart';
import 'package:uff_caronas/view/custom_widgets/veiculoListBuilder.dart';
import 'package:uff_caronas/view/editarVeiculo.dart';

class MeusVeiculos extends StatefulWidget {
  const MeusVeiculos({super.key});

  @override
  State<MeusVeiculos> createState() => _MeusVeiculosState();
}

class _MeusVeiculosState extends State<MeusVeiculos> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            
          },
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
                      color: Theme.of(context)
                          .colorScheme
                          .secondaryContainer, // cor da linha de contorno
                      width: 2.0, // largura da linha de contorno
                    ),
                    left: BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .secondaryContainer, // cor da linha de contorno
                      width: 2.0, // largura da linha de contorno
                    ),
                    bottom: BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .secondaryContainer, // cor da linha de contorno
                      width: 2.0, // largura da linha de contorno
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
            Expanded(child: VeiculoListBuilder()),
          ],
        ));
  }
}
