import 'dart:convert';
import 'dart:io';

import 'package:flutter_http_request/domain/entity/post.dart';

class ApiClient {
  final client = HttpClient();

  Future<List<Post>> getPosts() async {
    final json = await get('https://jsonplaceholder.typicode.com/posts')
        as List<dynamic>;

    final posts = json
        .map((dynamic e) => Post.fromJson(e as Map<String, dynamic>))
        .toList();
    return posts;
  }

  Future<Post> createPost({required String title, required String body}) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final parameters = <String, dynamic>{
      'title': title,
      'body': body,
      'userId': 109
    };
    final request = await client.postUrl(url);
    request.headers.set('Content-type', 'application/json; charset=UTF-8');
    request.write(jsonEncode(parameters));
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
  }

  Future<dynamic> get(String ulr) async {
    final url = Uri.parse(ulr);
    final request = await client.getUrl(url);
    final response = await request.close();

    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final dynamic json = jsonDecode(jsonString);
    return json;
  }
}
