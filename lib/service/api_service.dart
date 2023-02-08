import 'package:dio/dio.dart';
import 'package:kandilli_deprem/model/afad_deprem_model.dart';
import 'package:kandilli_deprem/model/kandilli_deprem_model.dart';

class ApiService {
  static final dio = Dio();

  static Future<KandilliDepremModel?> getKandilliDeprem([int limit = 10]) async {
    final response = await dio.get('https://api.orhanaydogdu.com.tr/deprem/live.php?limit=$limit');
    return KandilliDepremModel.fromJson(response.data);
  }

  static Future<List<AfadDepremModel?>> getAfadDeprem(String startDate, String endDate) async {
    final response = await dio.get('https://deprem.afad.gov.tr/apiv2/event/filter?start=$startDate&end=$endDate');
    final data = response.data as List;
    return data.map((e) => AfadDepremModel.fromJson(e)).toList();
  }
}
