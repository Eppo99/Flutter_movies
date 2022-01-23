import 'package:flutter/material.dart';

import '../description.dart';

class TrendingMovies extends StatelessWidget {
  final List trending;

  const TrendingMovies({Key? key, required this.trending}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(height: 10),
          Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: trending.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Description(
                                      name: trending[index]['title'],
                                      bannerurl:
                                          'https://image.tmdb.org/t/p/w500' +
                                              trending[index]['backdrop_path'],
                                      posterurl:
                                          'https://image.tmdb.org/t/p/w500' +
                                              trending[index]['poster_path'],
                                      description: trending[index]['overview'],
                                      vote: trending[index]['vote_average']
                                          .toString(),
                                      launch_on: trending[index]
                                          ['release_date'],
                                    )));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Stack(
                              children: [

                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://image.tmdb.org/t/p/w500' +
                                              trending[index]['poster_path']),
                                    ),
                                  ),
                                  height: 600,
                                ),
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 300),
                                    child: Text(trending[index]['title'] != null
                                        ? trending[index]['title']
                                        : 'Loading',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(10),

                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: Text( trending[index]['vote_average']
                                      .toString(),
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: Text(trending[index]['title'] != null
                                      ? trending[index]['title']
                                      : 'Loading',
                              style: TextStyle(fontSize: 20),
                              ),
                            ),

                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
