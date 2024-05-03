import 'package:flutter/material.dart';
import 'package:uff_caronas/telas/chatFeed.dart';
import 'package:uff_caronas/telas/historico.dart';
import 'package:uff_caronas/telas/home.dart';
import 'package:uff_caronas/telas/perfil.dart';

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
            backgroundColor: Theme.of(context).colorScheme.surface),
        child: NavigationBar(
            selectedIndex: indexScreen,
            onDestinationSelected: (value) {
              setState(() {
                indexScreen = value;
              });
              pageController.animateToPage(value,
                  duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
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
                icon: Icon(Icons.messenger_outline),
                label: 'Chat',
                selectedIcon: Icon(Icons.messenger),
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                label: 'Perfil',
                selectedIcon: Icon(Icons.person),
              ),
            ]),
      ),
    );
  }
}
