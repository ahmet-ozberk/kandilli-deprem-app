import 'package:grock/grock.dart';
import 'package:html/parser.dart' as parser;
import 'package:dio/dio.dart';
import 'package:kandilli_deprem/model/kandilli_deprem_model.dart';

class WebScrapingService {
  static const String url = 'http://www.koeri.boun.edu.tr/scripts/lst0.asp';

  static Future<dynamic> getData() async {
    final dio = Dio();
    final response = await dio.get(url);
    final result = response.data;
    return result;
  }

  static Future<List<DepremModel>> htmlParse() async {
    
    final datas = await getData();
    final htmlDoc = parser.parse(datas);
    var preTag = htmlDoc.querySelector('pre');
    var data = preTag!.text.trim();
    var lines = data.split('\n');
    List<DepremModel> result = [];
    lines.forLoop((value, index) {
      if (index >= 6) {
        var tokens = value.split(' ');
        var list = [];
        tokens.forLoop((value2, index2) {
          if (value2.trim().isNotEmpty && value2 != "-.-") {
            value2.trim();
            list.add(value2);
          }
        });
        var depremModel = DepremModel(
          id: index,
          tarih: list[0].toString(),
          saat: list[1].toString(),
          enlem: list[2].toString(),
          boylam: list[3].toString(),
          derinlik: list[4].toString(),
          buyukluk: list[5].toString(),
          yer: "${list[6]} ${list[7]}",
        );
        result.add(depremModel);
        list.clear();
      }
    });
    return result;
  }
}
