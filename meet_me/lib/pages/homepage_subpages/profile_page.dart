import 'dart:math';

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
  Map<String, dynamic>? userProfilemap;
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
    print("enterdd");
    try {
      DocumentSnapshot userDocSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      // Check if the document exists
      if (userDocSnapshot.exists) {
        // Access the document data
        Map<String, dynamic>? userData =
            userDocSnapshot.data() as Map<String, dynamic>?;

        if (userData != null) {
          // Access the 'user_profile' map from the document data
          Map<String, dynamic>? userProfile =
              userData['user_profile'] as Map<String, dynamic>?;
          setState(() {
            userProfilemap = userProfile;
          });

          if (userProfile != null) {
            // Access the 'bio' field from the 'user_profile' map
            String? bio = userProfile['about'] as String?;

            if (bio != null) {
              // Print or use the 'bio' field
              print('Bio: $bio');
              print(userProfile['birthday']);
            } else {
              print('Bio field is null.');
            }
          } else {
            print('User profile map is null.');
          }
        } else {
          print('User data is null.');
        }
      } else {
        print('User document not found.');
      }
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
        decoration: const BoxDecoration(
          gradient: RadialGradient(
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
            const SizedBox(height: 150),
            dataContainer(
              userProfilemap: userProfilemap,
              dataString: "username",
            ),
            dataContainer(
              userProfilemap: userProfilemap,
              dataString: "fullname",
            ),
            dataContainer(
              userProfilemap: userProfilemap,
              dataString: "birthday",
            ),
            dataContainer(
              userProfilemap: userProfilemap,
              dataString: "gender",
            ),
            dataContainer(
              userProfilemap: userProfilemap,
              dataString: "college",
            ),
            aboutContainer(userProfilemap: userProfilemap, dataString: "about"),
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                height: 80,
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
                child: ListView.builder(
                  itemCount: userProfilemap?["interests"].length ?? 0,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.deepPurpleAccent)
                        ),
                        child: Text(userProfilemap?["interests"][index]));
                  },
                )),
            ElevatedButton(
              onPressed: () {
                // getCurrentUser();
                getCurrentUser();
                print(currentuser!.email);
                print(currentuser!.uid);
                fetchUserProfileData("anandita");
                print("ended");
                print(userProfilemap?["about"]);
              },
              child: const Text("Press Me"),
            ),
          ],
        ),
      ),
    );
  }
}

class dataContainer extends StatelessWidget {
  const dataContainer({
    super.key,
    required this.userProfilemap,
    required this.dataString,
  });
  final String dataString;
  final Map<String, dynamic>? userProfilemap;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        userProfilemap?[dataString] ?? "Error Fetching Data...",
        style: GoogleFonts.pacifico(fontSize: 22),
      ),
    );
  }
}

class aboutContainer extends StatelessWidget {
  const aboutContainer({
    super.key,
    required this.userProfilemap,
    required this.dataString,
  });
  final String dataString;
  final Map<String, dynamic>? userProfilemap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 80,
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
        userProfilemap?[dataString] ?? "Error Fetching Data...",
        style: GoogleFonts.pacifico(fontSize: 22),
      ),
    );
  }
}
