import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:iti_day3_session/data/models/news_models.dart';

class NewsRepo {
  Dio dio = Dio();

  Future<NewsResponseModel?> getNews() async {
    try {
      var response = await dio.get(
        'https://newsapi.org/v2/everything?domains=wsj.com&apiKey=ec3d10d85ae0499983c2b2b2e91b0f78',
      );
      if (response.statusCode! > 299) {
        return null;
      } else {
        NewsResponseModel newsResponseModel = NewsResponseModel.fromJson(
          response.data,
        );
        return newsResponseModel;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
