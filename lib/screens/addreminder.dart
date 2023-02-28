import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:constreminder/model/remindermodal.dart';
import 'package:constreminder/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:constreminder/model/my_encryption.dart';
//import 'package:constreminder/model/user_model.dart';
//import 'package:constreminder/screens/login.dart';
import 'package:page_transition/page_transition.dart';

class AddReminders extends StatefulWidget {
  const AddReminders({Key? key}) : super(key: key);

  @override
  State<AddReminders> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<AddReminders> {
  //form validation checking auth - then post the values to firestore
  final _auth = FirebaseAuth.instance;
  //form key defninig
  final _formKey = GlobalKey<FormState>();
  //controllers for the text fields
  final remNameEdCntrl = TextEditingController();
  final remTypEditCntrl = TextEditingController();
  final tecNameEditCntrl = TextEditingController();
  final testEditCntrl = TextEditingController();
  final testDateCntrl = TextEditingController();
  final testTimeEditCntrl = TextEditingController();
  final testLocEditCntrl = TextEditingController();
  var tName, tId, tLocation, tDate, tTime, tType, tTechnician, eMailEnc;

  //loding indicator
  bool loadingprogress = false;

  @override
  Widget build(BuildContext context) {
    //************************************************************************** */
    //reminder name
    final reminderName = TextFormField(
      autofocus: false,
      controller: remNameEdCntrl,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Reminder Name Cannot be empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter a Valid Name (Min 3 Characters");
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.white),
        ),
        filled: true,
        fillColor: Colors.transparent,
        prefixIcon: const Icon(
          Icons.remember_me,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Reminder Name',
        prefixIconColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    //************************************************************************** */
    //reminder typee
    final reminderType = TextFormField(
      autofocus: false,
      controller: remTypEditCntrl,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Reminder Type Cannot be empty");
        }
        return null;
      },
      onSaved: (value) {
        value = remTypEditCntrl.text;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.white),
        ),
        filled: true,
        fillColor: Colors.transparent,
        prefixIcon: const Icon(
          Icons.type_specimen,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Reminder type - New test or Re-test',
        prefixIconColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    //************************************************************************** */
    // technician name
    final technicianName = TextFormField(
      autofocus: false,
      controller: tecNameEditCntrl,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Technician Name");
        }
        // reg expression for email validation
        if (RegExp("").hasMatch(value)) {
          return ("Please Enter a valid name");
        }
        return null;
      },
      onSaved: (value) {
        value = tecNameEditCntrl.text;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.white),
        ),
        filled: true,
        fillColor: Colors.transparent,
        prefixIcon: const Icon(
          Icons.people,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Technician Name',
        prefixIconColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    //************************************************************************* */
    //test identification
    final testId = TextFormField(
      autofocus: false,
      controller: testEditCntrl,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Test ID can not be empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter a Valid ID");
        }
        return null;
      },
      onSaved: (value) {
        value = testEditCntrl.text;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.white),
        ),
        filled: true,
        fillColor: Colors.transparent,
        prefixIcon: const Icon(
          Icons.numbers,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Test Identification',
        prefixIconColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    //************************************************************************* */
    //test location
    final testLocation = TextFormField(
      autofocus: false,
      controller: testLocEditCntrl,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Add a location");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter a valid Location");
        }
        return null;
      },
      onSaved: (value) {
        value = testLocEditCntrl.text;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.white),
        ),
        filled: true,
        fillColor: Colors.transparent,
        prefixIcon: const Icon(
          Icons.location_city,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Test Location',
        prefixIconColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    //Test Date Field
    final testDate = TextFormField(
      autofocus: false,
      controller: testDateCntrl,
      validator: (value) {
        RegExp regex = RegExp('r^[0-9]');
        if (value!.isEmpty) {
          return 'Please enter Date';
        } else {
          if (regex.hasMatch(value)) {
            return 'Enter a valid Date';
          } else {
            return null;
          }
        }
      },
      onSaved: (value) {
        testDateCntrl.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.white),
        ),
        errorStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          backgroundColor: Colors.black,
          fontSize: 13,
        ),
        errorMaxLines: 2,
        filled: true,
        fillColor: Colors.transparent,
        prefixIcon: const Icon(
          Icons.date_range,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Date to be tested',
        prefixIconColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    //****************************************************************************** */
    //Time of the test
    final testTime = TextFormField(
      autofocus: false,
      controller: testTimeEditCntrl,
      obscureText: true,
      validator: (value) {
        if (testTimeEditCntrl.text.isEmpty) {
          return "Time Cannot be empty";
        }
        return null;
      },
      onSaved: (value) {
        testTimeEditCntrl.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.white),
        ),
        filled: true,
        fillColor: Colors.transparent,
        prefixIcon: const Icon(
          Icons.timelapse,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Time to be Reminded',
        prefixIconColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    //**************************************************************************** */
    //sign up button
    final addReminderBtn = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      //button color
      color: Colors.blue,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          setState(() {
            tName = remNameEdCntrl.value.text;
            tType = remTypEditCntrl.value.text;
            tTechnician = tecNameEditCntrl.value.text;
            tId = testEditCntrl.value.text;
            tLocation = testLocEditCntrl.value.text;
            tDate = testDateCntrl.value.text;
            tTime = testTimeEditCntrl.value.text;
          });
          addReminder();
          Navigator.of(context).pushReplacement(
            PageTransition(
              type: PageTransitionType.fade,
              alignment: Alignment.topCenter,
              duration: Duration(milliseconds: 600),
              isIos: true,
              child: const MyHomePage(),
            ),
          );
        },
        child: const Text(
          'Add Reminder',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    //****************************************************************************** */
    //design
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Form'),
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/back2.jpg"),
              fit: BoxFit.cover,
              opacity: 0.2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    reminderName,
                    const SizedBox(
                      height: 20.0,
                    ),
                    reminderType,
                    const SizedBox(
                      height: 20.0,
                    ),
                    technicianName,
                    const SizedBox(
                      height: 20.0,
                    ),
                    testId,
                    const SizedBox(
                      height: 20.0,
                    ),
                    testLocation,
                    const SizedBox(
                      height: 20.0,
                    ),
                    testDate,
                    const SizedBox(
                      height: 20.0,
                    ),
                    testTime,
                    const SizedBox(
                      height: 20.0,
                    ),
                    loadingprogress
                        ? const CircularProgressIndicator(
                            color: Colors.amber,
                            backgroundColor: Color.fromARGB(255, 243, 240, 240),
                            strokeWidth: 5.0,
                          )
                        : addReminderBtn,
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Want to Cancel the Reminder?',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            remNameEdCntrl.text = '';
                            remTypEditCntrl.text = '';
                            testEditCntrl.text = '';
                            testLocEditCntrl.text = '';
                            tecNameEditCntrl.text = '';
                            testTimeEditCntrl.text = '';
                            testDateCntrl.text = '';
                          },
                          child: const Text('Cancel Form'),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Want to know more? ",
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AddReminders()));
                          },
                          child: const Text(
                            'Instructions',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  FirebaseFirestore reminders = FirebaseFirestore.instance;

  Future<void> addReminder() {
    loadingprogress = true;
    User? user = _auth.currentUser;
    ReminderModel? reminderModel = ReminderModel();

    reminderModel.reminderName = tName;
    reminderModel.reminderType = tType;
    reminderModel.Location = tLocation;
    reminderModel.TechnicanN = tTechnician;
    reminderModel.TestIdentification = tId;
    reminderModel.DateofTest = tDate;
    reminderModel.TimeofTest = tTime;

    //encryption of data
    /*
    String tNametoStore = MyEncryptionDecryption.encryptionAES(tName).base64;
    String tTypetoStore = MyEncryptionDecryption.encryptionAES(tType).base64;
    String tTechniciantoStore =
        MyEncryptionDecryption.encryptionAES(tTechnician).base64;
    String tIDtoStore = MyEncryptionDecryption.encryptionAES(tId).base64;
    String tLocationtoStore = MyEncryptionDecryption.encryptionAES(tLocation).base64;
    String tDatetoStore = MyEncryptionDecryption.encryptionAES(tDate).base64;
    String tTimetoStore = MyEncryptionDecryption.encryptionAES(tTime).base64;
    */
    loadingprogress = false;
    // Call the user's CollectionReference to add a new user
    return reminders
        .collection('users')
        .doc(user!.uid)
        .collection('reminders')
        .doc(reminderModel.TestIdentification)
        .set(reminderModel.toMap())
        .then((value) => Fluttertoast.showToast(msg: "Reminder added"))
        .catchError((error) {
      return Fluttertoast.showToast(msg: error);
    });
  }
}
