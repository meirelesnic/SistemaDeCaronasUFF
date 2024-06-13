import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../model/modelos/Usuario.dart';

class FazerAvaliacaoCard extends StatefulWidget {
  final Usuario usuario;
  final Function notaCallback;
  final Function comentarioCallback;
  const FazerAvaliacaoCard({ Key? key, required this.notaCallback, required this.comentarioCallback, required this.usuario,}) : super(key: key);

  @override
  State<FazerAvaliacaoCard> createState() => _FazerAvaliacaoCardState();
}

class _FazerAvaliacaoCardState extends State<FazerAvaliacaoCard> with AutomaticKeepAliveClientMixin{
  TextEditingController _textEditingController = TextEditingController();
  int nota = 0;
  final List<bool> _notaBool = List<bool>.filled(5, false);
  @override
  Widget build(BuildContext context) {
    super.build(context);

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
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.usuario.fotoUrl),
                    backgroundColor: Colors.blue,
                    radius: screenSize.width * (25 / 360),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.usuario.nome,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12,),
              Text('Nota:',
                style: Theme.of(context).textTheme.bodyLarge
              ),
              const SizedBox(height: 8,),
              ToggleButtons(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                fillColor: Theme.of(context).colorScheme.primary,
                selectedColor: Colors.white,
                isSelected: _notaBool,
                children: const [
                  Text('1'),
                  Text('2'),
                  Text('3'),
                  Text('4'),
                  Text('5'),
                ],
                onPressed: (int index) {
                  widget.notaCallback(index+1);
                  setState(() {
                    for (int i = 0; i < _notaBool.length; i++) {
                      _notaBool[i] = i == index;
                      nota = index + 1;
                    }
                  });
                },
              ),
              const SizedBox(height: 10,),
              Text('Comentário:',
                style: Theme.of(context).textTheme.bodyLarge
              ),
              const SizedBox(height: 8,),
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Deixe seu comentário',
                ),
                onChanged: widget.comentarioCallback(_textEditingController.text),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12,),
      ],
      
    );
  } 
  @override
  bool get wantKeepAlive => true;
}