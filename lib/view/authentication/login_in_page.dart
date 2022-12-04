import 'dart:developer';
import 'package:pinput/pinput.dart';
import 'package:riverrr/constant/import.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController controller = TextEditingController();
  FocusNode nameFn = FocusNode();

  bool isOptSend = false;
  bool isLoading = false;
  String? verificationId;
  String? smsCode;
  final _formKey = GlobalKey<FormState>();

  _loadingState(bool iIsLoading) {
    isLoading = iIsLoading;
    _notify();
  }

  _notify() {
    if (mounted) setState(() {});
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhiteColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: kToolbarHeight,
                    bottom: kToolbarHeight * 3,
                    right: 20,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      gotoHomePage();
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                      text: 'Flutter',
                      style: TextStyle(
                        color: kBlack,
                        fontSize: 18,
                      ),
                      children: [
                        TextSpan(
                          text: '.Dev',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 18,
                          ),
                        ),
                      ]),
                ),
                const SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        text: 'Log',
                        style: TextStyle(
                          color: kBlack,
                          letterSpacing: 1,
                        ),
                        children: [
                          TextSpan(
                            text: 'In',
                            style: TextStyle(
                              color: kPrimaryColor,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      autofocus: false,
                      controller: controller,
                      focusNode: nameFn,
                      keyboardType: TextInputType.phone,
                      validator: (validator) {
                        if (validator != null && validator.isEmpty) {
                          return 'Enter the phone number';
                        } else if (validator != null &&
                            validator.isNotEmpty &&
                            validator.length < 10) {
                          return 'Enter the 10 digit phone number';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (onChanged) {
                        log(onChanged);
                      },
                      maxLength: 10,
                      onFieldSubmitted: (onFieldSubmitted) {
                        validate();
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        prefixIcon: Container(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(kBorderRadius),
                              bottomLeft: Radius.circular(kBorderRadius),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            '+91',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        hintText: 'Enter phone number',
                        fillColor: klightBlack,
                        filled: false,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(kBorderRadius),
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(kBorderRadius),
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                            width: 1,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(kBorderRadius),
                          borderSide: BorderSide(
                            color: kRedColor,
                            width: 1,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(kBorderRadius),
                          borderSide: BorderSide(
                            color: kRedColor,
                            width: 1,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(kBorderRadius),
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                            width: 1,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(kBorderRadius),
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (isOptSend)
                  Pinput(
                    defaultPinTheme: PinTheme(
                      width: hw,
                      height: hw,
                      textStyle: TextStyle(
                          fontSize: 20,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600),
                      decoration: BoxDecoration(
                        border: Border.all(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(kBorderRadius),
                      ),
                    ),
                    focusedPinTheme: PinTheme(
                      width: hw,
                      height: hw,
                      textStyle: TextStyle(
                          fontSize: 20,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600),
                      decoration: BoxDecoration(
                        border: Border.all(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(kBorderRadius),
                      ),
                    ),
                    submittedPinTheme: PinTheme(
                      width: hw,
                      height: hw,
                      textStyle: TextStyle(
                          fontSize: 20,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600),
                      decoration: BoxDecoration(
                        border: Border.all(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(kBorderRadius),
                      ),
                    ),
                    validator: (s) {
                      if (s != null && s.length < 6) {
                        return 'Enter six digit OTP';
                      } else {
                        return null;
                      }
                    },
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    length: 6,
                    onCompleted: (pin) {
                      smsCode = pin;
                      if (smsCode?.length == 6) {
                        verifyCode();
                      }
                      _notify();
                    },
                    onChanged: (value) {
                      smsCode = value;
                      if (smsCode?.length == 6) {
                        verifyCode();
                      }
                      _notify();
                    },
                  ),
                const SizedBox(
                  height: 20,
                ),
                ButtomWidget(
                  text: 'Submit',
                  onTap: () {
                    if (isOptSend &&
                        verificationId != null &&
                        smsCode != null) {
                      verifyCode();
                    } else {
                      validate();
                    }
                  },
                ),
              ],
            ),
          ),
          if (isLoading) const Center(child: CircularProgressIndicator())
        ],
      ),
    );
  }

  validate() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      sendCode();
    }
    _notify();
  }

  Future<void> sendCode() async {
    if (await Network.checkInternet()) {
      _loadingState(true);
      await auth.verifyPhoneNumber(
        phoneNumber: '+91 ${controller.text.trim()}',
        timeout: const Duration(seconds: 45),
        verificationCompleted: (PhoneAuthCredential credential) async {
          log("Credential ${credential.toString()}");
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          log(e.toString());
          _loadingState(false);
        },
        codeSent: (String vId, int? resendToken) async {
          log("verificationId $verificationId");
          log("Resend token ${resendToken.toString()}");
          verificationId = vId;
          if (verificationId != null) {
            isOptSend = true;
            _notify();
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          log("codeAutoRetrievalTimeout verificationId $verificationId");
        },
      );
    } else {
      log('No Internet');
    }
  }

  Future<void> verifyCode() async {
    if (await Network.checkInternet()) {
      _loadingState(true);

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: smsCode!,
      );

      try {
        await auth.signInWithCredential(credential);

        _loadingState(false);
        gotoHomePage();
      } on FirebaseAuthException catch (e) {
        _loadingState(false);
        log(e.toString());
      }
    } else {
      log('No Internet');
    }
  }

  gotoHomePage() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
      (route) => false,
    );
  }
}
