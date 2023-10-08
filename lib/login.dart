import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:project_temples/home.dart';
import 'package:project_temples/main.dart';
import 'package:project_temples/widgets/custom_snackbars.dart';
import 'package:email_otp/email_otp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool _hidePassword = true;
bool _loading = false;
bool _otpVerified = false;

TextEditingController _authEmail = TextEditingController();
TextEditingController _authPassword = TextEditingController();
TextEditingController _otpController = TextEditingController();
EmailOTP myauth = EmailOTP();

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    _hidePassword = true;
  }

  @override
  void dispose() {
    super.dispose();
    _hidePassword = true;
    _authEmail.text = '';
    _authPassword.text = '';
    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    emailRegisteration() async {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: _authEmail.text.trim(),
          password: _authPassword.text.trim(),
        )
            .then((value) {
          successSnackbar(context, 'Login successful');

          Get.to(const HomePage());
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          Navigator.pop(context);
          errorSnackbar(
              context, 'This user already exists. Please Login to continue');
        } else if (e.code == 'weak-password') {
          errorSnackbar(context, 'Please enter a stronger password');
        } else {
          errorSnackbar(context, e.toString());
        }
      }
    }

    passwordSignIn() async {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _authEmail.text, password: _authPassword.text)
            .onError((error, stackTrace) {
          if (error == 'user-not-found') {
            emailRegisteration();
            setState(() {
              _loading = false;
            });
            return errorSnackbar(
                context, 'This is a new user. Creating profile');
          } else if (error == 'wrong-password') {
            setState(() {
              _loading = false;
            });
            return errorSnackbar(context, 'Wrong password');
          } else if (error == 'INVALID_LOGIN_CREDENTIALS') {
            // errorSnackbar(context, 'Wrong email or password');
            // setState(() {
            //   _loading = false;
            // });
            emailRegisteration();
            return errorSnackbar(context, 'Wrong password');
          } else {
            setState(() {
              _loading = false;
            });
            try {
              emailRegisteration();
            } catch (e) {
              return errorSnackbar(context, e.toString());
            }
            return errorSnackbar(context, error.toString());
          }
        });
        successSnackbar(context, 'Login successful');
        Navigator.popUntil(context, (route) => false);

        Get.to(const HomePage(), transition: Transition.cupertino);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          errorSnackbar(context, 'No user found for that email');
        } else if (e.code == 'wrong-password') {
          errorSnackbar(context, 'Wrong password');
        }
      }
    }

    Future sendEmailOtp() async {
      myauth.setConfig(
          appEmail: "aadityajagdale.21@gmail.com",
          appName: "Email OTP",
          userEmail: _authEmail.text,
          otpLength: 4,
          otpType: OTPType.digitsOnly);
      if (await myauth.sendOTP() == true) {
        successSnackbar(context, 'OTP has been sent');
      } else {
        setState(() {
          _loading = false;
        });
        errorSnackbar(context, 'Faild to send the OTP');
      }
    }

    verifyEmailOtp() {
      return AlertDialog(
        backgroundColor: bgGreen,
        title: Text(
          'Enter OTP',
          style: GoogleFonts.leagueSpartan(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(height: 30),
            Pinput(
              length: 4,
              controller: _otpController,
              defaultPinTheme: PinTheme(
                height: 65,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: darkGreen),
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: GoogleFonts.poppins(),
              ),
              focusedPinTheme: PinTheme(
                height: 65,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: darkGreen),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff101010).withOpacity(0.3),
                      offset: const Offset(0, 5),
                      blurRadius: 1,
                    ),
                  ],
                ),
                textStyle: GoogleFonts.poppins(),
              ),
              onCompleted: (otp) async {
                if (await myauth.verifyOTP(otp: otp) == true) {
                  setState(() {
                    _otpVerified = true;
                    Navigator.pop(context);
                  });
                  await passwordSignIn();
                } else {
                  errorSnackbar(context, 'Please enter correct OTP');
                }
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  if (await myauth.verifyOTP(otp: _otpController.text) ==
                      true) {
                    setState(() {
                      _otpVerified = true;
                    });
                    Navigator.pop(context);
                    successSnackbar(context, 'OTP is verfied');
                  } else {
                    errorSnackbar(context, 'Please enter correct OTP');
                  }
                },
                child: Text(
                  'Verify OTP',
                  style: GoogleFonts.leagueSpartan(
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: 50,
              child: IconButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: darkGreen),
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                    setState(() {
                      _loading = false;
                    });
                  },
                  icon: const Icon(
                    Icons.close_outlined,
                  )),
            ),
          ],
        ),
      );
    }

    forgotPassword() {
      return AlertDialog(
        title: Text(
          "Please enter your email",
          style: GoogleFonts.inter(),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Email'),
                TextField(
                  controller: _authEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Rahul@gmail.com',
                    hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: w,
            child: ElevatedButton(
              onPressed: () async {
                try {
                  if (_authEmail.text.isNotEmpty &&
                      _authEmail.text.contains('@')) {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: _authEmail.text);
                    successSnackbar(context,
                        'Please check your email to reset your password');
                    Navigator.pop(context);
                  } else if (!_authEmail.text.contains('@')) {
                    errorSnackbar(context, 'Please enter a proper email');
                  }
                  if (_authEmail.text.isEmpty) {
                    errorSnackbar(context, 'Please enter email');
                  }
                } catch (e) {
                  errorSnackbar(context, e.toString());
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: darkGreen),
              child: Text(
                'Send reset link on email',
                style: GoogleFonts.inter(),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 50,
            width: w,
            child: IconButton(
                icon: const Icon(Icons.close_outlined),
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    _loading = false;
                  });
                }),
          )
        ],
      );
    }

    return Scaffold(
      backgroundColor: bgGreen,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 70),
            Text(
              'Email Address',
              textAlign: TextAlign.left,
              style: GoogleFonts.leagueSpartan(
                fontWeight: FontWeight.w900,
                fontSize: 40,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'An OTP will be sent on this email to verify the user',
              textAlign: TextAlign.left,
              style: GoogleFonts.notoSerifDevanagari(
                fontWeight: FontWeight.normal,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              width: w,
              alignment: Alignment.center,
              child: TextFormField(
                controller: _authEmail,
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                cursorColor: Colors.red,
                decoration: InputDecoration(
                  counterText: '',
                  hintText: 'example@gmail.com',
                  hintStyle: GoogleFonts.inter(
                    color: Colors.grey[700],
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: darkGreen, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: darkGreen, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: darkGreen, width: 3),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              width: w,
              alignment: Alignment.center,
              child: TextFormField(
                controller: _authPassword,
                obscureText: _hidePassword,
                keyboardType: TextInputType.visiblePassword,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                cursorColor: Colors.red,
                decoration: InputDecoration(
                  hintText: 'Minimum 6 digit password',
                  hintStyle: GoogleFonts.inter(
                    color: Colors.grey[700],
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  suffixIcon: _hidePassword
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _hidePassword = !_hidePassword;
                            });
                          },
                          icon: Icon(
                            Icons.visibility_rounded,
                            color: Colors.black.withOpacity(.8),
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              _hidePassword = !_hidePassword;
                            });
                          },
                          icon: const Icon(
                            Icons.visibility_off_rounded,
                            color: Colors.grey,
                          ),
                        ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: darkGreen, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: darkGreen, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: darkGreen, width: 3),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Expanded(child: SizedBox()),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              width: w,
              height: 90,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff303030),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  if (_authEmail.text.trim().isEmpty ||
                      _authPassword.text.trim().isEmpty) {
                    errorSnackbar(context, 'Please enter a email and password');
                  } else if (!_authEmail.text.contains('@')) {
                    errorSnackbar(context, 'Please enter a valid email');
                  } else {
                    if (!_otpVerified) {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        _loading = true;
                        _otpController.text = '';
                      });
                      await sendEmailOtp();
                      await showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => verifyEmailOtp(),
                      );
                    } else {
                      await passwordSignIn();
                      setState(() {
                        _loading = false;
                      });
                    }
                  }
                },
                child: _loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Text(
                        'Send OTP',
                        style: GoogleFonts.poppins(color: lightGreen),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
