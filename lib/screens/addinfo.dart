import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:constreminder/model/my_encryption.dart';
import 'package:constreminder/model/user_model.dart';
import 'package:constreminder/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:constreminder/model/my_encryption.dart';
//import 'package:constreminder/model/user_model.dart';
//import 'package:constreminder/screens/login.dart';
import 'package:page_transition/page_transition.dart';

class AddInfo extends StatefulWidget {
  const AddInfo({Key? key}) : super(key: key);

  @override
  State<AddInfo> createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  //form validation checking auth - then post the values to firestore
  final _auth = FirebaseAuth.instance;
  //form key defninig
  final _formKey = GlobalKey<FormState>();
  //controllers for the text fields
  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final homeAddressEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPassEditingController = TextEditingController();
  final mobileEditingController = TextEditingController();
  var fName, sName, hAddress, mNumber, email;

  UserModel loggedInUser = UserModel();
  User? user = FirebaseAuth.instance.currentUser;

  //loding indicator
  bool loadingprogress = false;

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
    });
  }

  @override
  Widget build(BuildContext context) {
    //************************************************************************** */
    //first name text field design
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("First Name Cannot be empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter a Valid Name (Min 3 Characters");
        }
        setState(() {
          fName = MyEncryptionDecryption.encryptionAES(value).base64;
        });
        return null;
      },
      onSaved: (value) {
        value = firstNameEditingController.text;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.white),
        ),
        filled: true,
        fillColor: Colors.transparent,
        prefixIcon: const Icon(
          Icons.account_circle,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'First Name',
        prefixIconColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    //************************************************************************** */
    //second name field design
    final secondNameField = TextFormField(
      autofocus: false,
      controller: secondNameEditingController,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Second Name Cannot be empty");
        }
        setState(() {
          sName = MyEncryptionDecryption.encryptionAES(value).base64;
        });
        return null;
      },
      onSaved: (value) {
        value = secondNameEditingController.text;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.white),
        ),
        filled: true,
        fillColor: Colors.transparent,
        prefixIcon: const Icon(
          Icons.account_circle_outlined,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Second Name',
        prefixIconColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    //************************************************************************** */
    // email controller design
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        setState(() {
          email = MyEncryptionDecryption.encryptionAES(value).base64;
        });
        return null;
      },
      onSaved: (value) {
        value = emailEditingController.text;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.white),
        ),
        filled: true,
        fillColor: Colors.transparent,
        prefixIcon: const Icon(
          Icons.email,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Email',
        prefixIconColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    //************************************************************************* */
    //home address
    final homeAddressField = TextFormField(
      autofocus: false,
      controller: homeAddressEditingController,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Address Cannot be empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter a Valid Address");
        }
        setState(() {
          hAddress = MyEncryptionDecryption.encryptionAES(value).base64;
        });
        return null;
      },
      onSaved: (value) {
        value = homeAddressEditingController.text;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.white),
        ),
        filled: true,
        fillColor: Colors.transparent,
        prefixIcon: const Icon(
          Icons.account_circle,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Home Address',
        prefixIconColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    //************************************************************************* */
    //mobile number
    final mobileNumberField = TextFormField(
      autofocus: false,
      controller: mobileEditingController,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Mobile Number Cannot be empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter a Valid Mobile Number");
        }
        setState(() {
          mNumber = MyEncryptionDecryption.encryptionAES(value).base64;
        });
        return null;
      },
      onSaved: (value) {
        value = mobileEditingController.text;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.white),
        ),
        filled: true,
        fillColor: Colors.transparent,
        prefixIcon: const Icon(
          Icons.account_circle,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Number with +358 xx xxx xxxx',
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
            fName = firstNameEditingController.value.text;
            sName = secondNameEditingController.value.text;
            email = emailEditingController.value.text;
            hAddress = homeAddressEditingController.value.text;
            mNumber = mobileEditingController.value.text;
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
              opacity: 1,
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
                    //top logo of the construction

                    firstNameField,
                    const SizedBox(
                      height: 20.0,
                    ),
                    secondNameField,
                    const SizedBox(
                      height: 20.0,
                    ),
                    emailField,
                    const SizedBox(
                      height: 20.0,
                    ),
                    homeAddressField,
                    const SizedBox(
                      height: 20.0,
                    ),
                    mobileNumberField,
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
                            firstNameEditingController.text = '';
                            secondNameEditingController.text = '';
                            homeAddressEditingController.text = '';
                            emailEditingController.text = '';
                            mobileEditingController.text = '';
                            passwordEditingController.text = '';
                            confirmPassEditingController.text = '';
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
                                    builder: (context) => const AddInfo()));
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

  FirebaseFirestore userinfo = FirebaseFirestore.instance;

  Future<void> addReminder() {
    loadingprogress = true;
    User? user = _auth.currentUser;
    UserModel? userModel = UserModel();

    //encryption of data

    userModel.email = email;
    userModel.uid = user?.uid;
    userModel.firstName =
        MyEncryptionDecryption.encryptionAES(fName).base64.toString();
    userModel.secondName =
        MyEncryptionDecryption.encryptionAES(sName).base64.toString();
    userModel.homeAddress =
        MyEncryptionDecryption.encryptionAES(hAddress).base64.toString();
    userModel.mobileNumber =
        MyEncryptionDecryption.encryptionAES(mNumber).base64.toString();

    loadingprogress = false;
    // Call the user's CollectionReference to add a new user
    return userinfo
        .collection('users')
        .doc(user!.uid)
        .set(userModel.toMap())
        .then((value) => Fluttertoast.showToast(msg: "Info added"))
        .catchError((error) {
      return Fluttertoast.showToast(msg: error);
    });
  }
}
