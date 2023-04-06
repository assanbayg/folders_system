import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'add_files_to_folder_screen.dart';
import 'create_folders_screen.dart';

class AddFilesScreen extends StatefulWidget {
  @override
  _AddFilesScreenState createState() => _AddFilesScreenState();
}

class _AddFilesScreenState extends State<AddFilesScreen> {
  List<String> _folders = ['Blood analysis'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text(
              'Analyses',
              style: TextStyle(fontSize: 20),
            ),
            TextButton(
              onPressed: () async {
                final result = await showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 200.0,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.folder),
                            title: Text('Create folder'),
                            onTap: () {
                              Navigator.pop(context, 'create_folder');
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.attach_file),
                            title: Text('Add single file'),
                            onTap: () {
                              Navigator.pop(context, 'add_single_file');
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
                if (result == 'create_folder') {
                  final folderName = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateFolderScreen(),
                    ),
                  );
                  if (folderName != null) {
                    setState(() {
                      _folders.add(folderName);
                    });
                  }
                } else if (result == 'add_single_file') {
                  final result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    setState(() {
                      _folders.add(result.files.single.path as String);
                    });
                  }
                }
              },
              child: Text('Add'),
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                itemCount: _folders.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddFilesToFolderScreen(
                            folderName: _folders[index],
                          ),
                        ),
                      );
                      if (result != null) {
                        setState(() {
                          _folders[index] = result;
                        });
                      }
                    },
                    child: ListTile(
                      leading: Icon(Icons.folder),
                      title: Text(_folders[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
