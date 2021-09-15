import 'package:earthquake/data/domain/earthquake.dart';
import 'package:earthquake/data/local/db_helper.dart';
import 'package:earthquake/data/remote/network_source.dart';
import 'package:earthquake/data/remote/resposne.dart';

class Repository {
  final NetworkHelper _networkHelper;
  final DatabaseHelper _databaseHelper;
  Repository(this._networkHelper, this._databaseHelper);

  Future<List<Earthquake>> getEarthquakes({int offset = 1}) async {
    try {
      Response response = await _networkHelper.getEarthquakes(offset: offset);
      List<Earthquake> list = List.generate(response.earthquakes.length,
          (index) => Earthquake.fromDto(response.earthquakes[index]));
      list.forEach((element) {
        _databaseHelper.insert(element);
      });
      return list;
    } catch (e) {
      final list = (await _databaseHelper.getAll());
      return List.generate(list.length, (index) => Earthquake.fromMap(list[index]));
    }
  }
}
