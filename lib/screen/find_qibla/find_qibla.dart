import 'dart:math';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:quran_first/controller/quran_provider.dart';
import 'package:quran_first/screen/common_widgets/custom_button.dart';
import '../../core/values/colors.dart';
import '../../core/values/strings.dart';
import '../common_widgets/custom_textstyle.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as loc;

class FindQibla extends StatefulWidget {
  const FindQibla({super.key});

  @override
  State<FindQibla> createState() => _FindQiblaState();
}

class _FindQiblaState extends State<FindQibla> {
  Future<Position>? getPosition;

  @override
  void initState() {
    super.initState();
    getPosition = _determinePosition();
    print(getPosition);
  }

  Future<void> _showLocationDeniedDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Permission Required'),
          content: Text(
            'This app requires location access to find the Qibla direction. Please enable location services or grant permission.',
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Open Settings'),
              onPressed: () async {
                await openAppSettings();
              },
            ),
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showLocationDeniedDialog();
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showLocationDeniedDialog();
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position? position;
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    context.read<QuranProvider>().fetchCurrentLocation(
        longitude: position.longitude, latitude: position.latitude);

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: AppColors.white,
          ),
        ),
        title: Text(
          'Find Qibla',
          style: CustomFontStyle().common(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, Color(0xFF07170D)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: FutureBuilder<Position>(
            future: getPosition,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageStrings.locationOff,
                        width: 155.w,
                        height: 155.w,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Turn on phone location to get accurate Qibla directions.',
                        textAlign: TextAlign.center,
                        style: CustomFontStyle().common(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60.0.w),
                        child: CustomButton(
                          bgColor: AppColors.orange,
                          borderColor: AppColors.orange,
                          text: 'Enable Location',
                          onPress: () async {
                            loc.Location locationR = loc.Location();
                            if (!await locationR.serviceEnabled()) {
                              bool serviceEnabled =
                                  await locationR.requestService();
                              if (!serviceEnabled) {
                                return;
                              }
                            }

                            setState(() {
                              getPosition =
                                  _determinePosition(); // This remains a Future
                            });
                          },
                        ),
                      )
                    ],
                  ),
                );
              }
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }
              Position positionResult = snapshot.data!;
              Coordinates coordinates = Coordinates(
                positionResult.latitude,
                positionResult.longitude,
              );
              double qiblaDirection = Qibla.qibla(coordinates);
              return StreamBuilder(
                stream: FlutterCompass.events,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error reading heading: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    );
                  }

                  double? direction = snapshot.data!.heading;
                  if (direction == null) {
                    return Center(
                      child: Text("Device does not have sensors!"),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Consumer<QuranProvider>(
                            builder: (context, location, _) {
                          return Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Current Location',
                                  style: CustomFontStyle().common(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                              Text(
                                '${location.currentLocations?.first.subAdministrativeArea == '' ? location.currentLocations?.first.locality ?? '' : location.currentLocations?.first.subAdministrativeArea ?? ''}, ${location.currentLocations?.first.administrativeArea ?? ''}',
                                style: CustomFontStyle().common(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                ),
                              )
                            ],
                          );
                        }),
                        FutureBuilder<Position>(
                          future: getPosition,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              Position positionResult = snapshot.data!;
                              Coordinates coordinates = Coordinates(
                                positionResult.latitude,
                                positionResult.longitude,
                              );
                              double qiblaDirection = Qibla.qibla(
                                coordinates,
                              );
                              return StreamBuilder(
                                stream: FlutterCompass.events,
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text(
                                        'Error reading heading: ${snapshot.error}');
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.red,
                                      ),
                                    );
                                  }

                                  double? direction = snapshot.data!.heading;

                                  if (direction == null) {
                                    return const Center(
                                      child: Text(
                                          "Device does not have sensors !"),
                                    );
                                  }
                                  return Column(
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Color(0xFFFFF7EC),
                                            foregroundColor: Color(0xFFFFF7EC),
                                            radius: 170.r,
                                          ),
                                          Transform.rotate(
                                            angle: -2 * pi * (direction / 360),
                                            child: Transform(
                                              alignment:
                                                  FractionalOffset.center,
                                              transform: Matrix4.rotationZ(
                                                  qiblaDirection * pi / 180),
                                              origin: Offset.zero,
                                              child: DottedBorder(
                                                  borderType: BorderType.Circle,
                                                  dashPattern: const [10, 25],
                                                  color: AppColors.orange,
                                                  child: Container(
                                                    height: 290.w,
                                                    width: 290.w,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                  )),
                                            ),
                                          ),
                                          CircleAvatar(
                                            backgroundColor: AppColors.orange
                                                .withOpacity(0.1),
                                            foregroundColor: Colors.grey,
                                            radius: 130.r,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Transform.rotate(
                                                  angle: -2 *
                                                      pi *
                                                      (direction / 360),
                                                  child: Transform(
                                                    alignment:
                                                        FractionalOffset.center,
                                                    transform:
                                                        Matrix4.rotationZ(
                                                            qiblaDirection *
                                                                pi /
                                                                180),
                                                    origin: Offset.zero,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Image.asset(
                                                          'assets/app/images/kaaba2.png',
                                                          width: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Transform.rotate(
                                                    angle: 90 * pi,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 60.0.h),
                                                      child: Image.asset(
                                                        'assets/app/images/needile.png',
                                                        height: 90.h,
                                                        width: 30,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 100,
                          width: ScreenUtil().screenWidth / 1.2,
                          child: Text(
                            'Rotate your phone until the arrow faces the Kaabah icon.',
                            textAlign: TextAlign.center,
                            style: CustomFontStyle().common(
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
