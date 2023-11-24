import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../src/colors.dart';
import 'myhomepage.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  const OTPScreen(this.phone, {Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  Radius radius = const Radius.circular(50);

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(20),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Ccolors().globel,
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: Ccolors().globel,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.only(topLeft: radius, topRight: radius)),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: Center(
                      child: Text(
                        'Verify ${widget.phone}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 26),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Pinput(
                      length: 6,
                      defaultPinTheme: defaultPinTheme,
                      controller: _pinPutController,
                      pinAnimationType: PinAnimationType.fade,
                      onSubmitted: (pin) async {
                        try {
                          await FirebaseAuth.instance
                              .signInWithCredential(
                                  PhoneAuthProvider.credential(
                                      verificationId: _verificationCode!,
                                      smsCode: pin))
                              .then((value) async {
                            if (value.user != null) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MyHomePage()),
                                  (route) => false);
                            }
                          });
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: const Duration(seconds: 120));
  }

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }
}
