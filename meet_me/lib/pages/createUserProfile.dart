import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meet_me/components/gender_button.dart';
import 'package:meet_me/pages/home_page.dart';
import 'package:uuid/uuid.dart';

class CreateUserProfilePage extends StatefulWidget {
  const CreateUserProfilePage({super.key});

  @override
  State<CreateUserProfilePage> createState() => Create_UserProfileStatePage();
}

class Create_UserProfileStatePage extends State<CreateUserProfilePage> {
  String userId = Uuid().v4();
  String? dob = null;
  String username = "";
  String fullname = "";
  String college = "";
  List<String> intrests = [];
  File image = File('');

  TextEditingController _interestController = TextEditingController();
  List<String> _interests = [];
  bool _isSaving = true;

  Future<void> _saveData() async {
    _isSaving
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const HomePage();
          }));
    setState(() {
      _isSaving = true;
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection("user_profile")
        .add({
      'userId': userId,
      'username': username,
      'birthday': dob,
      'gender': _selectedGender,
      'fullname': fullname,
      'college': college,
      'interests': _interests,
      'about': aboutController.text.trim(),
    });

    setState(() {
      _isSaving = false;
    });
  }

  void _addInterest(String interest) {
    setState(() {
      _interests.add(interest);
      _interestController.clear();
      intrests = _interests; // Clear the TextField after adding interest
    });
  }

  void _removeInterest(String intrest) {
    setState(() {
      _interests.remove(intrest);
      intrests = _interests;
    });
  }

  void _showAddInterestDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Interest'),
          content: TextField(
            controller: _interestController,
            decoration: const InputDecoration(
              hintText: 'Enter interest',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _addInterest(_interestController.text);
                _interestController.clear(); // Clear the TextField
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')} '
        '${date.month.toString().padLeft(2, '0')} '
        '${date.year.toString()}';
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController UniveristyController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  @override
  String _selectedGender = "";
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 246, 250),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              image != null
                  ? GestureDetector(
                      onTap: pickImage,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: FileImage(image!),
                      ),
                    )
                  : GestureDetector(
                      onTap: pickImage,
                      child: const CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.grey,
                        child:
                            Icon(Icons.person, size: 80, color: Colors.white),
                      ),
                    ),
              TextField(
                keyboardType: TextInputType.text,
                autocorrect: true,
                controller: usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12)),
                  labelText: 'Username',
                  prefixIcon: Icon(CupertinoIcons.heart_circle),
                ),
              ),
              Center(
                child: Container(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      GenderButton(
                        gender: 'Male',
                        isSelected: _selectedGender == 'Male',
                        onPressed: () {
                          setState(() {
                            _selectedGender = 'Male';
                          });
                        },
                      ),
                      GenderButton(
                        gender: 'Female',
                        isSelected: _selectedGender == 'Female',
                        onPressed: () {
                          setState(() {
                            _selectedGender = 'Female';
                          });
                        },
                      ),
                      GenderButton(
                        gender: 'Other',
                        isSelected: _selectedGender == 'Other',
                        onPressed: () {
                          setState(() {
                            _selectedGender = 'Other';
                          });
                        },
                      ),
                      (dob == null)
                          ? TextButton.icon(
                              onPressed: () async {
                                await _selectDate(context);
                                String date = _formatDate(_selectedDate);
                                setState(() {
                                  dob = date;
                                });
                                print(date);
                              },
                              icon: Icon(CupertinoIcons.calendar_badge_plus),
                              label: Text("Birthday"),
                            )
                          : Text(dob!),
                    ],
                  ),
                ),
              ),
              TextField(
                keyboardType: TextInputType.text,
                autocorrect: true,
                controller: fullnameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12)),
                  labelText: 'Full Name',
                  prefixIcon: Icon(CupertinoIcons.person_alt_circle),
                ),
              ),
              TextField(
                keyboardType: TextInputType.text,
                autocorrect: true,
                controller: UniveristyController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12)),
                  labelText: 'College/University',
                  prefixIcon: Icon(CupertinoIcons.home),
                ),
              ),
              TextField(
                maxLength: 500,
                // expands: true,

                keyboardType: TextInputType.text,
                autocorrect: true,
                controller: aboutController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12)),
                  labelText: 'About',
                  prefixIcon: Icon(CupertinoIcons.pencil_outline),
                ),
              ),
              InkWell(
                onTap: _showAddInterestDialog,
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.transparent,
                      border: Border.all(color: Colors.pink)),
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: double.infinity,
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 0.0,
                    children: _interests.map((interest) {
                      return Chip(
                        side: BorderSide.none,
                        label: Text(interest),
                        deleteIcon: const Icon(
                          Icons.clear,
                          size: 12,
                        ),
                        onDeleted: () => _removeInterest(interest),
                      );
                    }).toList(),
                  ),
                ),
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      username = usernameController.text.trim();
                      college = UniveristyController.text.trim();
                      fullname = fullnameController.text.trim();
                    });
                    if (username != "" && fullname != "") {
                      //
                      print(username);
                      print(college);
                      print(fullname);
                      print(image);
                      print(intrests);

                      _saveData();
                    }
                  },
                  icon: const Icon(Icons.navigate_next_rounded),
                  label: const Text("Save")),
            ],
          ),
        ),
      ),
    );
  }
}
