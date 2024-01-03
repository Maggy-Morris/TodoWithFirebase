import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class Description extends StatefulWidget {
  final String title, description,taskId;
  const Description({Key? key, required this.title, required this.description, required this.taskId})
      : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  bool _isEditing = false;
  

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _descriptionController = TextEditingController(text: widget.description);
  }

void _updateData() async {
  try {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser!;
    String uid = user.uid;

    String updatedTitle = _titleController.text;
    String updatedDescription = _descriptionController.text;
    var time = DateTime.now();

    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('mytasks')
        .doc(widget.taskId)  // Use widget.taskId as the document ID
        .update({
      'title': updatedTitle,
      'description': updatedDescription,
      'updatedAt': time.toString(),
       'timestamp':time,
    });

    setState(() {
      _isEditing = false;
    });

    // Show a message or navigate back after updating
  } catch (e) {
    print('Error updating data: $e');
  }

  Fluttertoast.showToast(msg: 'Task Updated Successfully');
  Navigator.pop(context);
}


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Description')),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: _isEditing
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextField(
                                controller: _titleController,
                                style: GoogleFonts.roboto(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Enter title',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            )
                          : Text(
                              widget.title,
                              style: GoogleFonts.roboto(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isEditing = !_isEditing;
                        });
                      },
                      icon: const Icon(Icons.create_rounded),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(12),
                  child: _isEditing
                      ? TextField(
                          controller: _descriptionController,
                          style: GoogleFonts.roboto(fontSize: 18),
                          maxLines: 20,
                          decoration: InputDecoration(
                            hintText: 'Enter description',
                            border: OutlineInputBorder(),
                          ),
                        )
                      : Text(
                          widget.description,
                          style: GoogleFonts.roboto(fontSize: 18),
                        ),
                ),
              ),
              if (_isEditing)
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
                      },
                    )),
                    onPressed: () {
                      _updateData();
                    },
                    child: Text(
                      'Update',
                      style: GoogleFonts.roboto(fontSize: 20),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
