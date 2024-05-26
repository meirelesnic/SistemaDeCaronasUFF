import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uff_caronas/view/custom_widgets/messageBubble.dart';

class ChatMessages extends StatefulWidget {
  const ChatMessages({super.key});

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [
    {
      'message': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum sed quam turpis.',
      'time': '20/04 09:30',
      'isSender': false,
      'username': 'Cleiton',
    },
    {
      'message': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum sed quam turpis.',
      'time': '20/04 09:32',
      'isSender': true,
      'username': 'Você',
    },
    {
      'message': 'Aliquam eget enim et velit malesuada tincidunt.',
      'time': '20/04 09:33',
      'isSender': false,
      'username': 'Maria',
    },
    {
      'message': 'Curabitur quis nulla vehicula, varius justo a, consequat odio.',
      'time': '20/04 09:34',
      'isSender': false,
      'username': 'Lucas',
    },
    {
      'message': 'Donec sit amet sem vehicula, semper urna a, facilisis felis.',
      'time': '20/04 09:35',
      'isSender': true,
      'username': 'Você',
    },
    {
      'message': 'Praesent a libero vitae nisi vestibulum ullamcorper.',
      'time': '20/04 09:36',
      'isSender': false,
      'username': 'Cleiton',
    },
    {
      'message': 'Vestibulum at erat vel orci efficitur condimentum.',
      'time': '20/04 09:37',
      'isSender': true,
      'username': 'Você',
    },
    {
      'message': 'Nam vitae augue eget sapien varius scelerisque.',
      'time': '20/04 09:38',
      'isSender': false,
      'username': 'Maria',
    },
  ];


  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add({
          'message': _controller.text,
          'time': '20/04 09:30', // Aqui você pode adicionar lógica para obter o horário atual
          'isSender': true,
          'username': 'Você', // Você pode ajustar conforme necessário
        });
        //ADICIONAR MENSAGEM AO BANCO DE DADOS
        _controller.clear();
        _scrollController.position.minScrollExtent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.background,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome Chat',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.background
              )
            ),
            Text('User1, User2, User3',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.background
              )
            )
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final messageIndex = _messages.length - 1 - index;
                return MessageBubble(
                  message: _messages[messageIndex]['message'],
                  time: _messages[messageIndex]['time'],
                  isSender: _messages[messageIndex]['isSender'],
                  username: _messages[messageIndex]['username'],
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            //margin: EdgeInsets.all(10),
            color: Theme.of(context).colorScheme.onInverseSurface,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Digite sua mensagem...',
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
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