import 'dart:developer';
import 'package:riverrr/constant/import.dart';

class LocalData {
  static Future<bool> launchURL() async {
    Uri link = Uri.parse(gitString);
    log(link.toString());
    return await launchUrl(link);
  }

  static logOut(BuildContext context) {
    final auth = FirebaseAuth.instance;
    auth.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const SplashPage(),
        ),
        (route) => false);
  }
}
