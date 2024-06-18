import 'package:flutter/material.dart';
import 'dart:io';

class FullImageScreen extends StatelessWidget {
  final File imageFile;

  const FullImageScreen({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Image'),
      ),
      body: Center(
        child: Image.file(imageFile),
      ),
    );
  }
}
