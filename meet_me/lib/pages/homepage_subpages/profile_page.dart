import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? currentuser;
  void getCurrentUser() {
    User? cUser = FirebaseAuth.instance.currentUser;
    if (cUser == null) {
      print("Error fetching current user");
    } else {
      setState(() {
        currentuser = cUser;
      });
    }
  }

  Future<void> fetchUserProfileData(String userId) async {
    print("entered");
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc('user_id')
          .collection('user_profile')
          .get();

      // print(documentSnapshot.data());
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        print(data);
        String? name = data['fullname'];
        if (name != null) {
          print('User Name: $name');
        } else {
          print('Name not found for this user.');
        }
      });
    } catch (e) {
      print('Error fetching user profile data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: const RadialGradient(
            radius: 1,
            colors: [
              Colors.deepPurpleAccent, // Start color
              Color.fromARGB(255, 244, 246, 250),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 350),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [
                    Colors.white54, // Start color
                    Colors.white, // End color
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                currentuser!.email ?? "Username",
                style: GoogleFonts.pacifico(fontSize: 18),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // getCurrentUser();
                getCurrentUser();
                print(currentuser!.email);
                print(currentuser!.uid);
                fetchUserProfileData(currentuser!.uid);
                print("ended");
              },
              child: const Text("Press Me"),
            ),
          ],
        ),
      ),
    );
  }
}
