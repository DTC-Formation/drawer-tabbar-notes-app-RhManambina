import 'package:flutter/material.dart';
import 'package:projet/navbar.dart';
import 'package:projet/views/affichagenote.dart';
import 'package:projet/views/home.view.dart';

// ignore: must_be_immutable
class Bar extends StatelessWidget {
  List<Menu> menuNote = [Menu("Nouvelle Note"), Menu("Affichage note ")];

  Bar({super.key});
  mytabs() {
    return menuNote
        .map((e) => Tab(
              text: e.title,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: menuNote.length,
      child: Scaffold(
          backgroundColor: Colors.white70,
          //Drawer
          drawer: const NavBar(),
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: const Center(
              child: Text(
                'Block Note',
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: AutofillHints.birthday,
                    fontWeight: FontWeight.w500),
              ),
            ),
            bottom: TabBar(tabs: mytabs()),
          ),
          body: const TabBarView(
            children: <Widget>[
              HomeView(),
              AffichageNote(),
              // NoteView(),
            ],
          )),
    );
  }
}

class Menu {
  String title;
  Menu(this.title);
}
