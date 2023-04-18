// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'create_folders_screen.dart';
import 'folder_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenScreenState createState() => _MainScreenScreenState();
}

class _MainScreenScreenState extends State<MainScreen> {
  final List<String> _folders = ['Blood analyses'];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextButton(
              onPressed: () async {
                final result = await showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 200.0,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: SizedBox(
                                height: 30,
                                child: Image.asset('assets/folder_icon.png')),
                            title: const Text('Create folder'),
                            onTap: () {
                              Navigator.pop(context, 'create_folder');
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
                      builder: (context) => const CreateFolderScreen(),
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
              child: Row(
                children: const [
                  Icon(Icons.add_rounded),
                  Text('Create'),
                ],
              ),
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
                      leading: SizedBox(
                          height: 30,
                          child: Image.asset('assets/folder_icon.png')),
                      title: Text(
                        _folders[index],
                        style: theme.textTheme.bodyMedium,
                      ),
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
