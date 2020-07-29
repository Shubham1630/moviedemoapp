import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:Demo/movie_info.dart';
import 'package:Demo/movie_details_page.dart';

class CardWidget extends StatelessWidget {
  final MovieInfo movieInfo;

  const CardWidget({Key key, this.movieInfo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
      child: Container(
          width: 135,
          height: 135,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5),
                child: CachedNetworkImage(
                  imageUrl: movieInfo.thumbnailUrl,
                  placeholder: (context, url) =>
                      Image.asset('assets/place_holder.png'),
                  fit: BoxFit.contain,
                  fadeOutDuration: const Duration(milliseconds: 500),
                  fadeInDuration: const Duration(milliseconds: 250),
                  useOldImageOnUrlChange: true,
                  fadeInCurve: Curves.bounceIn,
                ),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        movieInfo.movieTitle.toUpperCase(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Text('hello'),
                    )
                  ],
                ),
              ))
            ],
          )),
      onTap: () {
        _navigateToDetailScreen(movieInfo, context);
      },
    ));
  }

  _navigateToDetailScreen(MovieInfo movieInfo, BuildContext buildContext) {
    Navigator.of(buildContext).push(PageRouteBuilder(
      pageBuilder: (BuildContext context, _, __) {
        return MovieDetails(movieInfo);
      },
    ));
  }
}
