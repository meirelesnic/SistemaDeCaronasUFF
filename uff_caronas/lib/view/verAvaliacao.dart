import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uff_caronas/view/custom_widgets/avaliacaoCard.dart';

class VerAvaliacao extends StatefulWidget {
  final bool isMotorista;
  const VerAvaliacao({super.key, required this.isMotorista});

  @override
  State<VerAvaliacao> createState() => _VerAvaliacaoState();
}

class _VerAvaliacaoState extends State<VerAvaliacao> {
  

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
                    Text('4,8',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Icon(Icons.star_rounded)
                  ],
                )
              ],
            ),
            const SizedBox(height: 35,),
           const AvaliacaoCard(),
          ],
        ),
      ),
    );
  }
}