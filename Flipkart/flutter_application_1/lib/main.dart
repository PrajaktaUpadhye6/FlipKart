import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/user_auth/firebase_auth_services.dart';
//import 'dart:ui' as ui;

// void main() {
//   runApp(const MyApp());
// }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoginScreen());
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  // TextEditingController _mobilenoContoller = TextEditingController();
  // TextEditingController _usernameContoller = TextEditingController();
  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _passwordContoller = TextEditingController();
  bool _passwordVisible = false;

  @override
  void dispose() {
    // TODO: implement dispose
    // _mobilenoContoller.dispose();
    // _usernameContoller.dispose();
    _emailContoller.dispose();
    _passwordContoller.dispose();
    super.dispose();
  }

  void _navigateToHomeScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }

  void _navigateToRegisterScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RegisterScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListView(
        children: [
          Stack(
            children: [
              Container(
                color: Colors.blueAccent,
                height: 40.0,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 40.0),
              ),
              Positioned(
                left: 150.0,
                top: 40.0 + (30.0 - 16.0) / 2,
                child: Text(
                  "FlipKart",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Positioned(
                top: 43.0,
                left: 215.0,
                child: Image.asset(
                  'assets/flipkartlogo.jpg',
                  height: 30.0,
                  width: 30.0,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 25.0),
            child: Text(
              "Log in for the best experience",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 50.0, right: 20.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                controller: _emailContoller,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15.0),
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
          //   child: Container(
          //     decoration: BoxDecoration(
          //       border: Border.all(color: Colors.blueAccent),
          //       borderRadius: BorderRadius.circular(8.0),
          //     ),
          //     child: TextField(
          //       controller:  _passwordContoller,
          //       decoration: InputDecoration(
          //         hintText: 'Password',
          //         hintStyle: TextStyle(color: Colors.grey),
          //         border: InputBorder.none,
          //         contentPadding: EdgeInsets.all(15.0),
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                controller: _passwordContoller,
                obscureText: !_passwordVisible, // Obfuscate the password
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15.0),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
            child: RichText(
              text: TextSpan(
                text: 'By continuing, you agree to FlipKart`s ',
                style: TextStyle(color: Colors.grey),
                children: [
                  TextSpan(
                    text: 'Terms of Use and Privacy Policy',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
              onPressed: () => _navigateToRegisterScreen(),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              child: Text(
                'Register',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ElevatedButton(
              onPressed: _signIn,
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              child: Text(
                'Continue',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _signIn() async {
    // String username = _usernameContoller.text;
    // String mobileno = _mobilenoContoller.text;
    String email = _emailContoller.text;
    String password = _passwordContoller.text;

    User? user = await _auth.signInWithEmailandPassword(email, password);

    if (user != null) {
      print("User succesfully Signed in");
      _showDialog("Success", "User successfully signed in!");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } else {
      print("Error in registeration");
      _showDialog("Error", "Invalid email or password. Please try again.");
    }
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  TextEditingController _mobilenoContoller = TextEditingController();
  TextEditingController _usernameContoller = TextEditingController();
  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _passwordContoller = TextEditingController();
  bool _passwordVisible = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _mobilenoContoller.dispose();
    _usernameContoller.dispose();
    _emailContoller.dispose();
    _passwordContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          // Wrap with SingleChildScrollView
          physics: BouncingScrollPhysics(), // Enable scrolling
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          color: Colors.blueAccent,
                          height: 40.0,
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 10.0),
                        ),
                        Positioned(
                          left: 150.0,
                          top: 10.0 + (30.0 - 16.0) / 2,
                          child: Text(
                            "FlipKart",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8.0, // Add some space between text and image
                        ),
                        Positioned(
                          top: 13.0,
                          left: 215.0,
                          child: Image.asset(
                            'assets/flipkartlogo.jpg',
                            height: 30.0,
                            width: 30.0,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 15.0),
                      child: Text(
                        "Register for the best experience",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 1.0),
                      child: Text(
                        "Enter your phone number to continue",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 30.0, right: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextField(
                          controller: _mobilenoContoller,
                          decoration: InputDecoration(
                            hintText: 'Mobile Number',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(15.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 260.0, top: 5),
                      child: Text(
                        "Use Email-ID",
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 30.0, right: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextField(
                          controller: _usernameContoller,
                          decoration: InputDecoration(
                            hintText: 'UserName',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(15.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 10.0, right: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextField(
                          controller: _emailContoller,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(15.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 10.0, right: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextField(
                          controller: _passwordContoller,
                          obscureText:
                              !_passwordVisible, // Obfuscate the password
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(15.0),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 20.0, right: 20.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'By continuing, you agree to FlipKart`s ',
                          style: TextStyle(color: Colors.grey),
                          children: [
                            TextSpan(
                              text: 'Terms of Use and Privacy Policy',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, left: 140.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _register();
                          String mobileNumber = _mobilenoContoller.text;
                          String userName = _usernameContoller.text;
                          String email = _emailContoller.text;
                          String password = _passwordContoller.text;

                          // Print the values for testing (you can replace this with your logic)
                          print('Mobile Number: $mobileNumber');
                          print('User Name: $userName');
                          print('Email: $email');
                          print('Password: $password');

                          //  Navigator.of(context).pushReplacement(
                          //   MaterialPageRoute(
                          //     builder: (context) => HomeScreen(),
                          //   ),
                          // );
                          // Add the action for the blue button here
                          // For example, you can navigate to another screen
                          print('Blue button pressed!');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.only(top: 0.0, left: 100.0),
                    //   child: TextButton(
                    //     onPressed: () {
                    //       // Add the action for the text button here
                    //       // For example, you can navigate to the login screen
                    //       print('Text button pressed!');
                    //     },
                    //     child: Text(
                    //       'Already have an account? Login',
                    //       style: TextStyle(
                    //         color: Colors.blue,
                    //         fontSize: 16.0,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _register() async {
  String username = _usernameContoller.text;
  String mobileno = _mobilenoContoller.text;
  String email = _emailContoller.text;
  String password = _passwordContoller.text;

  try {
    User? user = await _auth.registerWithEmailandPassword(email, password);

    if (user != null) {
      print("User successfully registered");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
      addUserDetails(
        _usernameContoller.text.trim(),
        _mobilenoContoller.text.trim(),
        _emailContoller.text.trim(),
        _passwordContoller.text.trim(),
      );
    } else {
      print("Error in registration");
    }
  } catch (e) {
    print("Error during registration: $e");
    // Display a pop-up indicating that the user already exists
    _showErrorDialog("User Already Exists",
        "The provided email is already registered. Please use a different email or login.");
  }
}

void _showErrorDialog(String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}


  Future addUserDetails(
      String username, String email, String mobileno, String password) async {
    await FirebaseFirestore.instance.collection('accountinfo').add({
      'username': username,
      'email': email,
      'mobileno': mobileno,
      'password': password,
      'address': '',
    });
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(

      //     ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  color: Colors.white,
                  height: 40.0,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 15.0),
                ),
                Positioned(
                  left: 80.0,
                  top: 10.0 + (30.0 - 16.0) / 2,
                  child: Text(
                    "FlipKart",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 2.0),
                Positioned(
                  top: 0.0,
                  left: 30.0,
                  child: Image.asset(
                    'assets/flipkartlogo.jpg',
                    height: 70.0,
                    width: 40.0,
                  ),
                ),
                Positioned(
                  top: 10.0 + (30.0 - 16.0) / 2,
                  right: 20.0,
                  child: GestureDetector(
                    onTap: () {
                      _showLogoutDialog(context);
                      // FirebaseAuth.instance.signOut();
                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(
                      //     builder: (context) => RegisterScreen(),
                      //   ),
                      // );
                      // Handle logout logic here
                      // For example, call a function to log the user out
                      // _logout(context);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 15.0, 16.0, 15.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.mic),
                ),
              ),
            ),
            Scrollbar(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Add more widgets/components as needed
                  ],
                ),
              ),
            ),
            SizedBox(height: 0.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'assets/main.jpeg',
                  height: 130.0,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.arrow_back_ios_new_rounded, size: 15.0),
                    SizedBox(height: 0.0),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _navigateToItemDescription(context, 'assets/chair.png');
                      },
                      child: Column(
                        children: [
                          SizedBox(height: 0.0),
                          Image.asset(
                            'assets/chair.png',
                            height: 80.0,
                            width: 50.0,
                          ),
                          SizedBox(height: 0.0),
                          Text('Furniture'),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _navigateToItemDescription(
                            context, 'assets/beauty.png');
                      },
                      child: Column(
                        children: [
                          SizedBox(height: 0.0),
                          Image.asset(
                            'assets/beauty.png',
                            height: 80.0,
                            width: 50.0,
                          ),
                          SizedBox(height: 0.0),
                          Text('Beauty'),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _navigateToItemDescription(
                            context, 'assets/mobile.png');
                      },
                      child: Column(
                        children: [
                          SizedBox(height: 0.0),
                          Image.asset(
                            'assets/mobile.png',
                            height: 80.0,
                            width: 50.0,
                          ),
                          SizedBox(height: 0.0),
                          Text('Mobiles'),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _navigateToItemDescription(
                            context, 'assets/watchbg.png');
                      },
                      child: Column(
                        children: [
                          SizedBox(height: 0.0),
                          Image.asset(
                            'assets/watchbg.png',
                            height: 80.0,
                            width: 50.0,
                          ),
                          SizedBox(height: 0.0),
                          Text('Watches'),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.arrow_forward_ios_rounded, size: 15.0),
                    SizedBox(height: 0.0),
                  ],
                ),
              ],
            ),
            SizedBox(height: 0.0),
            Padding(
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'assets/offer.jpeg',
                  height: 80.0,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            SizedBox(height: 0.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    _navigateToItemDescription(context, 'assets/watch.png');
                  },
                  child: Container(
                    width: 100.0,
                    height: 150.0,
                    margin: EdgeInsets.all(0.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 5.0),
                        Text('Save 5%'),
                        Image.asset(
                          'assets/watch.png',
                          height: 60.0,
                          width: 60.0,
                        ),
                        SizedBox(height: 0.0),
                        Text('Boat Watch'),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _navigateToItemDescription(context, 'assets/mobile.png');
                  },
                  child: Container(
                    width: 100.0,
                    height: 150.0,
                    margin: EdgeInsets.all(0.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 5.0),
                        Text('Save 5%'),
                        Image.asset(
                          'assets/mobile.png',
                          height: 60.0,
                          width: 60.0,
                        ),
                        SizedBox(height: 0.0),
                        Text('IPhone'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 103.0,
              child: Container(
                margin: EdgeInsets.only(top: 20.0),
                child: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart),
                      label: 'Cart',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle),
                      label: 'Account',
                    ),
                  ],
                  selectedItemColor: Colors.blue,
                  onTap: (index) {
                    if (index == 2) {
                      // Check if 'Account' is tapped
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AccountScreen(),
                        ),
                      );
                    }
                    if (index == 1) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CartScreen(),
                        ),
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => RegisterScreen(),
                  ),
                );
              },
              child: Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}

void _navigateToItemDescription(BuildContext context, String imagePath) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => ItemDescription(imagePath: imagePath),
    ),
  );
}

class ItemDescription extends StatelessWidget {
  final String imagePath;

  ItemDescription({required this.imagePath});
  Future<String> getUserAddress() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('accountinfo')
            .doc(uid)
            .get();

        if (userDoc.exists) {
          // Return the user's address
          return userDoc['address'] ?? '';
        }
      } catch (e) {
        print('Error fetching user address: $e');
      }
    }

    return ''; // Return an empty string if there's an error or no address found
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Item Description'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            // Search bar above the watch image
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, top: 80.0, right: 20.0, bottom: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 315.0),
                      child: Icon(
                        Icons.mic,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Watch image
            Positioned(
              top: 220, // Adjust the distance from the top as needed
              left: 20.0,
              right: 20.0,
              child: Image.asset(
                imagePath,
                // 'assets/watch.png',
                width: 350.0, // Adjust the width as needed
                height: 350.0, // Adjust the height as needed
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, right: 200.0),
              child: Text(
                "Select Variant",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(
              color: Colors.black,
              thickness: 1.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 100.0),
              child: Text(
                "Strap Color: Cherry Blossom",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
            Divider(
              color: Colors.black,
              thickness: 1.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, right: 150.0, bottom: 20.0),
              child: Text(
                "Display Size: 46.4 mm",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50.0,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CartScreen(imagePath: imagePath),
                                ),
                              );
                              // Handle first button press
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                              primary: Colors.white,
                            ),
                            child: Text(
                              'Add to Cart',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Expanded(
                        child: Container(
                          height: 50.0,
                          child: ElevatedButton(
                            // onPressed: () async {
                            //   String userAddress = await getUserAddress();
                            //   _showConfirmationDialog(context, userAddress);
                            //   // Handle second button press
                            // },
                            onPressed: () async {
                              // Navigate to AccountScreen
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AccountScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                              primary: Colors.yellow,
                            ),
                            child: Text(
                              'Delivery Address',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showConfirmationDialog(
      BuildContext context, String userAddress) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Address'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'User Address: $userAddress'), // Replace with actual address
                // You can add more details here
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirm and Book Now'),
              onPressed: () {
                // Implement the action when the user confirms
                // For example, navigate to the next screen or perform the booking
                Navigator.of(context).pop();
                _showBookingConfirmedDialog(context); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showBookingConfirmedDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Booking Confirmed'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Your booking has been confirmed!'),
                // You can add more details here
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                // Implement any additional actions when the user clicks OK
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}

class CartScreen extends StatelessWidget {
  final String? imagePath;

  CartScreen({this.imagePath});
  Future<Map<String, String>> getUserAddress() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('accountinfo')
            .doc(uid)
            .get();

        if (userDoc.exists) {
          // Return a map containing the user's address and city
          return {
            'address': userDoc['address'] ?? '',
            'city': userDoc['city'] ?? '',
            'flat': userDoc['flat'] ?? '',
            'state': userDoc['state'] ?? '',
            'country': userDoc['country'] ?? '',
          };
        }
      } catch (e) {
        print('Error fetching user address: $e');
      }
    }

    // Return an empty map if there's an error or no address found
    return {
      'address': '',
      'city': '',
      'flat': '',
      'state': '',
      'country': '',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Product 1
              _buildCartItem(
                imagePath: imagePath ?? 'assets/mobile.png',
                productName: 'Product 1',
                stars: 4,
                discountPercentage: 75,
                originalPrice: '6̶4̶9̶9̶',
                discountedPrice: '1,599',
                offerText: '1 offer available',
              ),
              // Divider between products
              Divider(
                color: Colors.black,
                thickness: 1.0,
              ),
              // Image below the divider
              SizedBox(
                height: 250.0,
                width: 400.0,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18.0),
                      child: Image.asset(
                        'assets/warranty.jpeg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 6.0),
              // Price details
              Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  'Price Details',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Original Price:',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Rs.6499',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              // Calculating discounted price
              _buildDiscountedPrice(context, 6499, 75),
              Divider(
                color: Colors.black,
                thickness: 1.0,
              ),
            ],
          ),
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: SizedBox(
        height: 80.0,
        child: Container(
          margin: EdgeInsets.only(top: 21.0),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Account',
              ),
            ],
            selectedItemColor: Colors.blue,
            onTap: (index) {
              if (index == 2) {
                // Check if 'Account' is tapped
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AccountScreen(),
                  ),
                );
              }
              if (index == 1) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                ); // Go back to the HomeScreen
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDiscountedPrice(
      BuildContext context, double originalPrice, int discountPercentage) {
    double discountedPrice = (discountPercentage / 100) * originalPrice;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'You Save:',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            Text(
              'Rs.${discountedPrice.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        // Display Discounted Price
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   ' Discounted Price:',
            //   style: TextStyle(
            //     fontSize: 18.0,
            //     color: Colors.black,
            //   ),
            // ),
            // Text(
            //   'Rs.${discountedPrice.toStringAsFixed(0)}',
            //   style: TextStyle(
            //     fontSize: 18.0,
            //     color: Colors.black,
            //   ),
            // ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 0.0),
              child: ElevatedButton(
                onPressed: () async {
                  Map<String, String> userAddress = await getUserAddress();
                  String address = userAddress['address'] ?? '';
                  String city = userAddress['city'] ?? '';
                  String country = userAddress['country'] ?? '';
                  String state = userAddress['state'] ?? '';
                  String flat = userAddress['flat'] ?? '';

                  // Show the place order dialog with user's address
                  _showPlaceOrderDialog(context, originalPrice, discountedPrice,
                      address, city, flat, state, country);
                  // Add functionality for placing an order
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow[700], // Yellow color
                  padding:
                      EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
                ),
                child: Text(
                  'Place Order',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCartItem({
    required String imagePath,
    required String productName,
    required int stars,
    required int discountPercentage,
    required String originalPrice,
    required String discountedPrice,
    required String offerText,
  }) {
    double discountedPriceValue =
        double.parse(originalPrice.replaceAll('̶', '')) -
            (discountPercentage / 100) *
                double.parse(originalPrice.replaceAll('̶', ''));

    return Container(
      margin: EdgeInsets.only(right: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image on the left
          Image.asset(
            imagePath,
            height: 80.0,
            width: 80.0,
          ),
          SizedBox(width: 20.0),
          // Text on the right
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Box below the image with "Qty: 1" inside
              SizedBox(height: 8.0),
              Text(
                productName,
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 8.0),
              // Star rating
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < stars ? Icons.star : Icons.star_border,
                    color: Colors.yellow[700],
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              // Discount details
              Row(
                children: [
                  // Percentage text
                  Text(
                    '$discountPercentage%',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.yellow[700],
                    ),
                  ),
                  SizedBox(width: 15.0),
                  // Original price
                  Text(
                    'R̶s̶.$originalPrice ',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(width: 10.0),
                  // Discounted price
                  Text(
                    'Rs.${discountedPriceValue.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              // Offer text
              Text(
                offerText,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showPlaceOrderDialog(
      BuildContext context,
      double originalPrice,
      double discountedPrice,
      String userAddress,
      String userCity,
      String userFlat,
      String userState,
      String userCountry) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Order'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Original Price: $originalPrice'), // Corrected this line
              SizedBox(height: 10.0),
              Text(
                  'Discounted Price: Rs.${discountedPrice.toStringAsFixed(0)}'),
              SizedBox(height: 10.0),
              Text(
                  'User Address:$userFlat,$userAddress,$userCity,$userState,$userCountry'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Add functionality for placing the order
                // Close the dialog
                Navigator.of(context).pop();
                _showBookingConfirmedDialog(context);
                // You can add further actions related to placing the order
              },
              style: ElevatedButton.styleFrom(
                  // primary: Colors.yellow,
                  ),
              child: Text('Place Order'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showBookingConfirmedDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Booking Confirmed'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Your booking has been confirmed!'),
                // You can add more details here
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                // Implement any additional actions when the user clicks OK
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  TextEditingController _flatController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _countryController = TextEditingController();

  // Function to store the address in Cloud Firestore
  Future<void> submitAddress() async {
    String flat = _flatController.text;
    String address = _addressController.text;
    String city = _cityController.text;
    String state = _stateController.text;
    String country = _countryController.text;

    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Use the user's UID as the document ID
      String uid = user.uid;

      try {
        // Get the existing user document
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('accountinfo')
            .doc(uid)
            .get();

        // Check if the user document exists
        if (userDoc.exists) {
          // Update the existing user document with the address
          await FirebaseFirestore.instance
              .collection('accountinfo')
              .doc(uid)
              // .update({'username':username});
              .update({
            'flat': flat,
            'address': address,
            'city': city,
            'state': state,
            'country': country
          });
        } else {
          print('User document not found');
        }

        print('Address submitted successfully!');
        _showSuccessDialog(context);
      } catch (e) {
        print('Error submitting address: $e');
      }
    } else {
      print('User not authenticated');
    }
  }

  @override
  void dispose() {
    _flatController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Blue background from the top
            Container(
              color: Colors.blue[600], // Blue color
              height: 150.0, // Set the height as needed
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/profile.png', // Replace with the actual path to your profile image
                      height: 80.0, // Set the height of the profile image
                      width: 80.0, // Set the width of the profile image
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            // White background below - Firstname
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Flat No./BuildingName',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  TextFormField(
                    // initialValue: username, // Display the username
                    // enabled: false,
                    controller: _flatController,
                    decoration: InputDecoration(
                      hintText: '',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),

            // White background below - Mobile Number
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                  left: 16.0, top: 0.0, right: 16.0, bottom: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Address',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  TextFormField(
                    // initialValue: mobileno, // Display the username
                    // enabled: false,
                    controller: _addressController,
                    decoration: InputDecoration(
                      hintText: ' ',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                  left: 16.0, top: 0.0, right: 16.0, bottom: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'City',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  TextFormField(
                    // initialValue: mobileno, // Display the username
                    // enabled: false,
                    controller: _cityController,
                    decoration: InputDecoration(
                      hintText: ' ',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                  left: 16.0, top: 0.0, right: 16.0, bottom: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'State',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  TextFormField(
                    // initialValue: mobileno, // Display the username
                    // enabled: false,
                    controller: _stateController,
                    decoration: InputDecoration(
                      hintText: ' ',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                  left: 16.0, top: 0.0, right: 16.0, bottom: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Country',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  TextFormField(
                    // initialValue: mobileno, // Display the username
                    // enabled: false,
                    controller: _countryController,
                    decoration: InputDecoration(
                      hintText: ' ',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            // White background below - Email

            Container(
              color: Colors.white,
              padding: EdgeInsets.all(5.0),
              child: ElevatedButton(
                onPressed: () {
                  submitAddress();
                  // Add functionality for deactivating the account
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // Blue background color
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Success'),
        content: Text('Address stored successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog

              // Navigate to CartScreen
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              );
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
