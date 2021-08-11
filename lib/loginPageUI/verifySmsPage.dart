import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'mainPage.dart';

FirebaseAuth _authUser = FirebaseAuth.instance;

class VerifySmsPage extends StatefulWidget {
  String? phone;

  VerifySmsPage(this.phone, {Key? key}) : super(key: key);

  @override
  _VerifySmsPageState createState() => _VerifySmsPageState();
}

class _VerifySmsPageState extends State<VerifySmsPage> {
  TextEditingController smsCode = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool e = false;
  bool p = false;
  var _formKey = GlobalKey<FormState>();
  String? phone;


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

              SizedBox(
                height: 20,
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
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // scrollPadding: EdgeInsets.all(10),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      hintText: "Sms code",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onSaved: (e) {
                    print("Sms code uzunligi: ${e!.length}");
                    phone = e;
                  },
                  obscureText: true,
                  validator: (text) {
                    if (text!.length < 6) {
                      return "Kamida 6 ta belgi kerak";
                    }
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                      "Confirm code",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  onPressed: () {
                    _phoneVerify;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  _phoneVerify() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await _authUser.verifyPhoneNumber(
          phoneNumber: widget.phone!,
          verificationCompleted: (PhoneAuthCredential credential){},
          verificationFailed: (FirebaseAuthException credential){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(duration: Duration(seconds: 3),
                content: Text("Sms Tekshirib qaytadan urinib koring"),
              ),
            );
          },
          codeSent: (String verificationId, int? resendToken) async {
            print("Sms Jonatildi");
            PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode.text);
            await _authUser.signInWithCredential(phoneAuthCredential);
            await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
          },
          codeAutoRetrievalTimeout: (String text){
            print("Text: $text");
          });
    }
  }


}

