import 'package:http/http.dart' as http;
import 'package:movie_app_riverpod/Home/models/genres_model.dart';
import 'package:movie_app_riverpod/constants.dart';
import 'dart:convert';

import '../models/movie_model.dart';

class MovieRepository {
  Future<Movies> loadData(String value, {String filterType = 'popular'}) async {
    String searchValue = (value == '') ? '' : value;
    String params = (value == '') ? '/3/movie/$filterType' : '/3/search/movie';
    try {
      final url = Uri.http('api.themoviedb.org', params,
          {'api_key': Constants.apiKey, 'query': searchValue});
      final response = await http.get(url);
      Movies moviesData = Movies.fromJson(jsonDecode(response.body));
      // print("#response${response.body}");
      return moviesData;
    } catch (e) {
      throw 'error Occured';
    }
  }

  Future<GenresList> getGenresList() async {
    try {
      final response = await http.get(Uri.parse(Constants.genreList));
      // print(response.body);

      final responseValue = GenresList.fromJson(jsonDecode(response.body));
      return responseValue;
    } catch (e) {
      // print(e);
      throw 'error Occred';
    }
  }
}
