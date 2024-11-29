import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dialy_buddy/data_layer/Models/news_model.dart';
import 'package:dialy_buddy/data_layer/repository/news_repo.dart';
import 'package:equatable/equatable.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  NewsBloc({required this.newsRepository}) : super(NewsInitial()) {
    on<FetchNewsEvent>(onFetchNews);
  }

  FutureOr<void> onFetchNews(
      FetchNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    try {
      final newsList = await newsRepository.fetchNews();
      emit(NewsLoaded(newsList: newsList));
    } catch (e) {
      print('Error occurred: $e');
      emit(NewsError(message: e.toString()));
    }
  }
}
