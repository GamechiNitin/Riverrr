import 'package:riverrr/constant/import.dart';

class Pictures {
  Future<File?> getPicture(
      {required ImageSource source, required BuildContext context}) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      String imagePath = pickedFile.path;
      File? image = File(imagePath);
      return image;
    } else {
      return null;
    }
  }
}
