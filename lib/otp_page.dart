import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_otp_verification_firebase/configaration.dart';
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
  bool isLoading = false;

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
                  width: width * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    'assets/Enter OTP-bro.png',
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: height * 0.03),
                const Text(
                  'Verification',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: height * 0.02),
                const Text(
                  "Enter your OTP code number",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height * 0.03),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.06,
                        child: OTPTextField(
                          length: 6,
                          width: MediaQuery.of(context).size.width * 0.9,
                          textFieldAlignment: MainAxisAlignment.spaceEvenly,
                          fieldWidth: width * 0.1146,
                          otpFieldStyle: OtpFieldStyle(),
                          fieldStyle: FieldStyle.box,
                          keyboardType: TextInputType.phone,
                          outlineBorderRadius: 11,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          onChanged: (pin) {
                            otp = pin;
                          },
                          onCompleted: (pin) {
                            otp = pin;
                          },
                        ),
                      ),
                      SizedBox(height: height * 0.025),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () async {
                            final regex = RegExp(r'^.{6}$');
                            if (otp.isEmpty) {
                              Fluttertoast.showToast(
                                msg: "Enter otp",
                              );
                            } else if (regex.hasMatch(otp)) {
                              setState(() {
                                isLoading = true;
                              });
                              await verifyOTP(otp, context);
                              setState(() {
                                isLoading = false;
                              });
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
                          child: isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Verify',
                                  style: TextStyle(fontSize: 16),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.05),
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
