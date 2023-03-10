import 'package:http/http.dart' as http;
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.status,
    required this.message,
    required this.data,
    required this.meta,
  });

  bool status;
  String message;
  List<dynamic> data;
  Meta meta;

  factory User.fromJson(Map<String, dynamic> json) => User(
        status: json["status"],
        message: json["message"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x)),
        "meta": meta.toJson(),
      };
}

class Meta {
  Meta({
    required this.total,
    required this.totalVolume,
    required this.skipped,
    required this.perPage,
    required this.page,
    required this.pageCount,
  });

  int total;
  int totalVolume;
  int skipped;
  int perPage;
  int page;
  int pageCount;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        total: json["total"],
        totalVolume: json["total_volume"],
        skipped: json["skipped"],
        perPage: json["perPage"],
        page: json["page"],
        pageCount: json["pageCount"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "total_volume": totalVolume,
        "skipped": skipped,
        "perPage": perPage,
        "page": page,
        "pageCount": pageCount,
      };
}

class UserService {
  Future<List<User>> getUser() async {
    final response =
        await http.get(Uri.parse('https://api.paystack.co/transaction/totals'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List<User> list = [];

      for (var i = 0; i < data['status'].length; i++) {
        final entry = data['status'][i];
        list.add(User.fromJson(entry));
      }
      return list;
    } else {
      throw Exception('Http failed');
    }
  }
}
