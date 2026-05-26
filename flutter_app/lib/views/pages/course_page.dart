import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/views/data/classes/activity_class.dart';
import 'package:http/http.dart' as http;

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  late Future<Activity> _activityFuture;

  @override
  void initState() {
    super.initState();
    _activityFuture = fetchActivity();
  }

  Future<Activity> fetchActivity() async {
    final url = Uri.https("bored-api.appbrewery.com", "/random");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Activity.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    log("Request failed with status: ${response.statusCode}.");
    throw Exception("Failed to load activities");
  }

  void fetchAnotherActivity() {
    setState(() {
      _activityFuture = fetchActivity();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Activity Viewer')),
      body: FutureBuilder<Activity>(
        future: _activityFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No data'));
          }

          final activity = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Activity: ${activity.activity}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16.0),
                  Text('Type: ${activity.type}'),
                  Text('Participants: ${activity.participants}'),
                  Text('Price: ${activity.price}'),
                  Text('Availability: ${activity.availability}'),
                  Text('Accessibility: ${activity.accessibility}'),
                  Text('Duration: ${activity.duration}'),
                  Text('Kid-Friendly: ${activity.kidFriendly ? 'Yes' : 'No'}'),
                  const SizedBox(height: 32.0),
                  FilledButton.tonal(
                    onPressed: fetchAnotherActivity,
                    child: const Text('Fetch Another Activity'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
