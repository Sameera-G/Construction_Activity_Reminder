import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:constreminder/model/my_encryption.dart';
import 'package:constreminder/model/remindermodal.dart';
import 'package:constreminder/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RemindersList extends StatefulWidget {
  const RemindersList({super.key});

  @override
  State<RemindersList> createState() => _RemindersListState();
}

class _RemindersListState extends State<RemindersList> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  ReminderModel reminders = ReminderModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity List'),
      ),
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/smart13.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.orange, shape: BoxShape.circle),
                    child: CircleAvatar(
                      radius: 50, // Image radius
                      backgroundImage: AssetImage("images/logo1.png"),
                    ),
                  ),
                  Expanded(
                    child: Card(
                        margin: EdgeInsets.all(10.0),
                        color: Colors.black38,
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                              'The list of Testing Activities are listed in the below'),
                        )),
                  )
                ],
              ),
            ),
            Container(
              width: width,
              height: height * 0.7,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(user!.uid)
                    .collection('reminders')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return Card(
                        color: Colors.black38,
                        elevation: 8,
                        //shadowColor: Colors.black,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(1.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ListTile(
                                  leading: Icon(
                                    Icons.verified_user,
                                    color: Colors.white,
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        data.clear();
                                      },
                                      icon: Icon(Icons.delete)),
                                  title: Text(
                                    '${data['TestIdentification'].toString()} (${data['reminderName'].toString()}) - ${data['reminderType'].toString()}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${data['Location'].toString()} (${data['DateofTest'].toString()}) - ${data['TimeofTest'].toString()}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  onTap: () {
                                    /*Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => UserData(
                                                    userInfo:
                                                        data['uid'].toString())));
                                        print(data);*/
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
