import 'dart:convert';

import 'package:http/http.dart';
import 'package:rescue_army/utils/constants.dart';

class Resource {
  final String? id;
  final String? title;
  final String? description;
  final DateTime? uploadDate;
  final String? file;
  final String? thumbnail;
  final String? owner;
  final String? extension;

  Resource(
      {this.id,
      this.title,
      this.description,
      this.uploadDate,
      this.file,
      this.thumbnail,
      this.owner,
      this.extension});

  static Resource fromJson(e) {
    return Resource(
        id: e['id'],
        title: e['title'],
        description: e['description'],
        uploadDate: e["upload_date"] != null
            ? DateTime.parse(e["upload_date"])
            : DateTime.now(),
        file: e['file'],
        thumbnail: e['thumbnail'],
        owner: e['owner'],
        extension: e['extension']);
  }

  static Future<List<Resource>> fetchResources() async {
    final request =
        await get(Uri.parse(Constants.API_ENDPOINT + "/resources/"));
    Map<String, dynamic> response = jsonDecode(request.body);
    final results = response['results'];
    List<Resource> resources =
        List.from(results.map((e) => Resource.fromJson(e)));
    return resources;
  }
}
