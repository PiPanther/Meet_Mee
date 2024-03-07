import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class UserData extends ChangeNotifier {
  User? currentUser;
  Map<String, dynamic>? userProfileMap;

  Future<void> getCurrentUser() async {
    try {
      currentUser = FirebaseAuth.instance.currentUser;
      notifyListeners();
    } catch (e) {
      print('Error fetching current user: $e');
    }
  }

  Future<void> fetchUserProfileData(String userId) async {
    try {
      DocumentSnapshot userDocSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDocSnapshot.exists) {
        Map<String, dynamic>? userData =
            userDocSnapshot.data() as Map<String, dynamic>?;

        print(userData);

        if (userData != null) {
          userProfileMap = userData['user_profile'] as Map<String, dynamic>?;

          notifyListeners();
        }
      }
    } catch (e) {
      print('Error fetching user profile data: $e');
    }
  }
}

class UserDataProvider extends StatelessWidget {
  final Widget child;

  const UserDataProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserData(),
      child: child,
    );
  }

  static UserData of(BuildContext context, {bool listen = true}) {
    return Provider.of<UserData>(context, listen: listen);
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UserDataProvider(
      child: MaterialApp(
        title: 'Your App',
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    UserDataProvider.of(context, listen: false).getCurrentUser();
    UserDataProvider.of(context, listen: false).fetchUserProfileData('userId');
  }

  @override
  Widget build(BuildContext context) {
    final userData = UserDataProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            userData.currentUser != null
                ? Text('Current User: ${userData.currentUser!.email}')
                : Text('No current user'),
            userData.userProfileMap != null
                ? Text('User Profile: ${userData.userProfileMap}')
                : Text('User profile not loaded'),
          ],
        ),
      ),
    );
  }
}
