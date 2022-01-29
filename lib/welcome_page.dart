import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Image.asset(
                  'assets/Welcome-bro.png',
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    const Text(
                      "Let's get started",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Never a better time than now to start.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 38,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(builder: (context) => Register()),
                          // );
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xff14B8A6),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Create Account',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xff14B8A6),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
