// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

import '../../const/colors.dart';
import '../const/enums.dart';
import '../home/home_example.dart';
import '../provider/app_provider.dart';
import '../provider/login_api.dart';
import '../provider/tarif_provider.dart';

class PinCodeVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const PinCodeVerificationScreen({required this.phoneNumber, super.key});

  @override
  _PinCodeVerificationScreenState createState() => _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  final otpController = OtpFieldController();
  String code = "";

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providerLogin = Provider.of<LoginApi>(context);
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      // backgroundColor: Colors.blue.shade50,
      key: scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/verifyBackground.png'),
          fit: BoxFit.fill,
        )),
        child: ListView(
          children: <Widget>[
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Text(
                'Phone  Verification',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: RichText(
                text: TextSpan(
                    text: "Enter the code sent to ",
                    children: [
                      TextSpan(text: widget.phoneNumber, style: const TextStyle(color: Colors.white12, fontWeight: FontWeight.bold, fontSize: 15)),
                    ],
                    style: const TextStyle(color: Colors.white, fontSize: 15)),
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                child: OTPTextField(
                  controller: otpController,
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  spaceBetween: 6,
                  textFieldAlignment: MainAxisAlignment.center,
                  fieldWidth: 45,
                  fieldStyle: FieldStyle.box,
                  outlineBorderRadius: 3,
                  style: const TextStyle(fontSize: 17),
                  onCompleted: (value) async {
                    debugPrint("yes");
                    setState(() {
                      code = value;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(
                hasError ? "*Please fill up all the cells properly" : "",
                style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: sizeHeight * 4,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(text: "Didn't receive the code? ", style: const TextStyle(color: Colors.black54, fontSize: 15), children: [
                TextSpan(
                    text: " RESEND",
                    recognizer: onTapRecognizer,
                    style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16))
              ]),
            ),
            SizedBox(
              height: sizeHeight * 1.8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: InkWell(
                  onTap: () async {
                    formKey.currentState!.validate();
                    // conditions for validating
                    if (currentText.length != 6) {
                      await Provider.of<LoginApi>(context, listen: false).getToken(code, widget.phoneNumber);
                      if (mounted && providerLogin.user != null) {
                        await Provider.of<AppProvider>(context, listen: false).userSet(providerLogin.user!);
                      }
                      if (providerLogin.status == ApiStatus.success) {
                        showmessages("Üstünlikli");
                        Provider.of<TarifProvider>(context, listen: false).changeBottomSheet(0);
                        Timer(const Duration(seconds: 1), () {
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          Navigator.popUntil(context, (route) => route.isFirst);
                          // Navigator.of(context).pushNamed('/home');
                        });
                      } else {
                        showmessages("Ýalňyşlyk");
                      }
                    } else {
                      showmessages("Ýalňyşlyk");
                    }
                  },
                  child: VerifyButton('Verify')),
            ),
          ],
        ),
      ),
    );
  }

  showmessages(String message) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
    ));
  }

  Widget VerifyButton(String text) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.width / 8,
        // width: size.width / 1.22,
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: size.width / 30),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ));
  }
}
