import 'dart:convert';

import 'package:news_app/model/news_model.dart';
import 'package:http/http.dart' as http;

class NewsService {
  Future<List<Articles>> getNews() async {
    final response = await http.get(
        Uri.parse(
            "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=72c27103ca4c43e38ed3b42a48842cd9"),
        headers: {"Connection": "Keep-Alive"});

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)["articles"];
      List<Articles> news = [];

      for (var item in data) {
        news.add(Articles.fromJson(item));
      }

      return news;
    } else {
      throw Exception("Gagal get province");
    }
  }
}
