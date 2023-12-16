import 'package:flutter/material.dart';
import 'main.dart';
class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  String selectedCategory = 'University';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[600],
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  setState(() {
                    _dueDateController.text =
                    "${pickedDate.toLocal()}".split(' ')[0];
                  });
                }
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: _dueDateController,
                  decoration: InputDecoration(
                    labelText: 'Due Date',
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text('Select Task Category:', style: TextStyle(fontSize: 18)),
            DropdownButton<String>(
              value: selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
              items: <String>['University', 'Work', 'Personal', 'Other']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
              ),
              onPressed: () {
                DateTime dueDate = DateTime.parse(_dueDateController.text);

                Task newTask = Task(
                  title: _titleController.text,
                  description: _descriptionController.text,
                  dueDate: dueDate,
                  category: selectedCategory,
                );
                Navigator.pop(context, newTask);
              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.lightBlue[900],
    );
  }
}


