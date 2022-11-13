
import 'package:flutter/material.dart';

class MenuOptionsItem {
  MenuOptionsItem({required this.title, required this.icon, required this.onTap});
  String title;
  Widget icon;
  VoidCallback onTap;
}
