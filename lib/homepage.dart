import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/LoginPage.dart';
import 'package:todo_app/addTask.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _taskController = TextEditingController();
  TextEditingController _desController = TextEditingController();
  String time = DateFormat.MMMEd().format(DateTime.now());

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _desController.dispose();
    _taskController.dispose();
  }
  // -------------- Functions ----------------//


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15),
        child: FloatingActionButton(
          onPressed: ()
          {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom, ),
                  child: Wrap(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              TextField(
                                controller: _taskController,
                                maxLines: null,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Task name",
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: _desController,
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Description",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: (){
                            if(_desController.text.toString().isEmpty && _taskController.text.toString().isEmpty){
                              return print('please write something ');
                            }else{
                              addTask(_taskController.text.toString(), _desController.text.toString());
                              _taskController.clear();
                              _desController.clear();
                            }
                          },

                          child: Text('submit'),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
        title: Text('Today'),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut().then((value) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
                });
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 20,
              child: Text(time),
            ),
          ),
          Divider(),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).snapshots(),
              builder:(context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                final task = snapshot.data;
                return ListView.separated(
                  itemCount: snapshot.data!.docs.length,
                    itemBuilder:(context, index) {
                      return ListTile(

                      title: Text(task!.docs[index]['task'].toString(),maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold),),
                        subtitle: Text(task.docs[index]['description'].toString(),maxLines: 1,),
                        trailing: IconButton(icon: Icon(Icons.done_outline_outlined),onPressed: ()async{
                          final id = task.docs[index]['id'];
                          await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc(id).delete();
                        },) ,
                      );
                    },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
