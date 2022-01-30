import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_otp_verification_firebase/home_page.dart';
import 'package:mobile_otp_verification_firebase/otp_page.dart';

String verificationId = "";
final auth = FirebaseAuth.instance;
bool isLoading = false;
Future verifyOTP(String otp, BuildContext context) async {
  await Future.delayed(const Duration(seconds: 2));
  final credential = PhoneAuthProvider.credential(
    verificationId: verificationId,
    smsCode: otp,
  );
  try {
    await auth.signInWithCredential(credential);
    Fluttertoast.showToast(
      msg: "You are logged in successfully",
    ).then(
      (value) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
        (route) => false,
      ),
    );
  } on FirebaseAuthException catch (e) {
    Fluttertoast.showToast(msg: e.code);
  } catch (e) {
    Fluttertoast.showToast(msg: "catch----$e");
  }
}

Future verifyPhoneNumber(String phoneNumber, BuildContext context) async {
  await Future.delayed(const Duration(seconds: 2));
  try {
    auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      phoneNumber: "+91 $phoneNumber",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {});
      },
      verificationFailed: (FirebaseAuthException err) {
        Fluttertoast.showToast(msg: err.code);
      },
      codeSent: (String verificationid, int? resendToken) {
        verificationId = verificationid;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const Otp(),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationID) {},
    );
  } on FirebaseAuthException catch (err) {
    Fluttertoast.showToast(msg: err.code);
  }
}
