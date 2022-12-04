import 'package:riverrr/model/user_model.dart';

class ContactListResponse {
  final List<UserResponse> data;

  ContactListResponse(this.data);

  factory ContactListResponse.fromJson(List<dynamic> parsedJson) {
    List<UserResponse> content = [];
    content = parsedJson.map((i) => UserResponse.fromJson(i)).toList();

    return ContactListResponse(content);
  }
}
