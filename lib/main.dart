import 'package:flutter/material.dart';
import 'app.dart';
import 'core/services/di.dart';

void main() async {
  await _init();
  runApp(const MyApp());
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  return initializeDependencies();
}
