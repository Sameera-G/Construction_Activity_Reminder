import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:constreminder/model/my_encryption.dart';
import 'package:constreminder/screens/login.dart';
import 'package:constreminder/screens/notregisteredpg.dart';
import 'package:constreminder/screens/registereduserpg.dart';
import 'package:constreminder/screens/registration.dart';
import 'package:constreminder/screens/remindbyarea.dart';
import 'package:constreminder/screens/addreminder.dart';
import 'package:constreminder/screens/reminderlist.dart';
import 'package:constreminder/screens/yourprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:constreminder/model/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (FirebaseAuth.instance.currentUser?.email != null) {
      Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            alignment: Alignment.topCenter,
            duration: Duration(milliseconds: 600),
            isIos: true,
            child: const RegisteredUser()),
      );
    }
    Navigator.push(
      context,
      PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.topCenter,
          duration: Duration(milliseconds: 600),
          isIos: true,
          child: const NotRegisteredPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/back3.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
              ),
            ),
            child: Container()),
      ),
    );
  }
}
