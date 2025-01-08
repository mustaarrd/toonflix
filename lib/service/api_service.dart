import 'dart:convert';
import 'package:toonflix/model/Webtoon.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String today = "today";

  ApiService();

  Future<List<WebtoonModel>> getTodaysToons() async {
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<WebtoonModel> webtoonInfo = [];
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        WebtoonModel.fromJson(webtoon);
        //webtoonInfo.add(model);
      }
      return webtoonInfo;
    }
    throw Error();
  }
}
