import 'package:earthquake/bloc/earthquake_bloc.dart';
import 'package:earthquake/data/domain/earthquake.dart';
import 'package:earthquake/service_locator.dart';
import 'package:earthquake/widgets/earthquake_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

class DetailsScreen extends StatelessWidget {
  static const String ROUTE_ID = "details-screen-path";

  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    getit<EarthquakeBloc>().getEarthquake(args);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: StreamBuilder<Earthquake>(
            stream: getit<EarthquakeBloc>().earthquakeDetails,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Earthquake earthquake = snapshot.data!;
                return Card(
                  elevation: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      EarthquakeCard(earthquake: earthquake),
                      ListTile(
                        leading: Icon(
                          Icons.pin_drop,
                          size: 30,
                        ),
                        title: Text(earthquake.lat.toStringAsFixed(3) +
                            ", " +
                            earthquake.long.toStringAsFixed(3)),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.timer,
                          size: 30,
                        ),
                        title: Text(getFormattedDate(earthquake.time)),
                      ),
                      ListTile(
                        leading: Icon(
                          WeatherIcons.tsunami,
                          size: 30,
                        ),
                        title: Text(earthquake.causeTsunami == 1 ? "Yes" : "No"),
                      )
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  String getFormattedDate(int time) {
    DateTime toFormat = DateTime.fromMillisecondsSinceEpoch(time);
    int diff = DateTime.now().millisecondsSinceEpoch - time;
    if (Duration(milliseconds: diff).inDays < 1)
      return DateFormat.jms().format(toFormat);
    return DateFormat.yMMMd('en_US').format(toFormat);
  }
}
