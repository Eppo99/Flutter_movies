import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'widgets/trending.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.green),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String apikey = '7441f740c9915baada08e81f91b115a9';
  final String readaccesstoken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NDQxZjc0MGM5OTE1YmFhZGEwOGU4MWY5MWIxMTVhOSIsInN1YiI6IjVlMzI0NzZmYWM4ZTZiMDAxYWJmYzBlMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.W_iRTh_aWzmL2NXMxE9pTG3u_PuB8rWWg08uW4K5QSA';
  List trendingmovies = [];
  late GlobalKey <RefreshIndicatorState> refreshKey;

  @override
  void initState() {
    super.initState();
    refreshKey=GlobalKey<RefreshIndicatorState>();
    loadmovies();
  }

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readaccesstoken),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    print((trendingresult));
    setState(() {
      trendingmovies = trendingresult['results'];
    });
  }
  Future<Null>RefreshList()async{
    await Future.delayed(Duration(seconds: 1));
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readaccesstoken),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );
    Map trendingresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    setState(() {
      trendingmovies = trendingresult['results'];

    });
return null;

  }
  @override
  Widget build(BuildContext context) {
    Key key=Key('');
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('News',style: TextStyle(fontSize: 20),),
          backgroundColor: Colors.transparent,
        ),
        body: ListView(
          children: [
            RefreshIndicator(
              key: refreshKey,
              onRefresh: () async{
                await RefreshList();
              },
              child: TrendingMovies(
                trending: trendingmovies, key: key,
              ),
            ),

          ],
        ),
        );
  }
}
