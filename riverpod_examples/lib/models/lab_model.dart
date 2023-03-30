// import 'package:uuid/uuid.dart';

// class Photos {
//   List<Photo>? photos;
//   Photos({
//     this.photos,
//   });
//   factory Photos.fromJson(List<dynamic> json) {
//     List<Photo> photos = json.map((e) => Photo.fromJson(e)).toList();

//     return Photos(photos: photos);
//   }
// }

// class Photo {
//   int? albumId;
//   String? id;
//   String? title;
//   String? url;
//   String? thumbnailUrl;
//   Photo({
//     this.albumId,
//     this.id,
//     this.title,
//     this.url,
//     this.thumbnailUrl,
//   });
//   static const uuid = Uuid();

//   factory Photo.fromJson(Map<String, dynamic> json) {
//     String ids = json['id'].toString();

//     return Photo(
//         id: ids,
//         // id: ((json['id'] == '0') ? uuid.v4() : json['id']).toString(),
//         title: json['title'],
//         albumId: json['albumId'],
//         url: json['url'],
//         thumbnailUrl: json['thumbnailUrl']);
//   }
//   Map<String, dynamic> toJson() => {
//         'id': (id == null) ? uuid.v4().toString() : id,
//         'title': title,
//         'albumId': albumId,
//         'url': url,
//         'thumbnailUrl': thumbnailUrl
//       };
// }
// To parse this JSON data, do
//
//     final LabCenter = LabCenterFromJson(jsonString);

import 'dart:convert';

// LabCenter LabCenterFromJson(String str) => LabCenter.fromJson(json.decode(str));

// String LabCenterToJson(LabCenter data) => json.encode(data.toJson());

class LabCenter {
  LabCenter({
    this.nRhLnv4P2FRwQuqCu02,
  });

  CenterKey? nRhLnv4P2FRwQuqCu02;

  factory LabCenter.fromJson(Map<String, dynamic> json) => LabCenter(
        nRhLnv4P2FRwQuqCu02: CenterKey.fromJson(json["-NRhLNV4p2fRWQuqCU02"]),
      );

  Map<String, dynamic> toJson() => {
        "-NRhLNV4p2fRWQuqCU02": nRhLnv4P2FRwQuqCu02!.toJson(),
      };
}

class CenterKey {
  CenterKey({
    this.apiMessage,
    this.data,
    this.message,
    this.status,
  });

  String? apiMessage;
  Data? data;
  String? message;
  String? status;

  factory CenterKey.fromJson(Map<String, dynamic> json) => CenterKey(
        apiMessage: json["api-message"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "api-message": apiMessage,
        "data": data!.toJson(),
        "message": message,
        "status": status,
      };
}

class Data {
  Data({
    this.pagination,
    this.results,
  });

  Pagination? pagination;
  List<Result>? results;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pagination: Pagination.fromJson(json["pagination"]),
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination!.toJson(),
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Pagination {
  Pagination({
    this.found,
    this.page,
    this.perPage,
    this.total,
  });

  int? found;
  int? page;
  int? perPage;
  int? total;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        found: json["found"],
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "found": found,
        "page": page,
        "per_page": perPage,
        "total": total,
      };
}

class Result {
  Result({
    this.code,
    this.createdAt,
    this.createdBy,
    this.email,
    this.id,
    this.isDeleted,
    this.isActive,
    this.location,
    this.mobileNumber,
    this.name,
    this.testCount,
    this.updatedAt,
    this.username,
  });

  int? code;
  DateTime? createdAt;
  String? createdBy;
  String? email;
  String? id;
  bool? isDeleted;
  bool? isActive;
  Location? location;
  String? mobileNumber;
  String? name;
  int? testCount;
  DateTime? updatedAt;
  String? username;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        code: json["code"],
        createdAt: DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
        email: json["email"],
        id: json["id"],
        isDeleted: json["isDeleted"],
        isActive: json["is_active"],
        location: Location.fromJson(json["location"]),
        mobileNumber: json["mobile_number"],
        name: json["name"],
        testCount: json["test_count"],
        updatedAt: DateTime.parse(json["updated_at"]),
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "created_at": createdAt!.toIso8601String(),
        "created_by": createdBy,
        "email": email,
        "id": id,
        "isDeleted": isDeleted,
        "is_active": isActive,
        "location": location!.toJson(),
        "mobile_number": mobileNumber,
        "name": name,
        "test_count": testCount,
        "updated_at": updatedAt!.toIso8601String(),
        "username": username,
      };
}

class Location {
  Location({
    this.address,
    this.area,
    this.city,
    this.country,
    this.createdAt,
    this.district,
    this.id,
    this.isDeleted,
    this.isActive,
    this.lat,
    this.long,
    this.pincode,
    this.state,
    this.updatedAt,
  });

  String? address;
  String? area;
  String? city;
  String? country;
  DateTime? createdAt;
  String? district;
  String? id;
  bool? isDeleted;
  bool? isActive;
  String? lat;
  String? long;
  int? pincode;
  String? state;
  DateTime? updatedAt;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        address: json["address"],
        area: json["area"],
        city: json["city"],
        country: json["country"],
        createdAt: DateTime.parse(json["created_at"]),
        district: json["district"],
        id: json["id"],
        isDeleted: json["isDeleted"],
        isActive: json["is_active"],
        lat: json["lat"],
        long: json["long"],
        pincode: json["pincode"],
        state: json["state"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "area": area,
        "city": city,
        "country": country,
        "created_at": createdAt!.toIso8601String(),
        "district": district,
        "id": id,
        "isDeleted": isDeleted,
        "is_active": isActive,
        "lat": lat,
        "long": long,
        "pincode": pincode,
        "state": state,
        "updated_at": updatedAt!.toIso8601String(),
      };
}
