import 'package:earthquake/data/remote/resposne.dart';
import 'package:earthquake/util/const.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  Future<Response> getEarthquakes({int offset = 1}) async {
    dynamic json =
        await http.get(Uri.parse("$API_BASE_URL&limit=$PAGE_SIZE&offset=$offset")).timeout(Duration(seconds: 5));
    return Response.fromJson(json.body);
  }
}
