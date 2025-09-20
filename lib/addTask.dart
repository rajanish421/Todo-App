import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import'package:firebase_auth/firebase_auth.dart';

Future<void> addTask(String _taskController,String _desController)async{
  final task = _taskController;
  final desc = _desController;
  final id = DateTime.now().millisecondsSinceEpoch.toString();
CollectionReference<Map<String , dynamic>> _ref = await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid);
Map<String , dynamic> data = {
  'username':'uid',
  'uid':FirebaseAuth.instance.currentUser!.uid,
  'task':task,
  'description':desc,
  'id':id,
};
DocumentReference doc = _ref.doc(id);
doc.set(data).then((value) {
  print('Tast Added');
}).onError((error, stackTrace) {print(error.toString());});
}
