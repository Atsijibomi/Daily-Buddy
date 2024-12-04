import 'package:app/domain_layer/bloc/fact_bloc.dart';
import 'package:app/domain_layer/bloc/news_bloc.dart';
import 'package:app/ui/fact_page.dart';
import 'package:app/ui/home_page.dart';
import 'package:app/ui/news_page.dart';
import 'package:app/utils/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<FactBloc>(),
        ),
        BlocProvider(create: (context) => sl<NewsBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Daily Buddy',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/factPage': (context) => BlocProvider.value(
                value: sl<FactBloc>(),
                child: const FactPage(),
              ),
          '/newsPage': (context) => BlocProvider.value(
                value: sl<NewsBloc>(),
                child: const NewsPage(),
              ),
        },
      ),
    );
  }
}
