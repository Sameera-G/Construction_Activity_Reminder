import 'package:flutter/material.dart';
import 'package:constreminder/screens/login.dart';
import 'package:page_transition/page_transition.dart';

class GetStart extends StatefulWidget {
  const GetStart({super.key});

  @override
  State<GetStart> createState() => _GetStartState();
}

class _GetStartState extends State<GetStart> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Construction Testing Monitoring')),
      ),
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/back1.jpg'),
            fit: BoxFit.cover,
            opacity: 0.5,
            colorFilter: ColorFilter.mode(Colors.black87, BlendMode.dstATop),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/logo.png',
              width: width * 0.2,
              height: height * 0.2,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Your Pocket Site Activity Reminder Assistant',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
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
                        child: const LoginScreen()));
              },
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              textColor: Colors.white,
              minWidth: 300,
              height: 50,
              child: const Text(
                'Getting Started',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
