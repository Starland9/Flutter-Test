import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          label: 'Acceuil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.wallet_outlined),
          label: 'Portefeuille',
        ),
        BottomNavigationBarItem(
          icon: FloatingActionButton(onPressed: () {}, child: Icon(Icons.send)),
          label: '',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Historique'),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person),
          label: 'Compte',
        ),
      ],
    );
  }
}
