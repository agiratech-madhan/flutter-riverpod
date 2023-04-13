import 'package:http/http.dart' as http;
import 'package:movie_app_riverpod/Home/models/favorite_movie_model.dart';
import 'package:movie_app_riverpod/Home/models/genres_model.dart';
import 'package:movie_app_riverpod/Home/models/video_reponse.dart';
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
      print(response.body);
      Movies moviesData = Movies.fromJson(jsonDecode(response.body));
      return moviesData;
    } catch (e) {
      throw 'error Occured';
    }
  }

  Future<GenresList> getGenresList() async {
    try {
      final response = await http.get(Uri.parse(Constants.genreList));
      final responseValue = GenresList.fromJson(jsonDecode(response.body));
      return responseValue;
    } catch (e) {
      throw 'error Occred';
    }
  }

  Future<FavoriteMovies> fetchFavMovies() async {
    try {
      String queryPrarams =
          '?api_key=b6ee00729c9ca9a458e3625f96877b1a&language=en-US&sort_by=created_at.asc&page=1&session_id=eddac64578420733fe6ea79186969c9e2035a986';
      final url = Uri.parse(
          'https://api.themoviedb.org/3/account/16291825/favorite/movies$queryPrarams');
      final response = await http.get(url);
      FavoriteMovies moviesData =
          FavoriteMovies.fromJson(jsonDecode(response.body));
      return moviesData;
    } catch (e) {
      throw 'error Occured';
    }
  }

  Future<VideosList> movieVideos(String? id) async {
    try {
      final url = Uri.parse(
          'https://api.themoviedb.org/3/movie/$id/videos?api_key=b6ee00729c9ca9a458e3625f96877b1a&language=en-US');
      final response = await http.get(url);
      print(response.body);
      VideosList moviesData = VideosList.fromJson(jsonDecode(response.body));
      print('moviesData$moviesData');
      return moviesData;
    } catch (e) {
      print(e.toString());
      throw 'error Occured';
    }
  }
}
