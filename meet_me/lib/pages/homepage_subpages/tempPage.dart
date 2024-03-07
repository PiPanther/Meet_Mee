import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_me/components/text_container.dart';
import 'package:meet_me/pages/homepage_subpages/profile_page.dart';
import 'package:meet_me/providers/data_provider.dart';
import 'package:provider/provider.dart';

class TempPage extends StatefulWidget {
  const TempPage({super.key});

  @override
  State<TempPage> createState() => _TempPageState();
}

class _TempPageState extends State<TempPage> {
  @override
  void initState() {
    super.initState();
    UserDataProvider.of(context, listen: false).getCurrentUser();

    UserDataProvider.of(context, listen: false)
        .fetchUserProfileData("anandita");
  }

  @override
  Widget build(BuildContext context) {
    final userdata = Provider.of<UserData>(context);
    final String username = userdata.userProfileMap!["username"];

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
      body: SingleChildScrollView(
        child: Consumer<UserData>(
          builder: (context, value, child) => Container(
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
              children: [
                const SizedBox(
                  height: 100,
                ),
                TextContainer(
                    iconData: CupertinoIcons.heart_fill,
                    userProfilemap: userdata.userProfileMap!,
                    dataString: "username"),
                TextContainer(
                    iconData: CupertinoIcons.person_2_fill,
                    userProfilemap: userdata.userProfileMap!,
                    dataString: "fullname"),
                TextContainer(
                    iconData: CupertinoIcons.calendar_circle_fill,
                    userProfilemap: userdata.userProfileMap!,
                    dataString: "birthday"),
                TextContainer(
                    iconData: CupertinoIcons.home,
                    userProfilemap: userdata.userProfileMap!,
                    dataString: "college"),
                TextContainer(
                    iconData: CupertinoIcons.add,
                    userProfilemap: userdata.userProfileMap!,
                    dataString: "gender"),
                aboutContainer(
                  userProfilemap: userdata.userProfileMap!,
                  dataString: "about",
                ),
                Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
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
                      itemCount:
                          userdata.userProfileMap!["interests"].length ?? 0,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                            decoration: BoxDecoration(),
                            child: Text(
                              userdata.userProfileMap!["interests"][index] +
                                  "  ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ));
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
