import 'package:dialy_buddy/data_layer/repository/fact_repo.dart';
import 'package:dialy_buddy/data_layer/repository/news_repo.dart';
import 'package:dialy_buddy/domain_layer/bloc/fact_bloc.dart';
import 'package:dialy_buddy/domain_layer/bloc/news_bloc.dart';
import 'package:dialy_buddy/utils/dio_client.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setUpServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  sl.registerSingleton<FactRepository>(FactRepositoryImpl());

  sl.registerSingleton<FactBloc>(FactBloc());

  sl.registerSingleton<NewsRepository>(NewsRepositoryImpl());

  sl.registerFactory(() => NewsBloc(newsRepository: sl<NewsRepository>()));
}
