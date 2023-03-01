import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/world_state.dart';
import '../Utilities/app_url.dart';

class StateServices{

  Future<WorldState> fetchRecord() async{
      var data;
      final response = await http.get(
          Uri.parse(AppUrl.worldStatesApi));

      if (response.statusCode == 200) {
        data = jsonDecode(response.body.toString());
        return WorldState.fromJson(data);
      } else {
        throw Exception('Error');
      }
  }

  Future<List<dynamic>> fetchCountries() async{

      var data;
      final response = await http.get(
          Uri.parse(AppUrl.countriesList));

      if (response.statusCode == 200) {
        data = jsonDecode(response.body.toString());
        return data;
      } else {
        throw Exception('Error');
      }
  }
}