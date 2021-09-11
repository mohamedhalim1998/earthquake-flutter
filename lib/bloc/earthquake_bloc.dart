import 'dart:async';

import 'package:earthquake/data/domain/earthquake.dart';
import 'package:earthquake/data/repository.dart';

class EarthquakeBloc {
  final List<Earthquake> _earthquakes = [];
  final Repository _repository;
  final int _offset = 1;
  final StreamController<List<Earthquake>> _earthquakeStreamController =
      new StreamController();
  Stream<List<Earthquake>> get earthquakes =>
      _earthquakeStreamController.stream;
  EarthquakeBloc(this._repository) {
    loadMore();
  }

  void loadMore() async {
    _earthquakes.addAll(await _repository.getEarthquakes(offset: _offset));
    _earthquakeStreamController.sink.add(_earthquakes);
  }

  void dispose() {
    _earthquakeStreamController.close();
  }
}
