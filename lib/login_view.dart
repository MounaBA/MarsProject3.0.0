/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */

import 'package:flutter/material.dart';
import 'package:ic_fantasy_football/register_view.dart';
import 'package:ic_fantasy_football/forgot_password_view.dart';
import 'package:ic_fantasy_football/model/user.dart';
import 'package:ic_fantasy_football/controller/internet_async.dart';
import 'package:ic_fantasy_football/constants.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => new _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String username = "", password = "";

  Widget signIn = Text("Sign In");

  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? kSpaceM : kSpaceS;
    return WillPopScope(
      onWillPop: () => null,
      child: Scaffold(
          body: Scrollbar(
              child: SingleChildScrollView(
                  child: Builder(
        builder: (context) => Container(
          padding: const EdgeInsets.all(40.0),
          child: new Form(
            autovalidate: true,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                Text(
                  "MARS Poject \n         Protege Tibia",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.blueGrey[900],
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                Image.asset(
                  "assets/logo3.png",
                  height: 100.0,
                  alignment: Alignment.center,
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                // new TextField(
                //   decoration: new InputDecoration(
                //       hintText: "Username", fillColor: Colors.white),
                //   keyboardType: TextInputType.emailAddress,
                //   onChanged: (String value) {
                //     username = value;
                //   },
                // ),

                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                // new TextField(
                //   decoration: new InputDecoration(
                //       hintText: "Password", fillColor: Colors.white),
                //   obscureText: true,
                //   keyboardType: TextInputType.text,
                //   onChanged: (String value) {
                //     password = value;
                //   },
                // ),
                new Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                ),

                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return ForgotPasswordView();
                    })),
                    child: Text(
                      "Forgot your password?",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.lightBlueAccent),
                    ),
                  ),
                ),

                new Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                ),
                new MaterialButton(
                    height: 50.0,
                    minWidth: 200.0,
                    color: Colors.blueAccent,
                    splashColor: Colors.teal,
                    textColor: Colors.white,
                    child: signIn,
                    onPressed: () {
                      setState(() {
                        signIn = FutureBuilder<User>(
                          future: InternetAsync()
                              .fetchUser(context, username, password),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Text("Sign In");
                            }

                            // By default, show a loading spinner
                            return CircularProgressIndicator();
                          },
                        );
                      });
                    }),
                new Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                ),
                new MaterialButton(
                  height: 50.0,
                  minWidth: 200.0,
                  color: Colors.blueAccent,
                  splashColor: Colors.teal,
                  textColor: Colors.white,
                  child: Text("Register"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return RegisterView();
                    }));
                  },
                )
              ],
            ),
          ),
        ),
      )))),
    );
  }
}
