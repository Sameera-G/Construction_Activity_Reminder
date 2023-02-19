import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:constreminder/screens/homepage.dart';
import 'package:constreminder/screens/registration.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //form key
  final _formKey = GlobalKey<FormState>();
  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  //firebase call
  final _auth = FirebaseAuth.instance;
  //loading circular proress indicator
  bool loadingprogress = false;
  bool loadingprogress2 = false;
  //main build
  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.black,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        filled: true,
        focusColor: Colors.amber,
        prefixIcon: const Icon(
          Icons.mail,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    //password field
    final passwordField = TextFormField(
      cursorColor: Colors.black,
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Please Enter your Password");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter a Valid Password");
        }
        return null;
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        prefixIcon: const Icon(
          Icons.password,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    //login button
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      //button color
      color: Colors.blue,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signIn(emailController.text, passwordController.text);
        },
        child: const Text(
          'Login',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    double height = MediaQuery.of(context).size.height;
    //main build
    return Scaffold(
      body: Container(
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/back2.jpg'),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: Center(
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
                    SizedBox(
                      height: 100,
                      child: Image.asset('images/logo.png'),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    emailField,
                    const SizedBox(
                      height: 20.0,
                    ),
                    passwordField,
                    TextButton(
                      onPressed: () {
                        //for forgot password
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    loadingprogress
                        ? const CircularProgressIndicator(
                            color: Colors.amber,
                            backgroundColor: Color.fromARGB(255, 243, 240, 240),
                            strokeWidth: 5.0,
                          )
                        : loginButton,
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Don't have an Account? ",
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              loadingprogress2 = true;
                            });
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    alignment: Alignment.topCenter,
                                    duration: Duration(milliseconds: 800),
                                    isIos: true,
                                    child: const RegistrationScreen()));
                            setState(() {
                              loadingprogress2 = false;
                            });
                          },
                          child: loadingprogress2
                              ? const CircularProgressIndicator(
                                  color: Colors.amber,
                                  backgroundColor:
                                      Color.fromARGB(255, 243, 240, 240),
                                  strokeWidth: 5.0,
                                )
                              : const Text(
                                  'Sign up',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                  ),
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Terms & Conditions',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        ),
                      ),
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

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loadingprogress = true;
      });

      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful!"),
                Navigator.of(context).pushReplacement(
                  PageTransition(
                    type: PageTransitionType.fade,
                    alignment: Alignment.topCenter,
                    duration: Duration(milliseconds: 600),
                    isIos: true,
                    child: const MyHomePage(),
                  ),
                ),
              })
          .catchError((e) {
        return {
          Fluttertoast.showToast(msg: e!.message),
        };
      });
    } else {
      Fluttertoast.showToast(msg: 'information fetching error');
    }
  }
}
