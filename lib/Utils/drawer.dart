import 'package:attedance/Pages/admin.dart';
import 'package:attedance/Pages/course.dart';
import 'package:attedance/Pages/courseteach.dart';
import 'package:attedance/Pages/feedback.dart';
import 'package:attedance/Pages/downloadattend.dart';
import 'package:attedance/Pages/profile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  final bool isteach;
  final bool student;
  final String username;
  MyDrawer(
      {Key? key,
      required this.isteach,
      required this.student,
      required this.username})
      : super(key: key);

  @override
  _MyDrawerState createState() =>
      _MyDrawerState(isteach: isteach, student: student, username: username);
}

class _MyDrawerState extends State<MyDrawer> {
  Color homeColor = Colors.white; // Initial color
  Color profileColor = Colors.transparent; // Initial color
  Color adminColor = Colors.transparent; // Initial color
  Color emailColor = Colors.transparent; // Initial color
  Color docColor = Colors.transparent; // Initial color
  Color logout = Colors.transparent; // Initial color
  final bool isteach;
  final bool student;
  final String username;
  _MyDrawerState(
      {required this.isteach, required this.student, required this.username});

  String name = "";
  String email = "";
  String mob = "";
  String image = "";
  String altimage =
      "https://firebasestorage.googleapis.com/v0/b/attendance-go.appspot.com/o/images%2Fdefault.png?alt=media&token=178d8b2f-38de-416d-9ea5-5b4b027eb046";

  void _changeEmailColor() {
    setState(() {
      emailColor = Colors.white;
      homeColor = Colors.transparent;
      adminColor = Colors.transparent;
      profileColor = Colors.transparent;
      docColor = Colors.transparent;
      logout = Colors.transparent;
    });
  }

  void _changeHomeColor() {
    setState(() {
      emailColor = Colors.transparent;
      homeColor = Colors.white;
      profileColor = Colors.transparent;
      docColor = Colors.transparent;
      adminColor = Colors.transparent;
      logout = Colors.transparent;
    });
  }

  void _changeProfileColor() {
    setState(() {
      emailColor = Colors.transparent;
      homeColor = Colors.transparent;
      profileColor = Colors.white;
      docColor = Colors.transparent;
      adminColor = Colors.transparent;
      logout = Colors.transparent;
    });
  }

  void _changeDocColor() {
    setState(() {
      emailColor = Colors.transparent;
      homeColor = Colors.transparent;
      profileColor = Colors.transparent;
      docColor = Colors.white;
      adminColor = Colors.transparent;
      logout = Colors.transparent;
    });
  }

  void _changeAdminColor() {
    setState(() {
      emailColor = Colors.transparent;
      homeColor = Colors.transparent;
      profileColor = Colors.transparent;
      docColor = Colors.transparent;
      adminColor = Colors.white;
      logout = Colors.transparent;
    });
  }

  void _changeLogOutColor() {
    setState(() {
      emailColor = Colors.transparent;
      homeColor = Colors.transparent;
      profileColor = Colors.transparent;
      docColor = Colors.transparent;
      adminColor = Colors.transparent;
      logout = Colors.white;
    });
  }

  @override
  void initState() {
    super.initState();
    retrieveData();
  }

