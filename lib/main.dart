import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sebco_camioniste/viewModel/databaseManager/databaseManager.dart';
import 'package:sebco_camioniste/views/home.dart';

void main() {

  runApp(
    ProviderScope(child: Home())
  );
}
