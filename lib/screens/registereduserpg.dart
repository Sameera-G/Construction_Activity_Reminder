import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:constreminder/model/my_encryption.dart';
import 'package:constreminder/model/user_model.dart';
import 'package:constreminder/screens/addreminder.dart';
import 'package:constreminder/screens/login.dart';
import 'package:constreminder/screens/remindbyarea.dart';
import 'package:constreminder/screens/reminderlist.dart';
import 'package:constreminder/screens/yourprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

class RegisteredUser extends StatefulWidget {
  const RegisteredUser({super.key});

  @override
  State<RegisteredUser> createState() => _RegisteredUserState();
}

class _RegisteredUserState extends State<RegisteredUser> {
  String fName = '';
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    //implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {
        fName = MyEncryptionDecryption.decryptionAES(loggedInUser.firstName);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Back ${fName}!'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.white30, shape: BoxShape.circle),
                child: Card(
                  shape: CircleBorder(),
                  margin: EdgeInsets.all(2.0),
                  color: Colors.black,
                  elevation: 10,
                  shadowColor: Colors.black,
                  child: CircleAvatar(
                    radius: 25, // Image radius
                    backgroundImage: AssetImage("images/profile.jpg"),
                    child: MaterialButton(
                      onPressed: () => Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            alignment: Alignment.topCenter,
                            duration: Duration(milliseconds: 600),
                            isIos: true,
                            child: const YourProfile()),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: const Text(
                      'Construction Testing Locations and Date Reminder',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Image.asset(
                    'images/logo1.png',
                    width: width * 0.2,
                    height: height * 0.2,
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              alignment: Alignment.topCenter,
                              duration: Duration(milliseconds: 600),
                              isIos: true,
                              child: const AddReminders()));
                    },
                    color: Colors.transparent,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                    minWidth: width * 0.7,
                    height: height * 0.09,
                    child: const Text(
                      'Add Activity Reminder',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              alignment: Alignment.topCenter,
                              duration: Duration(milliseconds: 600),
                              isIos: true,
                              child: const RemindersList()));
                    },
                    color: Colors.transparent,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                    minWidth: width * 0.7,
                    height: height * 0.09,
                    child: const Text(
                      'Reminders List',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              alignment: Alignment.topCenter,
                              duration: Duration(milliseconds: 600),
                              isIos: true,
                              child: const RemindByArea()));
                    },
                    color: Colors.transparent,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                    minWidth: width * 0.7,
                    height: height * 0.09,
                    child: const Text(
                      'Remind by Area',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Colors.white30, shape: BoxShape.circle),
                        child: Card(
                          shape: CircleBorder(),
                          margin: EdgeInsets.all(2.0),
                          color: Colors.white,
                          elevation: 10,
                          shadowColor: Colors.white,
                          child: CircleAvatar(
                            radius: 25, // Image radius
                            backgroundImage: AssetImage("images/exit3.png"),
                            child: MaterialButton(
                              onPressed: () {
                                SignOut();
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        alignment: Alignment.topCenter,
                                        duration: Duration(milliseconds: 600),
                                        isIos: true,
                                        child: const LoginScreen()));
                                Fluttertoast.showToast(
                                    msg: 'Sign out Successfully!');
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> SignOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
