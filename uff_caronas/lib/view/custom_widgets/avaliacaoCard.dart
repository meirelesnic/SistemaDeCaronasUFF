import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uff_caronas/model/modelos/Avaliacao.dart';
import 'package:uff_caronas/view/custom_widgets/estrelas.dart';


class AvaliacaoCard extends StatefulWidget {
  final Avaliacao avaliacao;
  const AvaliacaoCard({super.key, required this.avaliacao});

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
          width: screenSize.width,
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
              Text(widget.avaliacao.autor,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold
                )
              ),
              SizedBox(
                width: screenSize.width * (90/360),
                child: Estrelas(rating: widget.avaliacao.nota)
              ),
              const SizedBox(height: 10,),
              Text('"${widget.avaliacao.comentario}"',
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