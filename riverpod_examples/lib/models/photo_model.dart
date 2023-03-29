import 'package:uuid/uuid.dart';

class Photos {
  List<Photo>? photos;
  Photos({
    this.photos,
  });
  factory Photos.fromJson(List<dynamic> json) {
    List<Photo> photos = json.map((e) => Photo.fromJson(e)).toList();

    return Photos(photos: photos);
  }
}

class Photo {
  int? albumId;
  String? id;
  String? title;
  String? url;
  String? thumbnailUrl;
  Photo({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });
  static const uuid = Uuid();

  factory Photo.fromJson(Map<String, dynamic> json) {
    String ids = json['id'].toString();

    return Photo(
        id: ids,
        // id: ((json['id'] == '0') ? uuid.v4() : json['id']).toString(),
        title: json['title'],
        albumId: json['albumId'],
        url: json['url'],
        thumbnailUrl: json['thumbnailUrl']);
  }
  Map<String, dynamic> toJson() => {
        'id': (id == null) ? uuid.v4().toString() : id,
        'title': title,
        'albumId': albumId,
        'url': url,
        'thumbnailUrl': thumbnailUrl
      };
}
