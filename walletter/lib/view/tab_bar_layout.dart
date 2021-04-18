import 'package:flutter/material.dart';
import 'package:walletter/view/tela01/tela01_main.dart';
import 'package:walletter/view/tela02/tela02_main.dart';
import 'package:walletter/view/tela03/tela03_main.dart';
import 'package:walletter/view/tela04/tela04_main.dart';

class MyTabBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: DefaultTabController(
          length: 4,
          initialIndex: 0,
          child: Scaffold(
            appBar: AppBar(
              title: Text("TabBar Layout"),
              bottom: TabBar(
                isScrollable: true, // tabs roláveis
                tabs: [
                  Tab(
                    child: Text("Primeira Tela"),
                    icon: Icon(Icons.access_alarm),
                  ),
                  Tab(
                    text: "Segunda Tela",
                    icon: Icon(Icons.account_box),
                  ),
                  Tab(
                    icon: Icon(Icons.cake),
                    child: Text("Terceira Tela"),
                  ),
                  Tab(
                    icon: Icon(Icons.text_fields_rounded),
                    child: Text("Quarta Tela"),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                // Center(child: Text("Tela 1")),
                // Center(child: Text("Tela 2")),
                // Center(child: Text("Tela 3")),
                MainTela1(),
                MainTela2(),
                MainTela3(),
                MainTela4(),
              ],
            ),
          ),
        ));
  }
}
