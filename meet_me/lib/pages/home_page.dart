import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:meet_me/pages/homepage_subpages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: "Meet",
                    style: GoogleFonts.pacifico(
                        fontSize: 24,
                        fontWeight: FontWeight.w200,
                        color: Colors.black)),
                TextSpan(
                    text: "❤️",
                    style: GoogleFonts.pacifico(
                        fontSize: 24,
                        fontWeight: FontWeight.w200,
                        color: Colors.red)),
                TextSpan(
                    text: "me",
                    style: GoogleFonts.pacifico(
                        fontSize: 24,
                        fontWeight: FontWeight.w200,
                        color: Colors.black)),
              ],
            ),
          ),
          centerTitle: true,
        ),
        body: const ProfilePage());
  }
}
