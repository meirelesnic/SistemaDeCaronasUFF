import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isSender;
  final String username;
  final double raio;

  const MessageBubble({
    required this.message,
    required this.time,
    required this.isSender,
    required this.username,
    this.raio = 33
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        margin: isSender
            ? EdgeInsets.fromLTRB(50, 5, 10, 5)
            : EdgeInsets.fromLTRB(10, 5, 50, 5),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
          color: isSender
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primaryContainer,
          borderRadius: isSender
              ? BorderRadius.only(
                  topLeft: Radius.circular(raio),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(raio),
                  bottomRight: Radius.circular(raio),
                )
              : BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(raio),
                  bottomLeft: Radius.circular(raio),
                  bottomRight: Radius.circular(raio),
                ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              username,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isSender
                        ? Theme.of(context).colorScheme.background
                        : Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
            SizedBox(height: 5),
            Text(
              message,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: isSender
                        ? Theme.of(context).colorScheme.background
                        : Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
            SizedBox(height: 5),
            Text(
              time,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isSender
                        ? Theme.of(context).colorScheme.background
                        : Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}