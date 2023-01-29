import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'What to eat',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'What to eat'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _item;

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/sample.json');
    final data = await json.decode(response);
    setState(() {
      var index = Random().nextInt(data['items'].length);
      _item = data['items'][index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('What to eat?', style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 250,
              width: 250,
              child: _item != null
                  ? Image(
                      height: 250,
                      width: 250,
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        _item["imageUrl"],
                      ),
                    )
                  : const Placeholder(),
            ),
            const SizedBox(height: 10),
            FilledButton(onPressed: readJson, child: const Text('Press me')),
          ],
        ),
      ),
    );
  }
}
