import 'package:flutter/material.dart';
import 'package:uff_caronas/view/custom_widgets/chatCard.dart';
import '../../model/modelos/chatGrupo.dart';

class ChatListBuilder extends StatefulWidget {
  final List<ChatGrupo> grupos;
  const ChatListBuilder({super.key, required this.grupos});

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
        itemCount: widget.grupos.length,
        itemBuilder: (context, index){
          return ChatCard(chat: widget.grupos[index]);
        }
      ),
    );
  }
}