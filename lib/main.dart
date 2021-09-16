import 'package:earthquake/screens/details_screen.dart';
import 'package:earthquake/service_locator.dart' as ServiceLocator;
import 'package:flutter/material.dart';

import 'screens/main_screen.dart';

void main() {
  ServiceLocator.setup();
  runApp(EarthquakeApp());
}

class EarthquakeApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Earthquake',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: MainScreen.ROUTE_ID,
      routes: {
        MainScreen.ROUTE_ID: (context) => MainScreen(),
        DetailsScreen.ROUTE_ID: (context) => DetailsScreen(),
      },
    );
  }
}
