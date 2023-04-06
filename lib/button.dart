import 'package:flutter/material.dart';
import 'dart:async';

import 'package:open_file_plus/open_file_plus.dart';

class MyButton extends StatefulWidget {
  final String filePath;

  MyButton({required this.filePath});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  var _openResult = 'Unknown';

  Future<void> openFile() async {
    final filePath = widget.filePath;
    final result = await OpenFile.open(filePath);

    setState(() {
      _openResult = "type=${result.type}  message=${result.message}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: openFile,
      child: Text(widget.filePath),
    );
  }
}
