import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:subspace/data/model/blogsModel.dart';

class HomeRepository{
  Future<BlogsModel?> fetchBlogs() async {
    final url = Uri.parse("https://intent-kit-16.hasura.app/api/rest/blogs");
    var res =await http.get(url,headers: {
      "x-hasura-admin-secret":"32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6"
    });
    var resData = jsonDecode(res.body);
    return BlogsModel.fromJson(resData);
  }
}