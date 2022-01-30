import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_otp_verification_firebase/configaration.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final textController = TextEditingController();
  final auth = FirebaseAuth.instance;
  String verificationId = "";

  @override
  void dispose() {
    SystemChannels.textInput.invokeMethod("TextInput.hide");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textFactor = MediaQuery.textScaleFactorOf(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xfff7f6fb),
      appBar: AppBar(
        toolbarHeight: 80,
        leadingWidth: 80,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            size: 26,
            color: Colors.black54,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .06),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: height * .8,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.52,
                    child: FadeInDown(
                      child: Column(
                        children: [
                          Container(
                            width: width * 0.65,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.shade50,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              'assets/Mobile login-bro.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(height: height * 0.025),
                          Text(
                            'Registration',
                            style: TextStyle(
                              fontSize: textFactor * 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                          Text(
                            "Add your phone number. we'll send you a verification code so we know you're real",
                            style: TextStyle(
                              fontSize: textFactor * 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black38,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  FadeInUp(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.24,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: textController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              fontSize: textFactor * 17,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefix: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  '(+91)',
                                  style: TextStyle(
                                    fontSize: textFactor * 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height * .025),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                final regex = RegExp(r'^.{10}$');
                                if (!regex.hasMatch(textController.text)) {
                                  Fluttertoast.showToast(
                                    msg: "Enter Valid PhoneNumber",
                                  );
                                } else {
                                  verifyPhoneNumber(
                                    textController.text,
                                    context,
                                  );
                                }
                              },
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.white,
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  const Color(0xff14B8A6),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(14.0),
                                child: Text(
                                  'Send',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
