import 'package:flutter/material.dart';
import 'package:Demo/movie_info.dart';

class MovieDetails extends StatefulWidget {
  final MovieInfo movieDetails;

  MovieDetails(this.movieDetails) {
    if (movieDetails == null) {
      throw ArgumentError(
          "member of MemberWidget cannot be null. Received: '$movieDetails'");
    }
  }

  @override
  MovieDetailsState createState() => MovieDetailsState(movieDetails);
}

class MovieDetailsState extends State<MovieDetails> {
  MovieInfo movieInfo;
  MovieDetailsState(this.movieInfo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Expanded(child: Image.network(movieInfo.thumbnailUrl)),
          Text(movieInfo.movieDescription)
        ],
      )),
    );
  }
}
