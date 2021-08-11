import 'package:exam/loginPageUI/verifySmsPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'mainPage.dart';

FirebaseAuth _authUser = FirebaseAuth.instance;

class SmsPage extends StatefulWidget {
  const SmsPage({Key? key}) : super(key: key);

  @override
  _SmsPageState createState() => _SmsPageState();
}

class _SmsPageState extends State<SmsPage> {
  TextEditingController smsCode = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool e = false;
  bool p = false;
  var _formKey = GlobalKey<FormState>();
  String? phone;

  bool isUserSignedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      hintText: "Phone number",
                      // labelText: ,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onSaved: (e){
                    print("Telefon uzunligi: ${e!.length}");
                    phone = e;
                  },
                  initialValue: "+998",
                  maxLength: 13,
                  validator: (text) {
                    if (text!.length == 14) {
                      return "13 ta belgi bo'lishi  kerak";
                    }
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
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
                      "Phone number",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      _formKey.currentState!.save();
                      await Navigator.push(context, MaterialPageRoute(builder: (context) => VerifySmsPage(phone)));
                    }
                  },
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

