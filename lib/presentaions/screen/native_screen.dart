import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NaticeScreen extends StatefulWidget {
  const NaticeScreen({Key? key}) : super(key: key);

  @override
  State<NaticeScreen> createState() => _NaticeScreenState();
}

class _NaticeScreenState extends State<NaticeScreen> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  String batteryLevel = 'Unknown battery level.';

  Future<void> getBatteryLevel() async {
    platform.invokeMethod('getBatteryLevel').then((value) {
      setState(() {
        batteryLevel = 'Battery level at $value % .';
      });
    }).catchError((e) {
      setState(() {
        batteryLevel = "Failed to get battery level: '${e.message}'.";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: const Text('Get Battery Level'),
              onPressed: getBatteryLevel,
            ),
            Text(batteryLevel),
          ],
        ),
      ),
    );
  }
}
