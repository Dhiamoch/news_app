import 'package:flutter/material.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/services/news_service.dart';

class NewsProvider with ChangeNotifier {
  List<Articles> _news = [];
  List<Articles> get news => _news;

  set news(List<Articles> news) {
    _news = news;
    notifyListeners();
  }

  Future<void> getNews() async {
    try {
      List<Articles> news = await NewsService().getNews();
      _news = news;
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }
}