  void retrieveData() {
    print("Entered");
    if (isteach) {
      DatabaseReference teachRef =
          FirebaseDatabase.instance.ref().child('teacher');
      DataSnapshot teachSnap;

      teachRef.child(username).once().then((DatabaseEvent databaseEvent) async {
        teachSnap = databaseEvent.snapshot;

        // print(coursecode);
        Map<dynamic, dynamic>? teachData = teachSnap.value as Map?;

        if (teachData != null) {
          String fname = teachData['firstName'];
          String lname = teachData['lastName'];
          String emailid = teachData['Email'];
          String mobile = teachData['Mobile'];
          String imageData = teachData['image'] ?? '';

          setState(() {
            name = "$fname $lname";
            email = emailid;
            mob = mobile;
            image = imageData;
          });
        }
      });
    } else {
      DatabaseReference studRef =
          FirebaseDatabase.instance.ref().child('student');
      DataSnapshot studSnap;

      studRef.child(username).once().then((DatabaseEvent databaseEvent) async {
        studSnap = databaseEvent.snapshot;

        // print(coursecode);
        Map<dynamic, dynamic>? studData = studSnap.value as Map?;
        if (studData != null) {
          print(studData);
          String fname = studData['firstName'] ??
              ''; // Use an empty string if 'firstName' is null
          String lname = studData['lastName'] ?? '';
          String emailid = studData['Email'] ?? '';
          String mobile = studData['Mobile'] ?? '';
          String imageData = studData['image'] ?? '';
          setState(() {
            name = "$fname $lname";
            email = emailid;
            mob = mobile;
            image = imageData;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(30),
          topRight: Radius.circular(105),
        ),
      ),
      child: Drawer(
        backgroundColor: Colors.transparent,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(18),
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                currentAccountPicture: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(100)),
                  padding: EdgeInsets.all(4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100)),
                        child: Hero(
                            tag: 'icon',
                            child: Image.network(
                              image.isEmpty ? altimage : image,
                              fit: BoxFit.fill,
                            ))),
                  ),
                ),
                currentAccountPictureSize: const Size(60, 60),
                accountName: Text(
                  "$name",
                  style: const TextStyle(color: Colors.white),
                ),
                accountEmail: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$email",
                      style: const TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "$mob",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                decoration: const BoxDecoration(color: Colors.black),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(10.0), // Adjust the radius as needed
                border: Border.all(
                  color: homeColor, // Border color
                  width: 1.0, // Border width
                ),
              ),
              child: ListTile(
                leading: const Icon(
                  CupertinoIcons.home,
                  color: Colors.white,
                ),
                // tileColor: emailColor,
                title: const Text(
                  "Home",
                  textScaleFactor: 1.2,
                  style: TextStyle(color: Colors.white),
                ),
                hoverColor: Colors.grey,
                onTap: () {
                  _changeHomeColor();
                  isteach
                      ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => TeachCourse(
                            username: username,
                            name: name,
                            approved: true,
                          ),
                        ))
                      : Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => StudCourse(
                            username: username,
                            name: name,
                          ),
                        ));
                },
                // Adjust padding as needed
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(10.0), // Adjust the radius as needed
                border: Border.all(
                  color: profileColor, // Border color
                  width: 1.0, // Border width
                ),
              ),
              child: ListTile(
                leading: const Icon(
                  CupertinoIcons.profile_circled,
                  color: Colors.white,
                ),
                // tileColor: emailColor,
                title: const Text(
                  "Profile",
                  textScaleFactor: 1.2,
                  style: TextStyle(color: Colors.white),
                ),
                hoverColor: Colors.grey,
                onTap: () {
                  _changeProfileColor();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Profile(
                      username: username,
                      isteach: isteach,
                      show_update: false,
                    ),
                  ));
                },
                // Adjust padding as needed
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(10.0), // Adjust the radius as needed
                border: Border.all(
                  color: emailColor, // Border color
                  width: 1.0, // Border width
                ),
              ),
              child: ListTile(
                leading: const Icon(
                  CupertinoIcons.mail,
                  color: Colors.white,
                ),
                // tileColor: emailColor,
                title: const Text(
                  "Feedback",
                  textScaleFactor: 1.2,
                  style: TextStyle(color: Colors.white),
                ),
                hoverColor: Colors.grey,
                onTap: () {
                  _changeEmailColor();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => FeedbackWidget(
                      username: username,
                      student: student,
                      isteach: isteach,
                    ),
                  ));
                },
              ),
            ),
            isteach
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the radius as needed
                      border: Border.all(
                        color: adminColor, // Border color
                        width: 1.0, // Border width
                      ),
                    ),
                    child: ListTile(
                      leading: const Icon(
                        CupertinoIcons.person_2_square_stack,
                        color: Colors.white,
                      ),
                      // tileColor: emailColor,
                      title: const Text(
                        "Admin Pannel",
                        textScaleFactor: 1.2,
                        style: TextStyle(color: Colors.white),
                      ),
                      hoverColor: Colors.grey,
                      onTap: () {
                        _changeAdminColor();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => Admin(username: username),
                        ));
                      },
                    ),
                  )
                : SizedBox(),
            const SizedBox(
              height: 10,
            ),
            isteach
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the radius as needed
                      border: Border.all(
                        color: docColor, // Border color
                        width: 1.0, // Border width
                      ),
                    ),
                    child: ListTile(
                      leading: const Icon(
                        CupertinoIcons.square_list,
                        color: Colors.white,
                      ),
                      // tileColor: emailColor,
                      title: const Text(
                        "Download Attendance",
                        textScaleFactor: 1.2,
                        style: TextStyle(color: Colors.white),
                      ),
                      hoverColor: Colors.grey,
                      onTap: () {
                        _changeDocColor();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => DownloadAttendance(
                            isStud: !isteach,
                            username: username,
                          ),
                        ));
                      },
                    ),
                  )
                : SizedBox(),
            const SizedBox(
              height: 10,
            ),
            const Divider(color: Colors.white),
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(10.0), // Adjust the radius as needed
                border: Border.all(
                  color: logout, // Border color
                  width: 1.0, // Border width
                ),
              ),
              child: ListTile(
                leading: const Icon(
                  CupertinoIcons.arrow_left_square,
                  color: Colors.white,
                ),
                // tileColor: emailColor,
                title: const Text(
                  "Log-Out",
                  textScaleFactor: 1.2,
                  style: TextStyle(color: Colors.white),
                ),
                hoverColor: Colors.grey,
                onTap: () {
                  _changeLogOutColor();
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
