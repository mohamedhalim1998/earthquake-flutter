import 'dart:async';

import 'package:earthquake/data/domain/earthquake.dart';
import 'package:earthquake/data/repository.dart';
import 'package:earthquake/util/const.dart';

class EarthquakeBloc {
  final List<Earthquake> _earthquakes = [];
  final Repository _repository;
  int _offset = 1;
  bool _loading = false;
  final StreamController<List<Earthquake>> _earthquakeStreamController =
      new StreamController();
  Stream<List<Earthquake>> get earthquakes =>
      _earthquakeStreamController.stream;
  EarthquakeBloc(this._repository) {
    loadMore();
  }

  Future<void> loadMore() async {
    if (!_loading) {
      _loading = true;
      _earthquakes.addAll(await _repository.getEarthquakes(offset: _offset));
      _earthquakeStreamController.sink.add(_earthquakes);
      _offset += PAGE_SIZE;
      _loading = false;
    }
    print("offset: $_offset");
  }

  void dispose() {
    _earthquakeStreamController.close();
  }
}
