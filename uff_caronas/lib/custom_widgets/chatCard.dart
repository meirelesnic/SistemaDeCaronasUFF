import 'package:flutter/material.dart';

class ChatCard extends StatefulWidget {
  const ChatCard({super.key});

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        width: screenSize.width * (300 / 360),
        height: screenSize.height * (89 / 800),
        child: Container(
          padding: EdgeInsets.all(screenSize.width * (10/360)),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Carona de Roberto',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text('Nome passageiros',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.chat_bubble_outline),
                      Container(width: 6),
                      Text('Mensagem',
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: screenSize.height * (15/800)),
                    child: Badge.count(
                      //largeSize: screenSize.width * (20/360),
                      
                      count: 2
                    ),
                  ),
                  Text('09:37')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}