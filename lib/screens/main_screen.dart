import 'package:earthquake/bloc/earthquake_bloc.dart';
import 'package:earthquake/data/domain/earthquake.dart';
import 'package:earthquake/service_locator.dart';
import 'package:earthquake/widgets/earthquake_card.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  static const String ROUTE_ID = "main-screen-path";

  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Earthquake>>(
        stream: getit<EarthquakeBloc>().earthquakes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Earthquake> earthquakes = snapshot.data!;
            return ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) =>
                    EarthquakeCard(earthquake: earthquakes[index]));
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
