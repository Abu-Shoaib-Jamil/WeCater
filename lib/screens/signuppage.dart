import 'package:flutter/material.dart';
import 'package:wecater/services/authservice.dart';
import 'package:wecater/shareditems/inputfield.dart';
import 'package:table_calendar/table_calendar.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}
//Need to add email validator and a calender to add DOB.
class _SignUpPageState extends State<SignUpPage> {
  final _signupkey = GlobalKey<FormState>();
  late String _email,_password,_name,_dob;
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
                child: Center(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                  direction: Axis.horizontal,
                  spacing:20.0,
                  children: [
                    CircleAvatar(backgroundColor: Colors.purple[900],backgroundImage:AssetImage("asset/logo.png"),radius:50.0),
                    Text("WeCater",style: TextStyle(fontSize: 28.0,fontWeight: FontWeight.bold,),),
                  ],
              ),
                ),
            ),
            Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Form(
                    key: _signupkey,
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Name field
                      Expanded(
                            flex:1,
                            child: Container(
                              child: Center(
                                child: TextFormField(
                                decoration : inputdeco.copyWith(labelText: "Name",labelStyle: TextStyle(fontWeight: FontWeight.w100),),
                                onChanged: (val){
                                  setState(() {
                                    _name = val;
                                  });
                                },
                                validator: (val){
                                 if(val!.isEmpty){
                                   return "Please enter your name";
                                 }else if(val.length<5){
                                   return "Please enter your full name ";
                                 }else{
                                   return null;
                                 }
                                },
                          ),
                              ),
                            ),
                        ),
                        SizedBox(height:10.0),
                        //DOB field
                        Expanded(
                            flex:1,
                            child: Container(
                              child: Center(
                                child: TextFormField(
                                  readOnly: true,
                                  decoration : inputdeco.copyWith(suffixIcon: InkWell(onTap:()async{
                                    //Open the table calendar here
                                    print("Enter DOB");
                                    Builder(builder: (context){
                                      return TableCalendar(focusedDay: DateTime.now(), firstDay: DateTime.utc(2010, 10, 16), lastDay: DateTime.utc(2030, 3, 14)); 
                                    },);
                                  },child: Icon(Icons.calendar_today)),
                                  labelText: "Date of Birth",
                                  labelStyle: TextStyle(fontWeight: FontWeight.w100),),
                                  onChanged: (val){
                                    setState(() {
                                      _dob = val;
                                    });
                                  },
                                  validator: (val){
                                    
                                  },
                                ),
                              ),
                            ),
                        ),
                        SizedBox(height:10.0),
                        //Email Field
                        Expanded(
                            flex:1,
                            child: Container(
                              child: Center(
                                child: TextFormField(
                                decoration : inputdeco.copyWith(labelText: "Email",labelStyle: TextStyle(fontWeight: FontWeight.w100),),
                                onChanged: (val){
                                  setState(() {
                                    _email = val;
                                  });
                                },
                                validator: (val){
                                  if(val!.isEmpty){
                                    return "Please enter email";
                                  }
                                },
                          ),
                              ),
                            ),
                        ),
                        SizedBox(height:10.0),
                        //Password Field
                        Expanded(
                          flex:1,
                            child: Container(
                              child: Center(
                                child: TextFormField(
                                decoration : inputdeco.copyWith(labelText: "Password",labelStyle: TextStyle(fontWeight: FontWeight.w100),),
                                onChanged: (val){
                                  setState(() {
                                    _password = val;
                                  });
                                },
                                validator: (val){
                                 if(val!.isEmpty){
                                   return "Please enter a password";
                                 }else if(val.length<8){
                                   return "Wrong password";
                                 }else{
                                   return null;
                                 }
                                },
                          ),
                              ),
                            ),
                        ),
                        //Login Button
                        Expanded(
                            flex:1,
                            child: Container(
                              child: Center(
                                child: TextButton.icon(
                                onPressed: ()async{
                                  setState(() {
                                    _loading = true;
                                  });
                                  (_loading)?showDialog(context: context, builder: (context){return AlertDialog(content: CircularProgressIndicator(),elevation: 1,backgroundColor: Colors.white,);}):Container();
                                  if(_signupkey.currentState!.validate()){
                                    var _result = await Authentication().signUpUsingEmailPass(email: _email, password: _password);
                                    setState(() {
                                      _loading = false;
                                    });
                                    if(_result!=null && _result!='User already exit.Please Login to continue'){
                                      //Make a page called CateringPage and make a route to it in main.dart
                                      Navigator.popAndPushNamed(context, '/signinsignoutwrapper');
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$_result"),),);
                                    }
                                  }else{
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error LoginIn"),),);
                                  }
                                },
                                icon: Icon(Icons.login),
                                label: Text("SignUp"),
                          ),
                              ),
                            ),
                        ),
                      ],
                    ),
                ),
                  ),
            ),
            Expanded(
                flex:1,
                child: Container(
                  child: Center(
                    child: TextButton(
                      onPressed: ()async{
                        await Navigator.pushReplacementNamed(context, '/loginpage');
                      }, 
                      child: Text("Already have an account? Login"),
                    ),
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}