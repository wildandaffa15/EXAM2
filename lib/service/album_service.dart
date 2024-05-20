import 'dart:convert';
import 'package:json_api/models/album.dart';
import 'package:http/http.dart' as http;

class AlbumService {
  static String baseUrl = 'https://jsonplaceholder.typicode.com/albums/1/photos';
  static Future<List<Album>> fetchAlbum () async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> result = jsonDecode(response.body);

        List<Album> album = result.map((albumjson) => Album.fromJson(albumjson)).toList();

        return album;
      }else{
        throw Exception('failed to loads Album');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}