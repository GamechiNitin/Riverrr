import 'dart:async';
import 'dart:developer';
import 'package:riverrr/constant/import.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  
  @override
  void initState() {
    splashTimer();
    super.initState();
  }

  Future<void> splashTimer() async {
    Timer(const Duration(seconds: 1), checkUser);
  }

  Future<void> checkUser() async {
    auth.authStateChanges().listen((user) {
      getUser(user);
    });
  }

  Future<void> getUser(User? user) async {
    if (user != null) {
      log("User : ${user.uid}");
      gotoHomePage();
    } else {
      gotoLogInPage();
    }
  }

  gotoLogInPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LogInPage(),
      ),
    );
  }

  gotoHomePage() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
      (route) => false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RichText(
          text: TextSpan(
            text: 'Flutter',
            style: TextStyle(
              color: kBlack,
              fontSize: 25,
            ),
            children: [
              TextSpan(
                text: '.Dev',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
