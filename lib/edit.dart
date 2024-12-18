import 'package:flutter/material.dart';
import 'package:notes/NoteProvider.dart';
import 'package:notes/note.dart';
import 'package:provider/provider.dart';

class EditPage extends StatefulWidget {
  final Note note;

  const EditPage({required this.note});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late String value;

  @override
  void initState() {
    super.initState();
    value = widget.note.text;
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Вернуться',
        ),
        title: Text("Изменение заметки"),
        backgroundColor: Color(0xFF9067C6),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Вы можете изменить заметку",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF242038)),
          ),
          SizedBox(
            width: 200,
            child: TextField(
              onChanged: (newValue) {
                value = newValue;
              },
              controller: TextEditingController(text: value),
              decoration: InputDecoration(
                hintText: "Ваша заметка",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: SizedBox(
              width: 85,
              height: 45,
              child: FloatingActionButton(
                backgroundColor: Color(0xFF9067C6),
                onPressed: () {
                  noteProvider.edit(widget.note.id, value);
                  Navigator.pop(context);
                },
                child: Text("Сохранить", style: TextStyle(color: Color(0xFF242038))),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
