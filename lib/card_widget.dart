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
      child: Row(
        children: <Widget>[
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(movieInfo.thumbnailUrl),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    movieInfo.movieTitle.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 8),
                  DefaultTextStyle(
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.black54),
                    child: Column(
                      children: <Widget>[
                        Text(movieInfo.movieDescription),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      onTap: () {
        _navigateToDetailScreen(movieInfo, context);
      },
    ));
  }

  _navigateToDetailScreen(MovieInfo movieInfo, BuildContext buildContext) {
    Navigator.of(buildContext).push(PageRouteBuilder(
        opaque: true,
        transitionDuration: const Duration(milliseconds: 1000),
        pageBuilder: (BuildContext context, _, __) {
          return MovieDetails(movieInfo);
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return FadeTransition(
            opacity: animation,
            child: RotationTransition(
              turns: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
              child: child,
            ),
          );
        }));
  }
}
