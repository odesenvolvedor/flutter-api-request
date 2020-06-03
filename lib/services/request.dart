import 'package:dio/dio.dart';

class Request {
  final Dio dio = Dio();
  final String baseUrl = "http://www.omdbapi.com";
  final String apikey = "79f89ac3";

  buscar({String id, String title, int season}) async {
    String url = "$baseUrl/?apikey=$apikey";
    if (id != null) url += "&i=$id";
    if (title != null) url += "&t=$title";
    if (season != null) url += "&Season=$season";

    Response response = await dio.get(url);

    return response.data;
  }
}