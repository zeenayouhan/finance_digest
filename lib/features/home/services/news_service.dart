import 'dart:async';
import 'dart:convert';

import '../../../services/backend_service.dart';
import '../models/news_item.dart';

class NewsService extends BackendService {
  NewsService({required super.authService});

  Future<List<NewsItem>?> getNewsList() async {
    const apiKey = String.fromEnvironment('API_KEY');
    try {
      final response =
          await get('/v1/news?category=general&token=$apiKey&minId=10');
      print(response.body);
      if (response.statusCode < 200 || response.statusCode > 399) {
        throw Exception(response.body);
      }
      // Parse the JSON string
      List<dynamic> jsonList = json.decode(response.body);

      // Convert JSON list to List<NewsItem>
      List<NewsItem> newsItems =
          jsonList.map((json) => NewsItem.fromJson(json)).toList();
      print({'dd', newsItems});
      return newsItems;
    } catch (e) {
      print("dddd");
    }
    return null;
  }
}
