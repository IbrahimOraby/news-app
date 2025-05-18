class NewsResponseModel {
  final String status;
  final int totalResults;
  final List<NewsModel> news;

  NewsResponseModel({
    required this.status,
    required this.totalResults,
    required this.news,
  });

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) {
    return NewsResponseModel(
      status: json['status'] ?? '',
      totalResults: json['totalResults'],
      news:
          (json['articles'] as List)
              .map((element) => NewsModel.fromJson(element))
              .toList(),
    );
  }
}

class NewsModel {
  final String? author;
  final String? title;
  final String? description;
  final String? urlToImage;
  final String? content;
  final String? publishedAt;

  NewsModel({
    this.author,
    this.title,
    this.description,
    this.urlToImage,
    this.content,
    this.publishedAt,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      author: json['author'],
      title: json['title'],
      description: json['description'],
      urlToImage: json['urlToImage'],
      content: json['content'],
      publishedAt: json['publishedAt'],
    );
  }
}
