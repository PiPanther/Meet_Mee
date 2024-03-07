import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_me/providers/data_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    UserDataProvider.of(context, listen: false).getCurrentUser();
    UserDataProvider.of(context, listen: false)
        .fetchUserProfileData('anandita');
  }

  @override
  Widget build(BuildContext context) {
    final userData = UserDataProvider.of(context);
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
            TextButton(onPressed: () {}, child: Text("hello")),
            dataContainer(
              userProfilemap:
                  userData.userProfileMap!["username"] ?? "Invalid Username",
              dataString: "username",
            ),
            // dataContainer(
            //   userProfilemap: userProfilemap,
            //   dataString: "fullname",
            // ),
            // dataContainer(
            //   userProfilemap: userProfilemap,
            //   dataString: "birthday",
            // ),
            // dataContainer(
            //   userProfilemap: userProfilemap,
            //   dataString: "gender",
            // ),
            // dataContainer(
            //   userProfilemap: userProfilemap,
            //   dataString: "college",
            // ),
            // aboutContainer(userProfilemap: userProfilemap, dataString: "about"),
            // 
            // ElevatedButton(
            //   onPressed: () {
            //     // getCurrentUser();
            //     getCurrentUser();
            //     print(currentuser!.email);
            //     print(currentuser!.uid);
            //     fetchUserProfileData("anandita");
            //     print("ended");
            //     print(userProfilemap?["about"]);
            //   },
            //   child: const Text("Press Me"),
            // ),
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
