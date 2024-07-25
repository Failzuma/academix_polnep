import 'package:academix_polnep/views/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formkey = GlobalKey<FormState>();

  bool? checkValue = false;

  BoxShadow boxShadow = BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 3, blurRadius: 2, offset: const Offset(0, 3));

// background pake ini
  Gradient gradient = const LinearGradient(
      colors: [
        Color(0xFF158AD4),
        Color(0xFF39EADD)
      ],
      begin: FractionalOffset(0.0, 0.0),
      end: FractionalOffset(0.0, 1.0),
      stops: [
        0.0,
        1.0
      ],
      tileMode: TileMode.clamp);
// button pake ini
  Gradient btnGradient = const LinearGradient(
      colors: [
        Color(0xFF158AD4),
        Color(0xFF39EADD)
      ],
      begin: FractionalOffset(0.0, 0.0),
      end: FractionalOffset(0.0, 1.0),
      stops: [
        0.0,
        1.0
      ],
      tileMode: TileMode.clamp);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: gradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: _formkey,
          child: Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                const Padding(padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                      text: TextSpan(
                          text: "<- Kembali",
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return const Login();
                              }));
                            })),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0)),
                Container(
                  height: 140,
                  width: 350,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        boxShadow
                      ],
                      borderRadius: BorderRadius.circular(20)),
                  child: Align(
                    alignment: Alignment.center,
                    child: RichText(
                        text: const TextSpan(
                      text: '''
ACADEMIX
Jurusan Teknik Elektro
Politeknik Negeri Pontianak
                      ''',
                      style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(20)),
                Container(
                  height: 120,
                  width: 350,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        boxShadow
                      ],
                      borderRadius: BorderRadius.circular(20)),
                  child: Align(
                    alignment: Alignment.center,
                    child: RichText(
                        text: const TextSpan(
                      text: "To reset your password, please submit your nim and email address. If we can find you in the database, an email will be sent to your email address, with instructions how to get access again",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    )),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(20)),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "NIM/NIP",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 2.0), borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 2.0), borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (value) {
                      if (value!.contains(RegExp(r'([a-zA-Z])'))) {
                        return "Nim tidak boleh ada huruf";
                      }
                      return null;
                    },
                  ),
                ),
                const Padding(padding: EdgeInsets.all(15)),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "EMAIL",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 2.0), borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 2.0), borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (value) {
                      if (!value!.contains(RegExp(r'((?<![\w])com(?![\w]))'))) {
                        return "Email salah";
                      }
                      return null;
                    },
                  ),
                ),
                const Padding(padding: EdgeInsets.all(20)),
                Container(
                  width: 200,
                  decoration: BoxDecoration(gradient: btnGradient, borderRadius: BorderRadius.circular(20), boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 3, blurRadius: 2, offset: const Offset(0, 3))
                  ]),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                    child: const Text(
                      "SUBMIT",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                          return Login();
                        }));
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
