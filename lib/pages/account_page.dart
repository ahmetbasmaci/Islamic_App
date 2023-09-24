import 'package:flutter/material.dart';
import 'package:zad_almumin/constents/assets_manager.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);
  static const id = 'AccountPage';
  @override
  
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: <Widget>[
          Expanded(flex:2,child: Image.asset(ImagesManager.quran)),
          Expanded(flex:3,child:Column(
            children: <Widget>[],
          ) ),
        ],
      )
    );
  }
}
