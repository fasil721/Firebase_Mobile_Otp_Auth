import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_otp_verification_firebase/home_page.dart';

String verificationId = "";
final auth = FirebaseAuth.instance;

Future verifyOTP(String otp, BuildContext context) async {
  final credential = PhoneAuthProvider.credential(
    verificationId: verificationId,
    smsCode: otp,
  );
  await auth.signInWithCredential(credential).then((value) {
    Fluttertoast.showToast(
      msg: "You are logged in successfully",
    );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  });
}

Future<void> verifyPhoneNumber(String phoneNumber) async {
  try {
    await auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      phoneNumber: "+91 $phoneNumber",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {});
      },
      verificationFailed: (FirebaseAuthException e) {
        Fluttertoast.showToast(msg: e.toString());
      },
      codeSent: (String verificationid, int? resendToken) {
        verificationId = verificationid;
      },
      codeAutoRetrievalTimeout: (String verificationID) {},
    );
  } catch (e) {
    Fluttertoast.showToast(msg: e.toString());
  }
}
