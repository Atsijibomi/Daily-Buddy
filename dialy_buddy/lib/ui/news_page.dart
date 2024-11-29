import 'package:dialy_buddy/data_layer/Models/news_model.dart';
import 'package:dialy_buddy/domain_layer/bloc/news_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(FetchNewsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsLoaded) {
            return ListView.builder(
              itemCount: state.newsList.newsItems.length,
              itemBuilder: (context, index) {
                final newsItem = state.newsList.newsItems[index];
                return Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    title: Text(
                      newsItem.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(newsItem.snippet),
                    trailing: Text(newsItem.publisher),
                    onTap: () {
                      // Handle news item tap
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NewsDetailPage(newsItem: newsItem),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is NewsError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('No news available'));
          }
        },
      ),
    );
  }
}

class NewsDetailPage extends StatelessWidget {
  final NewsItem newsItem;

  const NewsDetailPage({super.key, required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(newsItem.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              newsItem.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              newsItem.snippet,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Published by: ${newsItem.publisher}',
              style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Open the news URL
                // launch(newsItem.newsUrl);
              },
              child: const Text('Read more'),
            ),
          ],
        ),
      ),
    );
  }
}
