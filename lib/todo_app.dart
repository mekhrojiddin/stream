import 'package:flutter/material.dart';
import 'package:to_do_app/repository/repository.dart';

class StreamPage extends StatefulWidget {
  const StreamPage({super.key});

  @override
  State<StreamPage> createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  FocusNode titlenode = FocusNode();
  FocusNode descriptionnode = FocusNode();

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  late Repository repository;

  @override
  void initState() {
    repository = Repository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<ToDoModel>>(
        stream: repository.stream,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: Text("No Todo"),
            );
          } else {
            final todos = snapshot.data!;
            return ListView.separated(
                itemBuilder: (_, index) => ListTile(
                      title: Text(todos[index].title),
                      subtitle: Text(todos[index].desc),
                    ),
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemCount: todos.length);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          openDialog();

          // await repository.createToDo('${title.text}', '${description.text}');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    super.dispose();
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (_) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 95),
            child: AlertDialog(
              title: Text("To Do"),
              content: Column(children: [
                TextField(
                  focusNode: titlenode,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'New Title',
                  ),
                  cursorOpacityAnimates: true,
                  enabled: true,
                  // expands: true,
                  showCursor: true,
                  controller: title,
                ),
                TextField(
                  focusNode: descriptionnode,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'New Description',
                  ),
                  enabled: true,
                  // expands: true,
                  showCursor: true,
                  controller: description,
                )
              ]),
              actions: [
                TextButton(
                  onPressed: () async {
                    await repository.createToDo(
                        '${title.text}', '${description.text}');
                    Navigator.pop(context);
                  },
                  child: Text("Save"),
                ),
              ],
            ),
          ));
}

// import 'dart:math';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class Thread extends StatefulWidget {
//   const Thread({super.key});

//   @override
//   State<Thread> createState() => _ThreadState();
// }

// class _ThreadState extends State<Thread> {
//   int? factorial;
//   bool isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           isLoading = true;
//           setState(() {
//             factorial = Random().nextInt(30);
//           });
//           await Future.delayed(Duration(seconds: 1));
//         },
//       ),
//       body: Builder(builder: (context) {
//         if (isLoading) {
//           return Center(child: CupertinoActivityIndicator());
//         } else {
//           if (factorial == null) {
//             return Center(
//               child: Text("Number not selected"),
//             );
//           } else {
//             return Center(
//               child: Text(
//                   "Factorial: $factorial,result: ${getFactorial(factorial!)}"),
//             );
//           }
//         }
//       }),
//     );
//   }

//   BigInt getFactorial(int value) {
//     BigInt result = BigInt.from(value);
//     for (var i = 0; i <= value; i++) {
//       result *= BigInt.from(i);
//     }
//     return result;
//   }
// }
