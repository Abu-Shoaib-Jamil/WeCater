import 'package:flutter/material.dart';
import 'package:wecater/shareditems/loadingscreen.dart';
import 'package:wecater/services/authservice.dart';
import 'package:wecater/shareditems/inputfield.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginkey = GlobalKey<FormState>();
  late String _email,_password;
  bool _isLoading = false;
  bool _isObscure = true;
  late String _result;
  Future _login()async{
    var _value = await Authentication().loginUsingEmailPass(email: _email, password: _password);
    setState((){
      _result = _value;
    });
  }
  Future _passwordReset({required String resetemail})async{
    return await Authentication().passwordReset(email: resetemail);
  }
  void _obscureChange()async{
    setState(() {
      _isObscure = !_isObscure;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //WeCater logo and Text
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
            //Login Form
            Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Form(
                    key: _loginkey,
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                                validator: (val)=>(val!.isEmpty)?"Please enter email":null,
                          ),
                              ),
                            ),
                        ),
                        SizedBox(height:30.0),
                        //Password Field
                        Expanded(
                          flex:1,
                            child: Container(
                              child: Center(
                                child: TextFormField(
                                obscureText: _isObscure,
                                decoration : inputdeco.copyWith(labelText: "Password",labelStyle: TextStyle(fontWeight: FontWeight.w100),suffixIcon:(_isObscure)?InkWell(onTap:_obscureChange,child:Icon(Icons.lock)):InkWell(onTap:_obscureChange,child:Icon(Icons.lock_open))),
                                onChanged: (val){
                                  setState(() {
                                    _password = val;
                                  });
                                },
                                validator: (val)=>(val!.isEmpty)?"Please enter a password":null,
                          ),
                              ),
                            ),
                        ),
                        SizedBox(height:30.0),
                        //Login and Password Reset Button
                        Expanded(
                            flex:1,
                            child: Row(
                              mainAxisAlignment : MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //Login Button
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(80.0, 0.0, 0.0, 0.0),
                                  child: TextButton.icon(
                                  onPressed: ()async{
                                    if(_loginkey.currentState!.validate()){
                                      setState((){_isLoading=true;});                                      
                                    //   (_isLoading)?showDialog(context: context, builder: (context){
                                    //   return LoadingScreen();
                                    // }):Container();
                                      await _login();
                                      if(_result=='user-not-found'){
                                        setState((){_isLoading=false;});
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red,content:Text("User to the corresponding email not found.Check the email again or SignUp to continue",style: TextStyle(color:Colors.white),),),);
                                      }else if(_result=='wrong-password' || _result=='too-many-requests'){
                                        setState((){_isLoading=false;});
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red,content:Text("$_result",style: TextStyle(color:Colors.white),),),);
                                      }else{
                                        Navigator.popAndPushNamed(context, '/signinsignoutwrapper');
                                      }
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red,content: Text("Please enter correct information",style: TextStyle(color:Colors.white),),),);
                                    }
                                  },
                                  icon: Icon(Icons.login),
                                  label: Text("Login"),
                                  ),
                                ),
                                //Reset Password Button
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                                  child: TextButton(
                                    onPressed: ()async{
                                      String _resetemail="";
                                      showDialog(
                                        context: context, builder: (context){
                                        return Container(
                                          height: 100.0,
                                          width: 200.0,
                                          child: AlertDialog(
                                            elevation: 1,
                                            backgroundColor: Colors.white,
                                            content: TextFormField(
                                              decoration:inputdeco.copyWith(labelText:"Email"),
                                              onChanged: (val){
                                                setState((){_resetemail = val;});
                                              },
                                            ),
                                            actions:[
                                              TextButton(
                                                onPressed: ()=>Navigator.pop(context),
                                                child: Text("Cancel"),
                                              ),
                                              TextButton(
                                                onPressed: ()async{
                                                  var _result = await _passwordReset(resetemail: _resetemail);
                                                  if(_result=='invalid-email'||_result=='user-not-found'){
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.black,content:Text("$_result",style:TextStyle(color: Colors.white),),),);
                                                  }else{
                                                    Navigator.pop(context);
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.black,content:Text("Reset link has been successfully sent to $_resetemail",style:TextStyle(color: Colors.white),),),);
                                                  }
                                                },
                                                child:Text("Send Request"),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                    },
                                    child: Text("Forgot Password",style: TextStyle(color:Colors.black,fontSize: 14.0,decoration: TextDecoration.underline),),
                                  ),
                                )
                              ],
                            ),
                        ),
                      ],
                    ),
                ),
                  ),
            ),
            // FutureBuilder(future: ,builder: builder),
            //SignUp Button
            Expanded(
                flex:1,
                child: Container(
                  child: Center(
                    child: TextButton(
                      onPressed: ()async{
                        await Navigator.pushReplacementNamed(context, '/signuppage');
                      }, 
                      child: Text("Don't have an account? SignUp"),
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