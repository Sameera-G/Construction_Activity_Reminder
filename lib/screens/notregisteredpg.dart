import 'package:constreminder/screens/login.dart';
import 'package:constreminder/screens/registration.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class NotRegisteredPage extends StatefulWidget {
  const NotRegisteredPage({super.key});

  @override
  State<NotRegisteredPage> createState() => _NotRegisteredPageState();
}

class _NotRegisteredPageState extends State<NotRegisteredPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Not a Registered User"),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "You Are Not a Registered User, Please Register",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Image.asset(
              'images/logo1.png',
              width: width * 0.2,
              height: height * 0.2,
            ),
            SizedBox(
              height: 30.0,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegistrationScreen()));
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
                'Registration Screen',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
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
                'Login',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
