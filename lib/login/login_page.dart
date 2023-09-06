import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const/colors.dart';
import '../provider/login_api.dart';
import 'otp_page.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool signUp = true;
  bool signIn = false;
  int loginIndex = 0;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double sizeHeight = MediaQuery.of(context).size.height / 100;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: SizedBox(
              height: size.height,
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/loginBackground.png',
                        ),
                        fit: BoxFit.fill)),
                child: SizedBox(
                  height: sizeHeight * 85,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: sizeHeight * 26.5,
                      ),
                      Container(
                        width: size.width * .92,
                        height: sizeHeight * 46.8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.2),
                              blurRadius: 90,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: sizeHeight * 10.6,
                              child: Container(
                                alignment: Alignment.center,
                                height: 87,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    const Text(
                                      'Içeri gir',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 9,
                                    ),
                                    Container(
                                      height: 5,
                                      width: 37,
                                      decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2.5)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    height: sizeHeight * 3.5,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(
                                      'Telefon belgiňizi ýazyp içeri girip bilersiňiz!',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                  SizedBox(
                                    height: sizeHeight * 3.3,
                                  ),
                                  loginNumber('61 xxxxxx', false, true),
                                  SizedBox(
                                    height: sizeHeight * 7.5,
                                  ),
                                  Center(
                                    child: InkWell(
                                        onTap: () async {
                                          if (controller.text.isEmpty) {
                                            showmessages("Telefon belgiňizi ýazyň");
                                            return;
                                          }
                                          print(controller.text);
                                          if (controller.text.length != 8) {
                                            showmessages("Telefon belgi ýalňyş ");
                                            return;
                                          }
                                          if (formKey.currentState!.validate()) {
                                            await Provider.of<LoginApi>(context, listen: false).sendCodePhone(controller.text);
                                            if (mounted) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => PinCodeVerificationScreen(
                                                          phoneNumber: controller.text,
                                                        )),
                                              );
                                            }
                                          } else {}
                                          // if (formKey.currentState!.validate()) {
                                          //   Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(builder: (context) => PinCodeVerificationScreen('61748339')),
                                          //   );
                                          // }
                                        },
                                        child: LoginButton('Indiki')),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: sizeHeight * 8,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginNumber(String hintText, bool isPassword, bool isEmail) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.width / 8,
        width: size.width / 1.22,
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: size.width / 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFEFEFF4), width: 1.5),
        ),
        child: TextFormField(
          controller: controller,
          style: TextStyle(color: Colors.black.withOpacity(.8)),
          obscureText: isPassword,
          keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 10, top: 12, right: 5),
              child: Text(
                '+993 |',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ),
            // prefix: Text('+993'),
            border: InputBorder.none,
            hintMaxLines: 1,
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 16, color: Colors.black.withOpacity(.5)),
          ),
          onChanged: onPhoneChanged,
          validator: (val) {},
        ));
  }

  onPhoneChanged(String val) {
    List<String> nums = ['1', '2', '3', '4', '5'];
    if (!val.startsWith('6')) {
      showmessages('6 bilen baslamaly');
      controller.clear();
    } else if (val.length > 1 && !nums.contains(val[1])) {
      showmessages('61 bilen 65 aralygynda bolmaly');
      controller.text = '6';
      controller.selection = TextSelection.fromPosition(const TextPosition(offset: 1));
    } else {}
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

  Widget LoginButton(String text) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.width / 8,
        width: size.width / 1.22,
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

class MyBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
