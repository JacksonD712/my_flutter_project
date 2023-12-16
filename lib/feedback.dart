import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  final Function(String) onFeedbackSubmitted;

  FeedbackPage({required this.onFeedbackSubmitted});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  String feedbackText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[600],
        title: Text('Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Your Feedback'),
              maxLines: 5,
              onChanged: (value) {
                setState(() {
                  feedbackText = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
              primary: Colors.white,
            ),
              onPressed: () {


                widget.onFeedbackSubmitted(feedbackText);
                Navigator.pop(context);
              },
              child: Text('Submit Feedback'),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.lightBlue[900],
    );
  }
}
