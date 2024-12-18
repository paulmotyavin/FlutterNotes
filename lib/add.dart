import 'package:flutter/material.dart';
import 'package:notes/NoteProvider.dart';
import 'package:notes/note.dart';
import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String value = "";

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushNamed(context, '/'),
          tooltip: 'Вернуться',
        ),
        title: Text("Создание заметки"),
        backgroundColor: Color(0xFF9067C6),
        shape: RoundedRectangleBorder(
            side: BorderSide(
                strokeAlign: BorderSide.strokeAlignOutside,
                color: Color(0xFF242038)),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Введите вашу заметку",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF242038)),
          ),
          SizedBox(
            width: 200,
            child: TextField(
                style: TextStyle(color: Color(0xFF242038)),
                onChanged: (value1) {
                  value = value1;
                },
                onSubmitted: (value) {
                },
                decoration: InputDecoration(
                  hintText: "Ваша заметка",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFF9067C6))),
                )),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: SizedBox(
              width: 85,
              height: 45,
              child: FloatingActionButton(
                backgroundColor: Color(0xFF9067C6),
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: Color(0xFF242038)),
                    borderRadius: BorderRadius.circular(15)),
                onPressed: (){
                  Note note = Note(id: DateTime.now().hashCode, text: value, date: DateTime.now());
                  noteProvider.add(note);
                  Navigator.pop(context);
                },
                child: Text(
                  "Добавить",
                  style: TextStyle(color: Color(0xFF242038)),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
