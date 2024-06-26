import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uff_caronas/model/DAO/ChatGrupoDAO.dart';
import 'package:uff_caronas/model/modelos/chatGrupo.dart';
import 'package:uff_caronas/view/custom_widgets/messageBubble.dart';
import 'package:uff_caronas/view/login.dart';

import '../model/modelos/Mensagem.dart';

class ChatMessages extends StatefulWidget {
  final ChatGrupo chat;
  final String nomeUsuarios;
  const ChatMessages({super.key, required this.chat, required this.nomeUsuarios});

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ChatGrupoDAO _chatGrupoDAO = ChatGrupoDAO();

  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      await _chatGrupoDAO.sendMessage(widget.chat.docId, _controller.text, user!.nome, user!.id);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.surface,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.chat.nomeChat,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.surface
              )
            ),
            Text(widget.nomeUsuarios,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.surface
              )
            )
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Mensagem>>(
              stream: _chatGrupoDAO.getMensagensStream(widget.chat.docId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Erro ao carregar as mensagens'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Nenhuma mensagem'));
                }

                final mensagens = snapshot.data!;
                _chatGrupoDAO.markAsRead(user!.id, widget.chat.docId);
                
                return ListView.builder(
                  //controller: _scrollController,
                  reverse: true,
                  itemCount: mensagens.length,
                  itemBuilder: (context, index) {
                    final message = mensagens[index];
                    
                    return MessageBubble(
                      message: message.texto,
                      time: "${message.formattedTime}",
                      username: message.userName,
                      isSender: user!.id == message.userId,
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            color: Theme.of(context).colorScheme.onInverseSurface,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Digite sua mensagem...',
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
