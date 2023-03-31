// import 'dart:convert';

// import '../models/photo_model.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

// class PhotoRepository {
//   Photos? photoData;
//   bool isOkay = true;
//   final uri = 'https://jsonplaceholder.typicode.com/photos';
//   Future<Photos> getPhotos({String? id = ''}) async {
//     // print('$uri/$id');
//     try {
//       final response = await http.get(
//         Uri.parse('$uri/$id'),
//       );
//       Photos x = Photos.fromJson(jsonDecode(response.body));
//       photoData = x;
//       return photoData!;
//     } catch (e) {
//       throw Error();
//     }
//   }
// }

import '../models/lab_model.dart';

class LabRepository {
  final uri = Uri.parse(
      'https://riverpod-daadb-default-rtdb.firebaseio.com/riverpod.json');
  Future<LabCenter> getLabData() async {
    try {
      final response = await http.get(uri);
      LabCenter data = LabCenter.fromJson(jsonDecode(response.body));
      print(data.nRhLnv4P2FRwQuqCu02?.data?.results?.length);
      return data;
    } catch (e) {
      throw Error();
    }
  }
}
