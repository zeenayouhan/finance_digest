import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../services/backend_service.dart';
import '../models/news_item.dart';

class NewsService extends BackendService {
  NewsService({required super.authService});

  Future<List<NewsItem>?> getNewsList() async {
    const apiKey = String.fromEnvironment('API_KEY');
    try {
      final response = await get('/v1/news?category=general&token=$apiKey');

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw Exception(
            'Failed with status code: ${response.statusCode}. Response: ${response.body}');
      }
      // Parse the JSON string
      List<dynamic> jsonList = json.decode(response.body);

      // Convert JSON list to List<NewsItem>
      List<NewsItem> newsItems =
          jsonList.map((json) => NewsItem.fromJson(json)).toList();

      return newsItems;
    } catch (e) {
      debugPrint('Failed to fetch list of news: $e');
      rethrow;
    }
  }
}
