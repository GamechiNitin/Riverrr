import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:riverrr/constant/import.dart';

class ApiServices {
  CollectionReference users = FirebaseFirestore.instance.collection('people');

  Future<String> addUser({required UserResponse userModel, File? file}) async {
    if (file != null) {
      try {
        final name = basename(file.path);
        var path = 'files/$name';
        final ref = FirebaseStorage.instance.ref().child(path);
        UploadTask? upload = ref.putFile(file);
        final snapshot = await upload.whenComplete(() {});
        String url = await snapshot.ref.getDownloadURL();
        if (url != '') {
          return users.add({
            'url': url,
            'name': userModel.name,
            'email': userModel.email,
            'address': userModel.address,
            'birthDate': userModel.birthDate,
            'zip': userModel.zip,
            'city': userModel.city,
            'state': userModel.state,
            'phone': userModel.phone,
          }).then((value) {
            return "People Added Successfully";
          }).catchError(
            (error) {
              log(error.toString());

              return "Failed to add user: $error";
            },
          );
        } else {
          return 'Failed to add image';
        }
      } catch (e) {
        return e.toString();
      }
    } else {
      return users.add({
        'name': userModel.name,
        'email': userModel.email,
        'address': userModel.address,
        'birthDate': userModel.birthDate,
        'zip': userModel.zip,
        'city': userModel.city,
        'state': userModel.state,
        'phone': userModel.phone,
      }).then((value) {
        return "People Added Successfully";
      }).catchError(
        (error) {
          log(error.toString());
          return "Failed to add user: $error";
        },
      );
    }
  }

  Future<String> deleteUser(String id) {
    return users.doc(id).delete().then((value) {
      return "User Deleted Successfully";
    }).catchError(
      (error) {
        return "Failed to delete user: $error";
      },
    );
  }

  Future<String> updateUser({
    required String id,
    required UserResponse userModel,
    File? file,
  }) async {
    if (file != null) {
      try {
        final name = basename(file.path);
        var path = 'files/$name';
        final ref = FirebaseStorage.instance.ref().child(path);
        UploadTask? upload = ref.putFile(file);
        final snapshot = await upload.whenComplete(() {});
        String url = await snapshot.ref.getDownloadURL();
        if (url != '') {
          return users.doc(id).update({
            'url': url,
            'name': userModel.name,
            'email': userModel.email,
            'address': userModel.address,
            'birthDate': userModel.birthDate,
            'zip': userModel.zip,
            'city': userModel.city,
            'state': userModel.state,
            'phone': userModel.phone,
          }).then((value) {
            return "People Updated Successfully";
          }).catchError(
            (error) {
              log(error.toString());

              return "Failed to update user: $error";
            },
          );
        } else {
          return 'Failed to add image';
        }
      } catch (e) {
        return e.toString();
      }
    } else {
      return users.doc(id).update(userModel.toJson()).then((value) {
        return "People Added Successfully";
      }).catchError(
        (error) {
          log(error.toString());
          return "Failed to add user: $error";
        },
      );
    }
  }
}
