import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_otp_verification_firebase/configaration.dart';
import 'package:mobile_otp_verification_firebase/home_page.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final otpController = OtpFieldController();
  String otp = "";

  @override
  void dispose() {
    SystemChannels.textInput.invokeMethod("TextInput.hide");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  width: width * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    'assets/Enter OTP-bro.png',
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Verification',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Enter your OTP code number",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     _textFieldOTP(first: true, last: false),
                      //     const SizedBox(width: 5),
                      //     _textFieldOTP(first: false, last: false),
                      //     const SizedBox(width: 5),
                      //     _textFieldOTP(first: false, last: false),
                      //     const SizedBox(width: 5),
                      //     _textFieldOTP(first: false, last: false),
                      //     const SizedBox(width: 5),
                      //     _textFieldOTP(first: false, last: false),
                      //     const SizedBox(width: 5),
                      //     _textFieldOTP(first: false, last: true),
                      //   ],
                      // ),
                      SizedBox(
                        height: 45,
                        child: OTPTextField(
                          length: 6,
                          width: MediaQuery.of(context).size.width * 0.9,
                          textFieldAlignment: MainAxisAlignment.spaceEvenly,
                          fieldWidth: 45,
                          otpFieldStyle: OtpFieldStyle(),
                          fieldStyle: FieldStyle.box,
                          keyboardType: TextInputType.phone,
                          outlineBorderRadius: 11,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          onChanged: (pin) {},
                          onCompleted: (pin) {
                            print("Completed: $pin");
                            otp = pin;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            final regex = RegExp(r'^.{6}$');
                            if (otp.isEmpty) {
                              Fluttertoast.showToast(
                                msg: "Enter otp",
                              );
                            } else if (regex.hasMatch(otp)) {
                              verifyOTP(otp, context);
                              // print("object");
                            } else {
                              Fluttertoast.showToast(
                                msg: "Enter Valid otp",
                              );
                            }
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
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
                              'Verify',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                const Text(
                  "Didn't you receive any code?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 18,
                ),
                const Text(
                  "Resend New Code",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff14B8A6),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//   Widget _textFieldOTP({required bool first, last}) {
//     return Expanded(
//       child: AspectRatio(
//         aspectRatio: .8,
//         child: TextField(
//           autofocus: true,
//           onChanged: (value) {
//             if (value.length == 1 && last == false) {
//               FocusScope.of(context).nextFocus();
//             }
//             if (value.isEmpty && first == false) {
//               FocusScope.of(context).previousFocus();
//             }
//           },
//           showCursor: false,
//           textAlignVertical: TextAlignVertical.center,
//           textAlign: TextAlign.center,
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           keyboardType: TextInputType.number,
//           maxLength: 1,
//           decoration: InputDecoration(
//             counter: const Offstage(),
//             enabledBorder: OutlineInputBorder(
//               borderSide: const BorderSide(width: 2, color: Colors.black12),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: const BorderSide(width: 2, color: Colors.purple),
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
}
