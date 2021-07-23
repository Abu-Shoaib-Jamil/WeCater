import 'package:flutter/material.dart';
import 'package:listing/service/authservice.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginKey = GlobalKey<FormState>();
  late String _email,_password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _loginKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Email
                TextFormField(
                  decoration: InputDecoration(
                    enabledBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Email",
                  ),
                  validator: (val)=>val!.isEmpty?"Enter email":null,
                  onChanged: (val){
                    setState((){
                      _email = val;
                    });
                  },
                ),
                SizedBox(height:20.0),
                //Password
                TextFormField(
                  decoration: InputDecoration(
                    enabledBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Password",
                  ),
                  validator: (val)=>val!.isEmpty?"Enter Password":null,
                  onChanged: (val){
                    setState((){
                      _password=val;
                    });
                  },
                ),
                SizedBox(height:20.0),
                //Login Button
                TextButton(
                  onPressed:()async{
                    var _result = await Authentication().login(email: _email, password: _password);
                    if(_result=='user-not-found' || _result=='wrong-password'){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("$_result"),),);
                    }else{
                      Navigator.pushReplacementNamed(context, '/');
                    }
                  },
                  child:Text("Login"),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}