import 'package:riverrr/constant/import.dart';

class ButtomWidget extends StatelessWidget {
  const ButtomWidget({super.key, required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: 50,
        height: 50,
        margin: const EdgeInsets.only(right: 20, top: 20, left: 20, bottom: 30),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
