import 'package:earthquake/bloc/earthquake_bloc.dart';
import 'package:earthquake/data/local/db_helper.dart';
import 'package:earthquake/data/remote/network_source.dart';
import 'package:earthquake/data/repository.dart';
import 'package:get_it/get_it.dart';

// ambient variable to access the service locator
GetIt getit = GetIt.instance;

void setup() {
  Repository repository = Repository(NetworkHelper(), DatabaseHelper.instance);
  getit.registerSingleton<EarthquakeBloc>(EarthquakeBloc(repository));
}
