import 'package:flutter/material.dart';
import 'package:uff_caronas/view/chatFeed.dart';
import 'package:uff_caronas/view/historico.dart';
import 'package:uff_caronas/view/home.dart';
import 'package:uff_caronas/view/perfil.dart';
import 'package:uff_caronas/model/DAO/ChatGrupoDAO.dart'; // Importar o ChatGrupoDAO

import 'login.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int indexScreen = 0;
  final screens = [Home(), Historico(), ChatFeed(), Perfil()];
  final pageController = PageController();
  final ChatGrupoDAO chatGrupoDAO = ChatGrupoDAO(); // Instanciar o ChatGrupoDAO

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            indexScreen = index;
          });
        },
        children: screens,
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Theme.of(context).colorScheme.secondaryContainer,
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        child: NavigationBar(
          selectedIndex: indexScreen,
          onDestinationSelected: (value) {
            setState(() {
              indexScreen = value;
            });
            pageController.animateToPage(
              value,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.house_outlined),
              label: 'Home',
              selectedIcon: Icon(Icons.home_filled),
            ),
            NavigationDestination(
              icon: Icon(Icons.directions_car_filled_outlined),
              label: 'Caronas',
              selectedIcon: Icon(Icons.directions_car_filled),
            ),
            NavigationDestination(
              icon: _buildChatIcon(), // Usar o método _buildChatIcon para construir o ícone do chat
              label: 'Chat',
              selectedIcon: Icon(Icons.messenger),
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              label: 'Perfil',
              selectedIcon: Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatIcon() {
    return StreamBuilder<int>(
      stream: chatGrupoDAO.getUnreadMessagesCountForAllChats(user!.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == 0) {
          return Icon(Icons.messenger_outline); 
        }
        int unreadCount = snapshot.data!;
        print('${unreadCount} Nao lidas');
        return Stack(
          children: [
            Icon(Icons.messenger_outline),
            Positioned(
              right: 0,
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: BoxConstraints(
                  minWidth: 12,
                  minHeight: 12,
                ),
                child: Text(
                  '$unreadCount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
