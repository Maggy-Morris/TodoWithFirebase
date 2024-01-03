import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todosssss/screens/home.dart';
import 'package:uuid/uuid.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final uuid = const Uuid();


  addtasktofirebasse() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User user = await auth.currentUser!;
    String uid = user.uid;
      String taskId = uuid.v4(); // Generate a unique task ID

    
    var time = DateTime.now();
    await FirebaseFirestore.instance
        // .collection('users').
        // doc(user.toString())
        .collection('tasks')
        .doc(uid)

        .collection('mytasks')
        .doc(taskId)
        .set({

      'user':user.email,
      'taskId': taskId,
      'title': titleController.text,
      'description': descriptionController.text,
      'time': time.toString(),
      'timestamp':time,
    });
    Fluttertoast.showToast(msg: 'Task Added');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                    labelText: 'Enter Title', border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                    labelText: 'Enter Description',
                    border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  style: ButtonStyle(backgroundColor:
                      MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return const Color.fromARGB(255, 125, 248, 217);
                    return Theme.of(context).primaryColor;
                  })),
                  onPressed: () {
                    addtasktofirebasse();
                    

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Home()));
                  },
                  child: Text(
                    'Add Task',
                    style: GoogleFonts.roboto(fontSize: 20),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
