import 'dart:math';

import 'package:earthquake/data/domain/earthquake.dart';
import 'package:earthquake/util/const.dart';
import 'package:flutter/material.dart';

class EarthquakeCard extends StatelessWidget {
  final Earthquake earthquake;
  const EarthquakeCard({
    Key? key,
    required this.earthquake,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getMagColor(earthquake.magintude)),
            child: Center(
              child: Text(earthquake.magintude.toStringAsFixed(2)),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                earthquake.offset,
                style: TextStyle(fontSize: 12.0),
              ),
              Text(earthquake.place, ),
            ],
          ),
        ),
      ),
    );
  }

  Color getMagColor(double magintude) {
    int mag = max(0, magintude.floor());
    return magnitudeColors[min(mag, 9)];
  }
}
