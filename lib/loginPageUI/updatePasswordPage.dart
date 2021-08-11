import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'mainPage.dart';

FirebaseAuth _authUser = FirebaseAuth.instance;

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool e = false;
  bool p = false;
  var _formKey = GlobalKey<FormState>();


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

              // Password
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: TextFormField(
                  controller: password,
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
                      hintText: "New Password",

                      // labelText: ,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                  obscureText: true,
                  validator: (text) {
                    if (text!.length < 6) {
                      return "Kamida 6 ta belgi kerak";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: TextFormField(
                  controller: confirmPassword,
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
                      hintText: "Confirm Password",

                      // labelText: ,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                  obscureText: true,
                  validator: (text) {
                    if (password.text != confirmPassword.text) {
                      print("New password" + password.text);
                      return "Kamida 6 ta belgi kerak";
                    }
                  },
                ),
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
                      "Update",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  onPressed: _updatePassword,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }




  _updatePassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        _formKey.currentState!.save();
        print("Update Password Methodida confirm password" + confirmPassword.text);
        await _authUser.currentUser!.updatePassword(confirmPassword.text);
        await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
      } catch (e) {
        print("Password xato shekil");
      }
    }
  }


}

