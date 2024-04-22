import 'package:flutter/material.dart';

class Historico extends StatefulWidget {
  const Historico({super.key});

  @override
  State<Historico> createState() => _HistoricoState();
}

class _HistoricoState extends State<Historico> {
  final TextEditingController periodoController = TextEditingController();
  final TextEditingController papelController = TextEditingController();
  String? selectedPeriodo = 'Atual';
  String? selectedPapel = 'Passageiro';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        child: Column(
          children: [
            SafeArea(
              child: Container(
                height: screenSize.height * (130.0 / 800.0),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.only(
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
                  alignment: AlignmentDirectional.centerStart,
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * (25 / 360)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      'Minhas Caronas',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: screenSize.height * (33 / 800)),
                    ),
                  ),
                ),
              ),
            ),
            //dropdown button
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownMenu<String>(
                    initialSelection: selectedPapel,
                    controller: papelController,
                    label: const Text('Papel'),
                    inputDecorationTheme: const InputDecorationTheme(
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                        fillColor: Colors.white
                    ),
                    onSelected: (String? s) {
                      setState(() {
                        selectedPapel = s;
                        //fazer consulta
                      });
                    },
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: 'Passageiro', label: 'Passageiro'),
                      DropdownMenuEntry(value: 'Motorista', label: 'Motorista'),
                    ]
                  ),
                  DropdownMenu<String>(
                    initialSelection: selectedPeriodo,
                    controller: periodoController,
                    label: const Text('Periodo'),
                    inputDecorationTheme: const InputDecorationTheme(
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                        fillColor: Colors.white
                    ),
                    onSelected: (String? s) {
                      setState(() {
                        selectedPeriodo = s;
                        //fazer consulta
                      });
                    },
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: 'Atual', label: 'Atual'),
                      DropdownMenuEntry(value: 'Passado', label: 'Passado'),
                    ]
                  )
                ],
              ),              
            )
          ],
        ),
      ),
    );
  }
}
