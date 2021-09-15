import 'dart:convert';

import 'package:earthquake/data/remote/resposne.dart';

class Earthquake {
  final String id;
  final double magintude;
  final String place;
  final String offset;
  final int time;
  final String url;
  final String detail;
  final int causeTsunami;
  final double long;
  final double lat;
  final double depth;
  Earthquake({
    required this.id,
    required this.magintude,
    required this.place,
    required this.offset,
    required this.time,
    required this.url,
    required this.detail,
    required this.causeTsunami,
    required this.long,
    required this.lat,
    required this.depth,
  });

  Earthquake copyWith({
    String? id,
    double? magintude,
    String? place,
    String? offset,
    int? time,
    String? url,
    String? detail,
    int? causeTsunami,
    double? long,
    double? lat,
    double? depth,
  }) {
    return Earthquake(
      id: id ?? this.id,
      magintude: magintude ?? this.magintude,
      place: place ?? this.place,
      offset: offset ?? this.offset,
      time: time ?? this.time,
      url: url ?? this.url,
      detail: detail ?? this.detail,
      causeTsunami: causeTsunami ?? this.causeTsunami,
      long: long ?? this.long,
      lat: lat ?? this.lat,
      depth: depth ?? this.depth,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'magintude': magintude,
      'place': place,
      'offset': offset,
      'time': time,
      'url': url,
      'detail': detail,
      'causeTsunami': causeTsunami,
      'long': long,
      'lat': lat,
      'depth': depth,
    };
  }

  factory Earthquake.fromMap(Map<String, dynamic> map) {
    return Earthquake(
      id: map['id'],
      magintude: map['magintude'],
      place: map['place'],
      offset: map['offset'],
      time: map['time'],
      url: map['url'],
      detail: map['detail'],
      causeTsunami: map['causeTsunami'],
      long: map['long'],
      lat: map['lat'],
      depth: map['depth'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Earthquake.fromJson(String source) =>
      Earthquake.fromMap(json.decode(source));
  factory Earthquake.fromDto(EarthquakeDto dto) {
    int index = dto.properties.place.indexOf("of");
    String offset =
        index != -1 ? dto.properties.place.substring(0, index) : "Near";
    String place = index != -1
        ? dto.properties.place.substring(index + 2)
        : dto.properties.place;

    return Earthquake(
        id: dto.id,
        magintude: dto.properties.mag,
        place: place,
        offset: offset,
        time: dto.properties.time,
        url: dto.properties.url,
        detail: dto.properties.detail,
        causeTsunami: dto.properties.tsunami,
        long: dto.coordinates[0],
        lat: dto.coordinates[1],
        depth: dto.coordinates[2]);
  }
  @override
  String toString() {
    return 'Earthquake(magintude: $magintude, place: $place, time: $time, url: $url, detail: $detail, causeTsunami: $causeTsunami, long: $long, lag: $lat, depth: $depth)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Earthquake && id == other.id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
