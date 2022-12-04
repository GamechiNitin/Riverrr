import 'package:permission_handler/permission_handler.dart';
import 'package:riverrr/constant/import.dart';

class DevicePermission {
  static checkPermissionStatus({
    required void Function() onSucess,
    required Permission permission,
  }) async {
    PermissionStatus permissionStatus = await permission.status;
    switch (permissionStatus) {
      case PermissionStatus.granted:
        onSucess();
        break;

      case PermissionStatus.denied:
        await permission.request().then((value) {
          if (value == PermissionStatus.granted) {
            onSucess();
          }
        });
        break;

      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;

      case PermissionStatus.limited:
        await permission.request().then((value) {
          if (value == PermissionStatus.granted) {
            onSucess();
          }
        });
        break;

      case PermissionStatus.restricted:
        openAppSettings();
        break;

      default:
        openAppSettings();
    }
  }

}
