import 'dart:convert';

import '../models/photo_model.dart';
import 'package:http/http.dart' as http;

class PhotoRepository {
  Photos? photoData;
  bool isOkay = true;
  final uri = 'https://jsonplaceholder.typicode.com/photos';
  Future<Photos> getPhotos({String? id = ''}) async {
    // print('$uri/$id');
    try {
      final response = await http.get(
        Uri.parse('$uri/$id'),
      );
      Photos x = Photos.fromJson(jsonDecode(response.body));
      photoData = x;
      return photoData!;
    } catch (e) {
      throw Error();
    }
  }
}
