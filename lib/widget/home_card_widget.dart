import 'package:riverrr/constant/import.dart';

class HomeCardWidget extends StatelessWidget {
  const HomeCardWidget(
      {super.key,
      this.onTap,
      required this.name,
      required this.url,
      required this.phone,
      required this.email,
      required this.address,
      required this.state,
      required this.city,
      required this.zip,
      required this.bod});
  final VoidCallback? onTap;
  final String name;
  final String? url;
  final String phone;
  final String email;
  final String address;
  final String state;
  final String city;
  final String zip;
  final String bod;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey[300],
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFBEBEBE),
              offset: Offset(10, 10),
              blurRadius: 5,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-10, -10),
              blurRadius: 20,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (url != null && url != '')
                  Container(
                    height: hw,
                    width: hw,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          url ?? "",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name),
                      Text(phone),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (email != '')
                        TextWidget(
                          label: "Email : ",
                          value: email,
                        ),
                      if (phone != '')
                        TextWidget(
                          label: "Phone : ",
                          value: phone,
                        ),
                      if (bod != '')
                        TextWidget(
                          label: "Birthdate : ",
                          value: bod,
                        ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (address != '')
                        TextWidget(
                          label: "Address : ",
                          value: address,
                        ),
                      if (state != '')
                        TextWidget(
                          label: "State : ",
                          value: state,
                        ),
                      if (city != '')
                        TextWidget(
                          label: "City : ",
                          value: city,
                        ),
                      if (zip != '')
                        TextWidget(
                          label: "ZipCode : ",
                          value: zip,
                        ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({super.key, required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          )
        ],
      ),
    );
  }
}
