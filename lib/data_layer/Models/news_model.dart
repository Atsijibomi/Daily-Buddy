class NewsItem {
  final String title;
  final String snippet;
  final String publisher;
  final String timestamp; // Unix timestamp
  final String newsUrl;
  final Map<String, String> images;

  NewsItem({
    required this.title,
    required this.snippet,
    required this.publisher,
    required this.timestamp,
    required this.newsUrl,
    required this.images,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    // Extract images as a map from the "images" key
    final Map<String, String> imagesMap = json['images'] != null
        ? {
            'thumbnail': json['images']['thumbnail'] ?? '',
            'thumbnailProxied': json['images']['thumbnailProxied'] ?? '',
          }
        : {}; // Fallback to an empty map if "images" is not present

    return NewsItem(
      title: json['title'] ?? '',
      snippet: json['snippet'] ?? '',
      publisher: json['publisher'] ?? '',
      timestamp: json['timestamp'] ?? 0, // Default to 0 if not available
      newsUrl: json['newsUrl'] ?? '',
      images: imagesMap,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'snippet': snippet,
      'publisher': publisher,
      'timestamp': timestamp,
      'newsUrl': newsUrl,
      'images': images,
    };
  }
}

class NewsList {
  final List<NewsItem> newsItems;

  NewsList({required this.newsItems});

  factory NewsList.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonList = json['items'] ?? [];
    List<NewsItem> newsItems =
        jsonList.map((item) => NewsItem.fromJson(item)).toList();
    return NewsList(newsItems: newsItems);
  }

  Map<String, dynamic> toJson() {
    return {
      'items': newsItems.map((newsItem) => newsItem.toJson()).toList(),
    };
  }
}
