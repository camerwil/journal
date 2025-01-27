import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';

const String title = 'Journal';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp
  ]);
  runApp(
    App(title: title),
  );
}
