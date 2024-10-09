import 'package:flutter/material.dart';

class NewsVew extends StatefulWidget {
  const NewsVew({super.key});

  @override
  State<NewsVew> createState() => _NewsVewState();
}

class _NewsVewState extends State<NewsVew> {
  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text('ニュース'),
        ),
        // SliverToBoxAdapter(
        //   child: Text('ニュース'),
        // )
      ],
    );
  }
}
