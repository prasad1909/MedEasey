import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as Geo;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewAskeForPermission extends StatefulWidget {
  @override
  _NewAskeForPermissionState createState() => _NewAskeForPermissionState();
}

class _NewAskeForPermissionState extends State<NewAskeForPermission>
    with SingleTickerProviderStateMixin {
  late ServiceStatus _status;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void initState() {
    runFirst();
    super.initState();
  }

  runFirst() async {
    if (!(await Geo.Geolocator.isLocationServiceEnabled())) {
      print('loc off');
      Navigator.pushNamed(context, '/home');
    } else {
      await _requestPerms();
      if (_status == ServiceStatus.enabled) {
        var pos = await Geo.Geolocator.getCurrentPosition();
        print(pos);
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        _prefs.setDouble('latitude', pos.latitude);
        _prefs.setDouble('longitude', pos.longitude);

        Navigator.pushNamed(context, '/home');
      } else if (_status == ServiceStatus.disabled) {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      }
    }
  }

  Future _requestPerms() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.locationWhenInUse,
      Permission.locationAlways,
    ].request();

    ServiceStatus status = await Permission.locationWhenInUse.serviceStatus;
    _updateStatus(status);
  }

  void _updateStatus(ServiceStatus value) async {
    setState(() {
      _status = value;
    });
  }
}
