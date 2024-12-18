import 'package:flutter/material.dart';
import 'package:notes/note.dart';
import 'add.dart';
import 'edit.dart';
import 'NoteProvider.dart';
import 'package:provider/provider.dart';

void main() {
  final noteProvider = NoteProvider();

  runApp(
    ChangeNotifierProvider<NoteProvider>.value(
      value: noteProvider,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes Prakt 5',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => HomePage());
          case '/add':
            return MaterialPageRoute(builder: (context) => AddPage());
          case '/edit':
            final note = settings.arguments as Note;
            return MaterialPageRoute(
                builder: (context) => EditPage(note: note));
          default:
            return MaterialPageRoute(builder: (context) => HomePage());
        }
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Заметки'),
        backgroundColor: Color(0xFF9067C6),
      ),
      body: Center(
        child: noteProvider.notes.isNotEmpty
            ? ReorderableListView.builder(
          itemCount: noteProvider.notes.length,
          itemBuilder: (context, index) {
            return Container(
              key: ValueKey(noteProvider.notes[index].id),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: ListTile(
                title: Text(noteProvider.notes[index].text),
                subtitle: Text(noteProvider.notes[index].date.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.black),
                      style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(),
                          backgroundColor: Color(0xFF9067C6)),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/edit',
                          arguments: noteProvider.notes[index],
                        );
                      },
                      tooltip: 'Редактировать',
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.black),
                      style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(),
                          backgroundColor: Color(0xFFC66767)),
                      onPressed: () {
                        noteProvider.delete(noteProvider.notes[index].id);
                      },
                      tooltip: 'Удалить',
                    ),
                  ],
                ),
              ),
            );
          },
          onReorder: (int oldIndex, int newIndex) {
            if (newIndex > oldIndex) newIndex--;
            final note = noteProvider.notes.removeAt(oldIndex);
            noteProvider.notes.insert(newIndex, note);
            noteProvider.notifyListeners();
          },
        )
            : const Text('Нет заметок'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF9067C6),
        shape: CircleBorder(),
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        tooltip: 'Добавить заметку',
        child: const Icon(Icons.add, color: Color(0xFF242038)),
      ),
    );
  }
}
