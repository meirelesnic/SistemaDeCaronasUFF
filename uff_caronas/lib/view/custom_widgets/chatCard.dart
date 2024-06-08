import 'package:flutter/material.dart';
import 'package:uff_caronas/model/modelos/chatGrupo.dart';
import 'package:uff_caronas/view/chatMessages.dart';
import 'package:uff_caronas/view/login.dart';
import '../../controller/UsuarioController.dart';
import '../../model/modelos/Usuario.dart';

class ChatCard extends StatefulWidget {
  final ChatGrupo chat;
  const ChatCard({super.key, required this.chat});

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  late UsuarioController usuarioController;
  String passageiros = '';

  @override
  void initState() {
    super.initState();
    usuarioController = UsuarioController();
    fetchPassageiros(widget.chat.membersId);
  }

  Future<String> fetchPassageiros(List<String> passageirosIds) async {
    String fetchedPassageiros = '';
    for (String id in passageirosIds) {
      Usuario? usuario = await usuarioController.recuperarUsuario(id);
      if (usuario != null) {
        fetchedPassageiros += '${usuario.nome.split(' ').first}, ';
      }
    }
    
    if (fetchedPassageiros.isNotEmpty) {
      fetchedPassageiros = fetchedPassageiros.substring(0, fetchedPassageiros.length - 2);
    }
    return fetchedPassageiros;
  }


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return ChatMessages(chat: widget.chat, nomeUsuarios: passageiros,);
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 250),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: SizedBox(
          width: screenSize.width * (300 / 360),
          height: screenSize.height * (89 / 800),
          child: Container(
            padding: EdgeInsets.all(screenSize.width * (10/360)),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.chat.nomeChat,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      FutureBuilder<String>(
                        future: fetchPassageiros(widget.chat.membersId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Text(' ');
                          } else if (snapshot.hasError) {
                            return const Text('Erro ao carregar os passageiros');
                          } else {
                            return Text(passageiros = snapshot.data ?? '',
                              style: Theme.of(context).textTheme.bodySmall,
                            );
                          }
                        },
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.chat_bubble_outline),
                            Container(width: 6),
                            Expanded(
                              child: Text(widget.chat.ultimaMensagem['mensagem'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: screenSize.height * (15/800)),
                      child: Badge.count(
                        isLabelVisible: (widget.chat.mensagensTotais - (widget.chat.members[user!.id]?['readCount'] as int))>0,
                        count: widget.chat.mensagensTotais - (widget.chat.members[user!.id]?['readCount'] as int) 
                      ),
                    ),
                    Text("${widget.chat.ultimaMensagem?['hora'] != null ? widget.chat.ultimaMensagem!['hora'].toDate().hour.toString().padLeft(2, '0') : ''}:${widget.chat.ultimaMensagem?['hora'] != null ? widget.chat.ultimaMensagem!['hora'].toDate().minute.toString().padLeft(2, '0') : ''}",),
                    Text("${widget.chat.ultimaMensagem?['hora'] != null ? (widget.chat.ultimaMensagem!['hora'].toDate()).day.toString().padLeft(2, '0') : ''}/${widget.chat.ultimaMensagem?['hora'] != null ? (widget.chat.ultimaMensagem!['hora'].toDate()).month.toString().padLeft(2, '0') : ''}")
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}