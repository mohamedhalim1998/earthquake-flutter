import 'package:earthquake/data/domain/earthquake.dart';
import 'package:earthquake/data/remote/network_source.dart';
import 'package:earthquake/data/remote/resposne.dart';

class Repository {
  final NetworkHelper _networkHelper;

  Repository(this._networkHelper);

  Future<List<Earthquake>> getEarthquakes({int offset = 1}) async {
    Response response = await _networkHelper.getEarthquakes(offset: offset);
    return List.generate(response.earthquakes.length,
        (index) => Earthquake.fromDto(response.earthquakes[index]));
  }
}
