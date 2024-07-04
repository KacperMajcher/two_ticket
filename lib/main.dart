import 'package:flutter/material.dart';
import 'package:two_ticket/core/app.dart';
import 'package:two_ticket/core/constants/dependencies/injection_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(
    const App(),
  );
}
