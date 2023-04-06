import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'button.dart';

class AddFilesToFolderScreen extends StatefulWidget {
  final String folderName;

  AddFilesToFolderScreen({required this.folderName});

  @override
  _AddFilesToFolderScreenState createState() => _AddFilesToFolderScreenState();
}

class _AddFilesToFolderScreenState extends State<AddFilesToFolderScreen> {
  List<String> _files = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.folderName),
      ),
      body: Column(
        children: <Widget>[
          TextButton(
            child: Text(widget.folderName),
            onPressed: () async {
              final result = await FilePicker.platform.pickFiles();
              if (result != null) {
                setState(() {
                  _files.add(result.files.single.path as String);
                });
              }
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _files.length,
              itemBuilder: (BuildContext context, int index) {
                return MyButton(filePath: _files[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
