import 'dart:convert';

class Response {
  final List<EarthquakeDto> earthquakes;
  Response({
    required this.earthquakes,
  });

  Map<String, dynamic> toMap() {
    return {
      'earthquakes': earthquakes.map((x) => x.toMap()).toList(),
    };
  }

  factory Response.fromMap(Map<String, dynamic> map) {
    return Response(
      earthquakes: List<EarthquakeDto>.from(
          map['features']?.map((x) => EarthquakeDto.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Response.fromJson(String source) =>
      Response.fromMap(json.decode(source));
}

class EarthquakeDto {
  final EarthquakeProperties properties;
  final List<double> coordinates;
  final String id;
  EarthquakeDto({
    required this.properties,
    required this.coordinates,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'properties': properties.toMap(),
      'coordinates': coordinates,
      'id': id,
    };
  }

  factory EarthquakeDto.fromMap(Map<String, dynamic> map) {
    return EarthquakeDto(
        properties: EarthquakeProperties.fromMap(map['properties']),
        coordinates: List.generate(
            3, (index) => map['geometry']['coordinates'][index].toDouble()),
        id: map['id']);
  }

  String toJson() => json.encode(toMap());

  factory EarthquakeDto.fromJson(String source) =>
      EarthquakeDto.fromMap(json.decode(source));

  @override
  String toString() =>
      'EarthquakeDto(id: $id, properties: $properties, coordinates: $coordinates)';
}

class EarthquakeProperties {
  final double mag;
  final String place;
  final int time;
  final String url;
  final String detail;
  final int tsunami;

  EarthquakeProperties(
      this.mag, this.place, this.time, this.url, this.detail, this.tsunami);

  Map<String, dynamic> toMap() {
    return {
      'mag': mag,
      'place': place,
      'time': time,
      'url': url,
      'detail': detail,
      'tsunami': tsunami,
    };
  }

  factory EarthquakeProperties.fromMap(Map<String, dynamic> map) {
    return EarthquakeProperties(
      map['mag'].toDouble(),
      map['place'],
      map['time'],
      map['url'],
      map['detail'],
      map['tsunami'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EarthquakeProperties.fromJson(String source) =>
      EarthquakeProperties.fromMap(json.decode(source));
}
