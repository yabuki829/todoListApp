import 'package:flutter/material.dart';

class Todoview extends StatefulWidget {
  const Todoview({super.key, required this.title});
  final String title;
  @override
  State<Todoview> createState() => _TodoviewState();
}

class _TodoviewState extends State<Todoview> {
  String myGoal = "メルカリでエンジニアとして働く";
  List _todoList = [];
  Future<void> getTodoList() async {
    // final url = Uri.https("api.github.com","users/yabuki829/repos");
    // final response = await http.get(url);
    // final List list = json.decode(response.body);

    // final List<Repository> repositories =
    // list.map((item) => Repository.fromJson(item)).toList();
    // setState(() {
    //   _repositories = repositories;
    // });
    setState(() {
      _todoList.add("新しく追加");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Column(
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              myGoal,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      body: _todoList.isEmpty
          ? const SizedBox.shrink()
          : ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: ((context, index) {
                return Row(
                  children: [
                    Text(_todoList[index]),
                  ],
                );
              }),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: getTodoList,
        child: const Icon(Icons.add),
      ),
    );
  }
}
