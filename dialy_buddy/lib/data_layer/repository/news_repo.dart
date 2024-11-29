import 'package:dialy_buddy/data_layer/Models/news_model.dart';
import 'package:dialy_buddy/utils/dio_client.dart';
import 'package:dialy_buddy/utils/service_locator.dart';
import 'package:dio/dio.dart';

abstract class NewsRepository {
  Future<NewsList> fetchNews();
}

class NewsRepositoryImpl implements NewsRepository {
  @override
  Future<NewsList> fetchNews() async {
    try {
      print('Fetching news...');
      final response = await sl<DioClient>().get(
        'https://google-news13.p.rapidapi.com/entertainment?lr=en-US',
        options: Options(
          headers: {
            'x-rapidapi-key':
                'e9e30b436bmsh5f69dd7dc299852p1c419djsnc30802de0c56',
            'x-rapidapi-host': 'google-news13.p.rapidapi.com',
          },
        ),
      );

      if (response.statusCode == 403) {
        throw Exception(
            'Access forbidden: Invalid API key or insufficient permissions');
      }

      print(response.data);
      final data = response.data;
      if (data['status'] == 'success') {
        final newsList = NewsList.fromJson(data);
        print('Fetched ${newsList.newsItems.length} news items.');
        return newsList;
      } else {
        throw Exception('Failed to load news: ${data['message']}');
      }
    } on DioException catch (e) {
      print('Error occurred: $e');
      throw Exception('Failed to load news: ${e.message}');
    }
  }
}
