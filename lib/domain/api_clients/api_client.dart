import 'dart:convert';
import 'dart:io';

import 'package:flutter_http_request/domain/entity/post.dart';

class ApiClient {
  final client = HttpClient();

  void getPosts() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    //Uri(scheme: 'https', host: 'https://jsonplaceholder.typicode.com', path: 'posts',); Second way to getPost
    final request = await client.getUrl(url);
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString) as List<dynamic>;
    final posts = json
        .map((dynamic e) => Post.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
