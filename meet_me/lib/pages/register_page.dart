import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:meet_me/Authentiation/services.dart';
import 'package:meet_me/pages/createUserProfile.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService authService = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordcController = TextEditingController();
  TextEditingController confirmpasswordcController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 246, 250),
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
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              children: [
                LottieBuilder.asset(
                  'lib/assets/login.json',
                ),
                // Text(
                //   'Join our community of dreamers, believers, and hopeless romantics today. Sign in now and let destiny take the lead!',
                //   style: GoogleFonts.craftyGirls(
                //     fontWeight: FontWeight.bold,
                //     // fontWeight : FontWeight.bold
                //     fontSize: 18,
                //     color: Colors.black,
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: true,
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email_outlined)),
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    autocorrect: true,
                    controller: passwordcController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.password_outlined)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    autocorrect: true,
                    controller: confirmpasswordcController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.password_outlined)),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                  decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextButton.icon(
                    onPressed: () {
                      // Call signInWithEmailPassword function when the button is tapped
                      authService
                          .registerWithEmailPassword(
                              emailController.text, passwordcController.text)
                          .then((userCredential) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const CreateUserProfilePage();
                        })).catchError((e) {
                          print("error" + e);
                        });
                      });
                    },
                    icon: const Icon(
                      CupertinoIcons.heart_circle,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: RichText(
                      text: TextSpan(children: [
                    const TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text: "Login",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('You tapped on the text!');
                            Navigator.pop(context);
                          },
                        style: const TextStyle(
                          color: Colors.red,
                        )),
                  ])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
