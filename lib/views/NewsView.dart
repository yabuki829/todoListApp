import 'package:flutter/material.dart';

class NewsVew extends StatefulWidget {
  const NewsVew({super.key});

  @override
  State<NewsVew> createState() => _NewsVewState();
}

class _NewsVewState extends State<NewsVew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "お知らせ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: const Text("rest"),
    );
  }
}
