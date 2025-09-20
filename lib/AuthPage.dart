import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/homepage.dart';

void singUp(BuildContext context ,String email,String password)async{
 try{
   UserCredential? credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
     email: email,
     password: password,
   ).then((value) {
     print('User created');
     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage(),));
   });
 }on FirebaseAuthException catch(e){
   print(e.toString());
 }
}


void singIn(BuildContext context ,String email ,String password)async{
 try{
   UserCredential? credential =await FirebaseAuth.instance.signInWithEmailAndPassword(
     email: email,
     password: password,
   ).then((value){
     print('Successfully login');
     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage(),));
   });
 }on FirebaseAuthException catch(e){
   print(e.toString());
 }
}