import 'package:flutter/material.dart';
import 'package:uff_caronas/custom_widgets/chatCard.dart';

class ChatListBuilder extends StatefulWidget {
  const ChatListBuilder({super.key});

  @override
  State<ChatListBuilder> createState() => _ChatListBuilderState();
}

class _ChatListBuilderState extends State<ChatListBuilder> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; 
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * (10 / 360)),
      child: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index){
          return ChatCard();
        }
      ),
    );
  }
}