import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items:  const [
      BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Home'), 
      BottomNavigationBarItem(icon: Icon(Icons.label_outline), label: 'Categorias'), 
      BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), label: 'Favoritos'), 
    ]);
  }
}