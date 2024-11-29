import 'package:dialy_buddy/data_layer/Models/fact_model.dart';
import 'package:dialy_buddy/domain_layer/entities/fact.dart';
import 'package:dialy_buddy/utils/dio_client.dart';
import 'package:dialy_buddy/utils/service_locator.dart';
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
                'e9e30b436bmsh5f69dd7dc299852p1c419djsnc30802de0c56',
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
