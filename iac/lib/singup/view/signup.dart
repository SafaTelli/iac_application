import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iac/routing_constants.dart';
import 'package:iac/singup/cubit/cubit/signup_cubit.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpStatee();
  }
}

class SignUpStatee extends State<SignUpPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final emailTextEditController = new TextEditingController();
  final nameTextEditController = new TextEditingController();
  final passwordTextEditController = new TextEditingController();
  final confirmPasswordTextEditController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xff386641)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state is SignUpLoading) {
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
            } else if (state is SignUpValid) {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(state.uid.toString())
                  .set({
                'firstName': nameTextEditController.text,
                'email': emailTextEditController.text,
              }).then((userInfoValue) {
                Navigator.of(context).pushNamed(HomeViewRoute);
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                      'Une erreur est survenue, veuillez essayer encore!')));

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
                      'Créer un Compte',
                      style: TextStyle(
                          color: Color(0xff386641),
                          fontSize: 35,
                          fontFamily: 'Google-Sans'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      controller: nameTextEditController,
                      autocorrect: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your last name.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Nom et Prénom',
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
                    child: TextField(
                      controller: emailTextEditController,
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
                    child: TextField(
                      autocorrect: true,
                      controller: passwordTextEditController,
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
                    padding: EdgeInsets.all(5),
                    child: TextField(
                      controller: confirmPasswordTextEditController,
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText: 'Comfirmation du mot de passe',
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
                          BlocProvider.of<SignupCubit>(context).signUp(
                              emailTextEditController.text,
                              passwordTextEditController.text);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                color: Color(0xff386641),
                                width: 1,
                                style: BorderStyle.solid)),
                        child: const Text("Créer un compte"),
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

  /*void _validateRegisterInput() async {
    await _firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailTextEditController.text,
            password: passwordTextEditController.text)
        .then((onValue) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(onValue.user!.uid)
          .set({
        'firstName': nameTextEditController.text,
        'email': emailTextEditController.text,
      }).then((userInfoValue) {
        Navigator.of(context).pushNamed(HomeViewRoute);
      });
    }).catchError((onError) {
      print("error");
      print(onError.toString());
      //processError(onError);
    });
  }*/
}
