import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uff_caronas/view/custom_widgets/estrelas.dart';


class AvaliacaoCard extends StatefulWidget {
  //Avaliacao
  const AvaliacaoCard({super.key});

  @override
  State<AvaliacaoCard> createState() => _AvaliacaoCardState();
}

class _AvaliacaoCardState extends State<AvaliacaoCard> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return  Column(
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          //color: Theme.of(context).colorScheme.inversePrimary,
          decoration: BoxDecoration(
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
              top: BorderSide(
                color: Theme.of(context)
                    .colorScheme
                    .secondaryContainer, // cor da linha de contorno
                width: 2.0, // largura da linha de contorno
              ),
            ),
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Leonardo Maia',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold
                )
              ),
              SizedBox(
                width: screenSize.width * (90/360),
                child: Estrelas(rating: 4)
              ),
              const SizedBox(height: 10,),
              Text('"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus sit amet urna et nibh viverra maximus in ac leo. Suspendisse est felis, laoreet ac orci in, dapibus semper quam. Suspendisse nec sem mattis, facilisis magna sed,imperdiet leo. Etiam ornare elit a scelerisque consectetur."',
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          ),
        ),
        const SizedBox(height: 12,)
      ],
      
    );
  }
}