//import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:constreminder/model/my_encryption.dart';
import 'package:constreminder/model/remindermodal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:constreminder/model/user_model.dart';

class YourProfile extends StatefulWidget {
  const YourProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<YourProfile> createState() => _YourProfileState();
}

class _YourProfileState extends State<YourProfile> {
  //get data from the database
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  ReminderModel reminders = ReminderModel();
  var fName, sName, hAddress, mNumber;

  String? downloadUrl;

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
        sName = MyEncryptionDecryption.decryptionAES(loggedInUser.secondName);
        hAddress =
            MyEncryptionDecryption.decryptionAES(loggedInUser.homeAddress);
        mNumber =
            MyEncryptionDecryption.decryptionAES(loggedInUser.mobileNumber);
      });
    });
  }

  //get data from firebase

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Profile',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/profileback.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withOpacity(0.6)),
                  width: width,
                  height: height * 0.4,
                  child: buildQuoteCard5(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withOpacity(0.6)),
                  width: width * 0.6,
                  child: buildQuoteCard(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withOpacity(0.6)),
                  width: width,
                  child: buildQuoteCard2(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withOpacity(0.6)),
                  width: width * 0.6,
                  child: buildQuoteCard4(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: width,
                  child: buildQuoteCard3(),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.edit_document),
                      label: Text('Edit Info'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildQuoteCard() => Card(
        color: Colors.transparent,
        elevation: 8,
        shadowColor: Colors.black,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Name: ',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${fName} ${sName}',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ]),
          ),
        ),
      );

  Widget buildQuoteCard2() => Card(
        color: Colors.transparent,
        elevation: 8,
        shadowColor: Colors.black,
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              'Email Address',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            const SizedBox(height: 5),
            Text(
              '${loggedInUser.email}',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          ]),
        ),
      );

  Widget buildQuoteCard3() => Card(
        color: Colors.transparent,
        elevation: 8,
        shadowColor: Colors.black,
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              'Address',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            const SizedBox(height: 5),
            Text(
              '${hAddress}',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          ]),
        ),
      );

  Widget buildQuoteCard4() => Card(
        color: Colors.transparent,
        elevation: 8,
        shadowColor: Colors.black,
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              'Mobile Number',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            const SizedBox(height: 5),
            Text(
              '${mNumber}',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          ]),
        ),
      );

  Widget buildQuoteCard5() => Card(
        color: Colors.transparent,
        elevation: 8,
        shadowColor: Colors.black,
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Container(
            margin: EdgeInsets.all(5.0),
            decoration:
                BoxDecoration(color: Colors.white30, shape: BoxShape.circle),
            child: Card(
              shape: CircleBorder(),
              margin: EdgeInsets.all(2.0),
              color: Colors.black,
              elevation: 10,
              shadowColor: Colors.black,
              child: CircleAvatar(
                radius: 100, // Image radius
                backgroundImage: AssetImage("images/profile.jpg"),
              ),
            ),
          ),
        ),
      );
}
