import 'package:flutter/material.dart';

class RemindByArea extends StatefulWidget {
  const RemindByArea({super.key});

  @override
  State<RemindByArea> createState() => _RemindByAreaState();
}

class _RemindByAreaState extends State<RemindByArea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remind by Area'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/underconst.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Center(
            child: Text(
              'Under Construction',
              style: TextStyle(
                fontSize: 35.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
