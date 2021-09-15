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
  final StreamController<bool> _loadingStreamController =
      new StreamController();
  Stream<List<Earthquake>> get earthquakes =>
      _earthquakeStreamController.stream;
  Stream<bool> get loading => _loadingStreamController.stream;
  EarthquakeBloc(this._repository) {
    loadMore();
  }

  Future<void> loadMore() async {
    if (!_loading) {
      _loading = true;
      _loadingStreamController.sink.add(_loading);
      _earthquakes.addAll(await _repository.getEarthquakes(offset: _offset));
      _earthquakeStreamController.sink.add(_earthquakes);
      _offset += PAGE_SIZE;
      _loading = false;
      _loadingStreamController.sink.add(_loading);
    }
    print("offset: $_offset");
  }

  void dispose() {
    _earthquakeStreamController.close();
    _loadingStreamController.close();
  }
}
