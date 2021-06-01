import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iac/login/cubit/cubit/login_cubit.dart';
import 'package:iac/routing_constants.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginStatee();
  }
}

class LoginStatee extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xff386641)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoadingState) {
              AlertDialog alert = AlertDialog(
                content: new Row(
                  children: [
                    CircularProgressIndicator(),
                    Container(
                        margin: EdgeInsets.only(left: 7),
                        child: Text("Chargement...")),
                  ],
                ),
              );
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            } else if (state is LoginValid) {
              Navigator.of(context).pushNamed(HomeViewRoute);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('Email ou mot de passe incorrecte')));

              Navigator.pop(context);
              FocusScope.of(context).requestFocus(FocusNode());
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
                child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(40),
                    child: Text(
                      'Connexion',
                      style: TextStyle(
                          color: Color(0xff386641),
                          fontSize: 35,
                          fontFamily: 'Google-Sans'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      controller: emailController,
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white70,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide:
                              BorderSide(color: Color(0xff3866416E), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Color(0xff3866416E), width: 1),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      controller: passwordController,
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText: 'Mot de passe',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white70,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide:
                              BorderSide(color: Color(0xff3866416E), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Color(0xff3866416E), width: 1),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FlatButton(
                        color: Color(0xff386641),
                        textColor: Color(0xffF2E8CF),
                        onPressed: () {
                          // ignore: avoid_dynamic_calls
                          BlocProvider.of<LoginCubit>(context).login(
                              emailController.text, passwordController.text);

                          /* if (_formKey.currentState!.validate()) {
                              signIn(emailController.text,
                                      passwordController.text)
                                  .then((uid) =>
                                      // ignore: lines_longer_than_80_chars
                                      {
                                        Navigator.of(context)
                                            .pushNamed(HomeViewRoute)
                                      })
                                  .catchError((error) => {
                                        //print(error)
                                        processError(error)
                                      });
                            } */
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                color: Color(0xff386641),
                                width: 1,
                                style: BorderStyle.solid)),
                        child: const Text("Se connecter"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FlatButton(
                          color: Color(0xffD4E4EF),
                          textColor: Color(0xffF2E8CF),
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                  color: Color(0xffD4E4EF),
                                  width: 1,
                                  style: BorderStyle.solid)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/google.png'),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Poursuivre avec Google',
                                  style: TextStyle(color: Color(0xff518EF8)),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ));
          },
        ));
  }

  Future<String> signIn(final String email, final String password) async {
    var user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user!.uid;
  }

  void processError(final FirebaseAuthException error) {
    if (error.code == "ERROR_USER_NOT_FOUND") {
      setState(() {
        _errorMessage = "Unable to find user. Please register.";
      });
    } else if (error.code == "ERROR_WRONG_PASSWORD") {
      setState(() {
        _errorMessage = "Incorrect password.";
      });
    } else {
      setState(() {
        _errorMessage =
            "There was an error logging in. Please try again later.";
      });
    }
  }
}
