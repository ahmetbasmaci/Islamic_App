import 'package:flutter/material.dart';

class AudioFile {
  final String path;
  final String metasTitle;
  final String metasArtist;
  final String? metasAlbum;
  final VoidCallback? onComplite;
  AudioFile({
    required this.path,
    required this.metasTitle,
    required this.metasArtist,
    this.metasAlbum,
    this.onComplite,
  });
}
