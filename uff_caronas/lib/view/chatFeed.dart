import 'package:flutter/material.dart';
import 'package:uff_caronas/model/DAO/ChatGrupoDAO.dart';
import 'package:uff_caronas/model/modelos/chatGrupo.dart';
import 'package:uff_caronas/view/custom_widgets/chatCard.dart';
import 'package:uff_caronas/view/custom_widgets/chatListBuilder.dart';
import 'login.dart';

class ChatFeed extends StatefulWidget {
  const ChatFeed({super.key});

  @override
  State<ChatFeed> createState() => _ChatFeedState();
}

class _ChatFeedState extends State<ChatFeed> {
  final ChatGrupoDAO _chatGrupoDAO = ChatGrupoDAO();

  // @override
  // void initState() {
  //   super.initState();
  //   //_chatGrupoDAO.createDocumentWithSubcollection(' ');
  //   //_chatGrupoDAO.addMemberToChat('zbLpf36RnImxzOYEgP3h', user!.id, user!.nome);
  // }

  // Future<void> _fetchChatGrupo() async {
  //   chatGrupos = await _chatGrupoDAO.getChatGruposByUserId(user!.id);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          SafeArea(
            child: Container(
              height: screenSize.height * (130.0 / 800.0),
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                border: Border(
                  right: BorderSide(
                    color: Theme.of(context).colorScheme.secondaryContainer, // cor da linha de contorno
                    width: 2.0, // largura da linha de contorno
                  ),
                  left: BorderSide(
                    color: Theme.of(context).colorScheme.secondaryContainer, // cor da linha de contorno
                    width: 2.0, // largura da linha de contorno
                  ),
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.secondaryContainer, // cor da linha de contorno
                    width: 2.0, // largura da linha de contorno
                  ),
                ),
              ),
              child: Container(
                width: screenSize.width,
                alignment: AlignmentDirectional.centerStart,
                margin: EdgeInsets.symmetric(horizontal: screenSize.width * (25/360)),
                child: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text('Chat',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                      fontSize: screenSize.height * (33/800)
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<ChatGrupo>>(
              stream: _chatGrupoDAO.getChatGruposStreamByUserId(user!.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Nenhum chat encontrado.'));
                }

                return ChatListBuilder(grupos: snapshot.data!);
              },
            ),
          )
        ],
      ),
    );
  }
}