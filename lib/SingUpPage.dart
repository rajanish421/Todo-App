import 'package:flutter/material.dart';
import 'AuthPage.dart';
import 'LoginPage.dart';
class SingUpPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String?  userName ;
  String? email;
  String? password;

  void trySubmit(BuildContext context){
    final isValidated = _formKey.currentState!.validate();
    if(isValidated){
      _formKey.currentState!.save();
      return singUp(context ,email!,password!);
    }else{
      return print('error');
    }

  }
      SingUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Login Page"),
      //   centerTitle: true,
      // ),
      body:Container(
        width: double.infinity,
        height: double.infinity,
        // height: MediaQuery.of(context).devicePixelRatio,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/login.jpg'),
              fit: BoxFit.cover,
            )
        ),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("SingUp",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: Colors.black26),),
                const SizedBox(height: 50,),
                TextFormField(
                  key: ValueKey('name'),
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                      hintStyle: TextStyle(color: Colors.grey.shade300),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                  validator: (value) {
                    if(value.toString().isEmpty){
                      return 'Name should not be empty';
                    }
                  },
                  onSaved: (newValue) {
                    userName = newValue.toString();
                  },
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  key: ValueKey('email'),
                  validator: (value) {
                    if(value.toString().contains('@gmail.com')){
                        return null;
                    }
                    else{
                      return 'Invalid email';
                    }
                  },
                  decoration:  InputDecoration(
                    hintText: 'Enter your email',
                      hintStyle: TextStyle(color: Colors.grey.shade300),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                  onSaved: (newValue) {
                    email = newValue.toString();
                  },
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  key: ValueKey('password'),
                  decoration:  InputDecoration(
                      hintText: 'Enter your new password',
                      hintStyle: TextStyle(color: Colors.grey.shade300),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                  validator: (value) {
                    if(value.toString().length <6){
                      return "Password should not be less than 6 character";
                    }else{
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    password = newValue.toString();
                  },
                ),
                const SizedBox(height: 60,),
                ElevatedButton(onPressed: (){
                  trySubmit(context);
                }, child:const Text("SingUp",style: TextStyle(color: Colors.grey),)),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage(),));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Aleady have an account" ),
                      SizedBox(width: 10,),
                      Text("Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}
