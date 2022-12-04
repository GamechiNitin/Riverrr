import 'package:riverrr/constant/import.dart';

class TextFeildWidget extends StatelessWidget {
  const TextFeildWidget(
      {super.key,
      required this.controller,
      required this.focusNode,
      required this.hint,
      this.onFieldSubmitted,
      this.validator,
      this.onChanged,
      this.keyboardType,
      this.prefixIcon,
      this.suffixWidget,
      this.enabled,
      this.maxLength});
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hint;

  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;

  final IconData? prefixIcon;
  final Widget? suffixWidget;
  final bool? enabled;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              autofocus: false,
              enabled: enabled,
              controller: controller,
              focusNode: focusNode,
              keyboardType: keyboardType,
              validator: validator,
              onChanged: onChanged,
              maxLength: maxLength,
              onFieldSubmitted: onFieldSubmitted,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                suffixIcon: suffixWidget,
                prefixIcon: Container(
                  width: hw,
                  height: hw,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kBorderRadius),
                      bottomLeft: Radius.circular(kBorderRadius),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    prefixIcon,
                    color: kwhiteColor,
                  ),
                ),
                hintText: hint,
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
                    color: kPrimaryColor,
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
        ],
      ),
    );
  }
}
