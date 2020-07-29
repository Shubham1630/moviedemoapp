import 'package:http/http.dart';
import 'dart:convert';
import 'package:Demo/movie_info.dart';

class MovieApi {
  static Future<List<MovieInfo>> fetchData(String url) async {
    final posterThumbnail = 'https://image.tmdb.org/t/p/w342';
    List<MovieInfo> movieinfo = [];

    try {
      Response response = await get(url);
      if (response.statusCode == 200) {
        Map json = jsonDecode(response.body);
        var array = json['results'];
        for (int i = 0; i < 1; i++) {
          Map map = array[i];
          String posterPath = map['poster_path'];
          String movieTitle = map['original_title'];
          String overView = map['overview'];
          String voteAverage = map['vote_average'];
          print(map);

          movieinfo.add(MovieInfo('$posterThumbnail$posterPath', movieTitle,
              overView, voteAverage));
        }
        return movieinfo.toList();
      } else {
        throw Exception("Error occured while fetching Data");
      }
    } catch (e) {
      print("Error occured during connection");
      return null;
    }
  }
}
