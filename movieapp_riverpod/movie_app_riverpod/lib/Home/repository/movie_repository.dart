import 'package:http/http.dart' as http;
import 'package:movie_app_riverpod/constants.dart';
import 'dart:convert';

import '../models/movie_model.dart';

class MovieRepository {
  Future<Movies> loadData(String value) async {
    String searchValue = (value == '') ? '' : value;
    String params = (value == '') ? '/3/trending/movie/day' : '/3/search/movie';
    try {
      final url = Uri.http('api.themoviedb.org', params,
          {'api_key': Constants.apiKey, 'query': searchValue});

      final response = await http.get(url);
      Movies moviesData = Movies.fromJson(jsonDecode(response.body));
      print("#response$moviesData");
      return moviesData;
    } catch (e) {
      throw 'error Occured';
    }
  }
}
