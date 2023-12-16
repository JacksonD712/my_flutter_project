// main.dart

import 'package:flutter/material.dart';
import 'feedback.dart';
import 'add_task.dart';
import 'login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Task> tasks = [];
  List<FeedbackItem> feedbacks = [];
  int _currentIndex = 0;


  List<String> taskCategories = ['Task', 'Work', 'University', 'Personal', 'Other'];
  String selectedCategory = 'Task';

  void _addTask(Task newTask) {
    setState(() {
      tasks.add(newTask);
    });
  }

  void _addFeedback(String feedback) {
    setState(() {
      feedbacks.add(FeedbackItem(content: feedback));
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[600],
        title: _currentIndex == 0
            ? DropdownButton<String>(
          dropdownColor: Colors.lightBlue,
          value: selectedCategory,
          items: taskCategories.map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedCategory = newValue!;
            });
          },
        )
            : Text('Feedbacks'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.assignment),
            onPressed: () {
              setState(() {
                _currentIndex = 0;
              });
            },
          ),

          IconButton(

            icon: Icon(Icons.feedback),
            color: Colors.white,
            onPressed: () {
              setState(() {
                _currentIndex = 1;
              });
            },
          ),
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.login),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),


      body: _currentIndex == 0
          ? tasks.isEmpty
          ? Center(
        child: Text(

          'No tasks in the $selectedCategory category.',
          style: TextStyle(fontSize: 18.0),

        ),
      )
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {

          if (selectedCategory == 'Task' || tasks[index].category == selectedCategory) {
            return ListTile(
              title: Text(tasks[index].title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tasks[index].description),
                  Text('Due: ${tasks[index].dueDate}'),
                  Text('Category: ${tasks[index].category}'),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {

                  _deleteTask(index);
                },
                child: Text('Done'),
              ),
            );
          } else {
            return Container();
          }
        },
      )
          : ListView.builder(
        itemCount: feedbacks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Feedback ${index + 1}'),
            subtitle: Text(feedbacks[index].content),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          if (_currentIndex == 0) {
            Task newTask = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTaskPage()),
            );
            if (newTask != null) {
              _addTask(newTask);
            }
          } else {
            FeedbackItem newFeedback = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FeedbackPage(
                  onFeedbackSubmitted: _addFeedback,
                ),
              ),
            );

          }
        },
        child: Icon(_currentIndex == 0 ? Icons.add : Icons.feedback),
      ),
      backgroundColor: Colors.lightBlue[900],
    );
  }
}

class Task {
  String title;
  String description;
  DateTime dueDate;
  String category;

  Task({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.category,
  });
}

class FeedbackItem {
  String content;

  FeedbackItem({
    required this.content,
  });
}
