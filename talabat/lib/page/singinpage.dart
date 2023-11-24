import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:talabat/src/colors.dart';

import 'loginpage.dart';

class SingIn extends StatefulWidget {
  const SingIn({Key? key}) : super(key: key);

  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Radius radius = const Radius.circular(50);
  TextEditingController myphone = TextEditingController();
  late String drob;

  var cantry = ['Iraq', "drffr"];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Ccolors().globel,
      body: Column(
        children: [
          const Expanded(
              child: FlutterLogo(
            size: 70,
          )),
          Expanded(
            flex: 2,
            child: Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.only(topLeft: radius, topRight: radius)),
              child: mybody(),
            ),
          )
        ],
      ),
    ));
  }

  Widget mybody() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Sing In",
              style: TextStyle(fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: IntlPhoneField(
                    controller: myphone,
                    decoration: InputDecoration(
                        labelText: 'Phone Number',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Ccolors().spshel),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Ccolors().spshel),
                            borderRadius: BorderRadius.circular(10))),
                    initialCountryCode: 'IQ',
                    onChanged: (phone) {
                      drob = phone.completeNumber;
                    },
                  ),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: MaterialButton(
                    color: Ccolors().spshel,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    onPressed: () async {
                      _formKey.currentState?.validate();
                      if (_formKey.currentState!.validate()) {
                        // Savedata().save("myphone", myphone.text.toString());
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => OTPScreen(drob),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "Send Code",
                      style: TextStyle(color: Ccolors().card),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
