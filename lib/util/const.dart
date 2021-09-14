import 'package:flutter/material.dart';

const String API_BASE_URL =
    "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson";
const int PAGE_SIZE = 20;

const magnitudeColors = [
  Color(0xFF4A7BA7),
  Color(0xFF04B4B3),
  Color(0xFF10CAC9),
  Color(0xFFF5A623),
  Color(0xFFFF7D50),
  Color(0xFFFC6644),
  Color(0xFFE75F40),
  Color(0xFFE13A20),
  Color(0xFFD93218),
  Color(0xFFC03823)
];
