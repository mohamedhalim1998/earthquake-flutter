import 'dart:convert';

import 'package:earthquake/data/remote/resposne.dart';

class Earthquake {
  final double magintude;
  final String place;
  final String offset;
  final int time;
  final String url;
  final String detail;
  final bool causeTsunami;
  final double long;
  final double lag;
  final double depth;
  Earthquake({
    required this.magintude,
    required this.place,
    required this.offset,
    required this.time,
    required this.url,
    required this.detail,
    required this.causeTsunami,
    required this.long,
    required this.lag,
    required this.depth,
  });

  Earthquake copyWith({
    double? magintude,
    String? place,
    String? offset,
    int? time,
    String? url,
    String? detail,
    bool? causeTsunami,
    double? long,
    double? lag,
    double? depth,
  }) {
    return Earthquake(
      magintude: magintude ?? this.magintude,
      place: place ?? this.place,
      offset: offset ?? this.offset,
      time: time ?? this.time,
      url: url ?? this.url,
      detail: detail ?? this.detail,
      causeTsunami: causeTsunami ?? this.causeTsunami,
      long: long ?? this.long,
      lag: lag ?? this.lag,
      depth: depth ?? this.depth,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'magintude': magintude,
      'place': place,
      'offset': offset,
      'time': time,
      'url': url,
      'detail': detail,
      'causeTsunami': causeTsunami,
      'long': long,
      'lag': lag,
      'depth': depth,
    };
  }

  factory Earthquake.fromMap(Map<String, dynamic> map) {
    return Earthquake(
      magintude: map['magintude'],
      place: map['place'],
      offset: map['offset'],
      time: map['time'],
      url: map['url'],
      detail: map['detail'],
      causeTsunami: map['causeTsunami'],
      long: map['long'],
      lag: map['lag'],
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
        magintude: dto.properties.mag,
        place: place,
        offset: offset,
        time: dto.properties.time,
        url: dto.properties.url,
        detail: dto.properties.detail,
        causeTsunami: dto.properties.tsunami == 1,
        long: dto.coordinates[0],
        lag: dto.coordinates[1],
        depth: dto.coordinates[2]);
  }
  @override
  String toString() {
    return 'Earthquake(magintude: $magintude, place: $place, time: $time, url: $url, detail: $detail, causeTsunami: $causeTsunami, long: $long, lag: $lag, depth: $depth)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Earthquake &&
        other.magintude == magintude &&
        other.place == place &&
        other.time == time &&
        other.url == url &&
        other.detail == detail &&
        other.causeTsunami == causeTsunami &&
        other.long == long &&
        other.lag == lag &&
        other.depth == depth;
  }

  @override
  int get hashCode {
    return magintude.hashCode ^
        place.hashCode ^
        time.hashCode ^
        url.hashCode ^
        detail.hashCode ^
        causeTsunami.hashCode ^
        long.hashCode ^
        lag.hashCode ^
        depth.hashCode;
  }
}
