import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math' as math;

import 'neu_circle.dart';
class PrayerTime extends StatefulWidget {
  const PrayerTime({super.key});

  @override
  State<PrayerTime> createState() => _PrayerTimeState();
}

class _PrayerTimeState extends State<PrayerTime> {
  bool _hasPermissions = false;
  double? _qiblaDirection;

  @override
  void initState() {
    super.initState();
    _fetchPermissionStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[600],
      body: _hasPermissions ? _buildCompass() : _buildPermissionSheet(),
    );
  }

  Widget _buildCompass() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error reading heading: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        double? direction = snapshot.data?.heading;
        if (direction == null || _qiblaDirection == null) {
          return const Center(
            child: Text("Device does not have sensors or location not available!"),
          );
        }

        // Calculate the angle to Qibla
        double qiblaAngle = _qiblaDirection! - direction;

        return Center(
          child: NeuCircle(
            child: AnimatedRotation(
              turns: qiblaAngle / 360,
              duration: const Duration(milliseconds: 300),
              child: Image.asset(
                'assets/app/images/compass.png',
                color: Colors.white,
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPermissionSheet() {
    return Center(
      child: ElevatedButton(
        child: const Text('Request Permissions'),
        onPressed: () {
          Permission.locationWhenInUse.request().then((status) {
            _fetchPermissionStatus();
          });
        },
      ),
    );
  }

  void _fetchPermissionStatus() async {
    var status = await Permission.locationWhenInUse.status;
    if (status.isGranted) {
      setState(() => _hasPermissions = true);
      _getUserLocation();
    } else {
      setState(() => _hasPermissions = false);
    }
  }

  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Calculate Qibla direction
    double latitude = position.latitude;
    double longitude = position.longitude;
    _calculateQiblaDirection(latitude, longitude);
  }

  void _calculateQiblaDirection(double latitude, double longitude) {
    const double kaabaLatitude = 21.4225;
    const double kaabaLongitude = 39.8262;

    double deltaLongitude = (kaabaLongitude - longitude).toRad();
    double lat1 = latitude.toRad();
    double lat2 = kaabaLatitude.toRad();

    double y = math.sin(deltaLongitude) * math.cos(lat2);
    double x = math.cos(lat1) * math.sin(lat2) -
        math.sin(lat1) * math.cos(lat2) * math.cos(deltaLongitude);
    double bearing = math.atan2(y, x).toDegrees();

    if (bearing < 0) {
      bearing += 360;
    }

    setState(() {
      _qiblaDirection = bearing;
    });
  }
}
extension on double {
  double toRad() => this * (math.pi / 180.0);
  double toDegrees() => this * (180.0 / math.pi);
}