import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>>
fetchPrediction(String symbol) async{
  final url =
      Uri.parse("http://127.0.0.1:8000/predict?symbol=$symbol");

  final res = await http.get(url);
  if(res.statusCode == 200){
    return json.decode(res.body);
  }else{
    throw Exception("Failed to load data");
  }
}