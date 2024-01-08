import 'package:flutter/material.dart';

class AppGifs {
  AppGifs._();
  static String get _contactAs => 'assets/gifs/contactAs.gif';
  static String get _sadFace => 'assets/gifs/sadFace.gif';
  static String get _waiting => 'assets/gifs/waiting.gif';
  static String get _loading => 'assets/gifs/loading.gif';

  static Widget get contactAs => Image.asset(
        _contactAs,
      );
  static Widget get sadFace => Image.asset(
        _sadFace,
      );
  static Widget get waiting => Image.asset(
        _waiting,
      );
  static Widget get loading => Image.asset(
        _loading,
      );
}
