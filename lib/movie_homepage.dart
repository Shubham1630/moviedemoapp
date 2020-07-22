import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:Demo/card_widget.dart';
import 'package:Demo/movie_api.dart';
import 'package:Demo/movie_info.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieState createState() => _MovieState();
}

class _MovieState extends State<MovieList> {
  final String nowPlayingApi =
      'https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed';
  final String topRatedApi =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed';

  TextEditingController controller = new TextEditingController();
  int bottomNavigationselectedIndex = 0;
  List<MovieInfo> movieInfoList = [];
  List<MovieInfo> searchList = [];

  bool isLoading = false;

  onItemTapped(int index) {
    setState(() {
      bottomNavigationselectedIndex = index;
      if (index == 0) {
        getData(nowPlayingApi);
        setState(() {});
      } else if (index == 1) {
        getData(topRatedApi);
        setState(() {});
      }
    });
  }

  getData(String url) async {
    movieInfoList.clear();
    searchList.clear();
    setState(() {
      isLoading = true;
    });
    await MovieApi.fetchData(url).then((value) => movieInfoList.addAll(value));
    setState(() {
      isLoading = false;
    });
  }

  onSearchTextChanged(String text) async {
    searchList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    movieInfoList.forEach((movieDetail) {
      if (movieDetail.movieTitle.toLowerCase().contains(text.toLowerCase()))
        searchList.add(movieDetail);
    });

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData(nowPlayingApi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: <Widget>[
                      TextField(
                        controller: controller,
                        onChanged: (value) {
                          onSearchTextChanged(value);
                        },
                        decoration: InputDecoration(
                            labelText: "Search",
                            hintText: "Search",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(35)))),
                      ),
                      Expanded(
                        child:
                            searchList.length != 0 || controller.text.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: searchList.length,
                                    itemBuilder: (context, index) {
                                      return Dismissible(
                                        key: ObjectKey(searchList[index]),
                                        child: CardWidget(
                                          movieInfo: searchList[index],
                                        ),
                                        onDismissed: (direction) {
                                          setState(() {
                                            searchList.removeAt(index);
                                          });
                                        },
                                      );
                                    },
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: movieInfoList.length,
                                    itemBuilder: (context, index) {
                                      return Dismissible(
                                        key: ObjectKey(movieInfoList[index]),
                                        child: CardWidget(
                                          movieInfo: movieInfoList[index],
                                        ),
                                        onDismissed: (direction) {
                                          setState(() {
                                            movieInfoList.removeAt(index);
                                          });
                                        },
                                      );
                                    },
                                  ),
                      ),
                      BottomNavigationBar(
                        items: <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                              icon: Icon(Icons.movie),
                              title: Text('Now Playing')),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.star), title: Text('Top Rated'))
                        ],
                        currentIndex: bottomNavigationselectedIndex,
                        onTap: onItemTapped,
                      ),
                    ],
                  )));
  }
}
