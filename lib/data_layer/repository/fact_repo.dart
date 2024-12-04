import 'package:app/data_layer/Models/fact_model.dart';
import 'package:app/domain_layer/entities/fact.dart';
import 'package:app/utils/dio_client.dart';
import 'package:app/utils/service_locator.dart';
import 'package:dio/dio.dart';

abstract class FactRepository {
  Future<Fact> getFact();
}

class FactRepositoryImpl implements FactRepository {
  @override
  Future<Fact> getFact() async {
    try {
      print('Getting fact...');
      final response = await sl<DioClient>().get(
        'https://fun-facts1.p.rapidapi.com/api/fun-facts',
        options: Options(
          headers: {
            'x-rapidapi-key':
                '2d34cd21c8msh150f16dfba8d219p10dc69jsnb2b6dad187e6',
            'x-rapidapi-host': 'fun-facts1.p.rapidapi.com'
          },
        ),
      );

      if (response.statusCode == 403) {
        throw Exception(
            'Access forbidden: Invalid API key or insufficient permissions');
      }

      final factModel = FactModel.fromJson(response.data);
      print('This is the fact model');
      print(factModel);
      return Fact(fact: factModel.fact);
    } on DioException catch (e) {
      print('Error occurred: $e');
      throw Exception('Failed to load fact: ${e.message}');
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Failed to load fact');
    }
  }
}
