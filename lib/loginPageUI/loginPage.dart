import 'package:exam/loginPageUI/smsPage.dart';
import 'package:exam/loginPageUI/updatePasswordPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'mainPage.dart';

FirebaseAuth _authUser = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool e = false;
  bool p = false;
  var _formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  GoogleSignIn _googleSignIn = GoogleSignIn();
  late FirebaseAuth _auth;

  bool isUserSignedIn = false;

  @override
  void initState() {
    super.initState();

    initApp();
  }

  void initApp() async {
    FirebaseApp defaultApp = await Firebase.initializeApp();
    _auth = FirebaseAuth.instanceFor(app: defaultApp);
    checkIfUserIsSignedIn();
  }

  void checkIfUserIsSignedIn() async {
    var userSignedIn = await _googleSignIn.isSignedIn();

    setState(() {
      isUserSignedIn = userSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width / 1.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/firebase.png"),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Log in to your existant account of Q Allure",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Email
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: e ? Colors.blue : Colors.red,
                      ),
                      hintText: "Enter your Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onSaved: (e) {
                    email = e;
                  },
                  onChanged: (ds) {
                    setState(() {
                      if (ds.length > 6) {
                        e = true;
                      } else {
                        e = false;
                      }
                    });
                  },
                  validator: (text) {
                    if (text!.length < 6) {
                      return "Kamida 6 ta belgi kerak";
                    }
                  },
                ),
              ),
              // Password
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: TextFormField(
                  // scrollPadding: EdgeInsets.all(10),
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      prefixIcon: Container(
                        padding: EdgeInsets.only(top: 6),
                        alignment: Alignment.center,
                        height: 20,
                        width: 28,
                        child: Text(
                          "*",
                          style: TextStyle(
                              fontSize: 30,
                              color: p ? Colors.blue : Colors.red),
                        ),
                      ),
                      hintText: "Password",

                      // labelText: ,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                  obscureText: true,
                  onSaved: (p) {
                    password = p;
                  },
                  onChanged: (ds) {
                    setState(() {
                      if (ds.length > 6) {
                        p = true;
                      } else {
                        p = false;
                      }
                    });
                  },
                  validator: (text) {
                    if (text!.length < 6) {
                      return "Kamida 6 ta belgi kerak";
                    }
                  },
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 3,
                    ),
                    child: TextButton(
                      onPressed: () {
                        _resetPassword();
                      },
                      child: Text(
                        "Forgot password",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 3,
                    ),
                    child: TextButton(
                      onPressed: () {
                        _resetPassword();
                      },
                      child: Text(
                        "Update password",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.indigoAccent,
                    elevation: 10,
                    primary: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Container(
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  onPressed: _emailSignIn,
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Or connect using",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue.withOpacity(0.7)),
                    onPressed: () {
                      _emailSignInWithGoogle();
                      if (_emailSignInWithGoogle() != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainPage()));
                      }
                    },
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "f",
                              style:
                              TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue),
                            height: 26,
                            width: 20,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Facebook",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.orange.shade900.withOpacity(0.7)),
                    onPressed: () {
                      onGoogleSignIn(context);
                    },
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "G",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              color: Colors.orange.shade900,
                            ),
                            height: 26,
                            width: 26,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Google",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.orange.shade900.withOpacity(0.7)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SmsPage()));
                    },
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "P",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              color: Colors.orange.shade900,
                            ),
                            height: 26,
                            width: 26,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "phone",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Text("Update Password"),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePage()));
                    },
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?  ",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      print("bosildi.");
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _emailSignIn() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        FocusScope.of(context).unfocus();
        User _signInQilganUser = (await _authUser.signInWithEmailAndPassword(
            email: email!, password: password!))
            .user!;

        print("User Tizimga Kirdi: ${_signInQilganUser.email}");
        if (_signInQilganUser.emailVerified) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainPage()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 3),
              content: Text("Emailni Tekshirib Qaytadan Urinib Ko'ring !"),
            ),
          );
        }
      }
    } catch (e) {
      print("XATO: " + e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          content: Text("Email yoki Password Xato !"),
        ),
      );
    }
  }

  void _signOut() async {
    if (_authUser.currentUser != null) {
      await _authUser.signOut();
    } else {
      print("Shundoqham User Yo'q !");
    }
  }

  Future<User> _handleSignIn() async {
    User user;
    bool userSignedIn = await _googleSignIn.isSignedIn();

    setState(() {
      isUserSignedIn = userSignedIn;
    });

    if (isUserSignedIn) {
      user = _auth.currentUser!;
    } else {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      user = (await _auth.signInWithCredential(credential)).user!;
      userSignedIn = await _googleSignIn.isSignedIn();
      setState(() {
        isUserSignedIn = userSignedIn;
      });
    }

    return user;
  }

  void onGoogleSignIn(BuildContext context) async {
    User user = await _handleSignIn();
    var userSignedIn = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomeUserWidget(user, _googleSignIn),
      ),
    );

    setState(() {
      isUserSignedIn = userSignedIn == null ? true : false;
    });
  }

  _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        _formKey.currentState!.save();
        print(email);
        await _authUser.sendPasswordResetEmail(email: email!);
      } catch (e) {
        print("Email Topilmadi Yoki Error");
      }
    }
  }

  _emailSignInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
    await googleUser!.authentication;

    var credential = GoogleAuthProvider.credential(
        accessToken: googleAuth!.accessToken, idToken: googleAuth.idToken);

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

class WelcomeUserWidget extends StatelessWidget {
  GoogleSignIn? _googleSignIn;
  User? _user;

  WelcomeUserWidget(User user, GoogleSignIn signIn) {
    _user = user;
    _googleSignIn = signIn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(50),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Text('Welcome,', textAlign: TextAlign.center),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  _googleSignIn!.signOut();
                  Navigator.pop(context, false);
                },
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.exit_to_app, color: Colors.white),
                      SizedBox(width: 10),
                      Text('Log out of Google',
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}