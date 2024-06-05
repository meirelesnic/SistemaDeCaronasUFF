import 'package:flutter/material.dart';
import 'package:uff_caronas/model/modelos/Usuario.dart';

class UsuarioCard extends StatefulWidget {
  final Usuario user;
  const UsuarioCard({super.key, required this.user});

  @override
  State<UsuarioCard> createState() => _UsuarioCardState();
}

class _UsuarioCardState extends State<UsuarioCard> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenSize.width * (5 / 360), horizontal: 0),
        child: Center(
          child: Container(
            // width: screenSize.width * (313 / 360),
            height: screenSize.height * (105 / 800),
            padding: EdgeInsets.all(screenSize.width * (9 / 360)),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.user!.fotoUrl),
                backgroundColor: Colors.blue,
                radius: screenSize.width * (30 / 360),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.user.nome,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      'Passageiro',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '4,8',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Icon(
                              Icons.star_rounded,
                              size: 16,
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            //ver reputacao ID
                          },
                          child: Text('Ver reputação'),
                        )
                      ],
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
