import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static Future getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ZDYxMWVkZWQ0YTBkYTg1YjUxMDY2MWNjN2EzNjE0MSIsInN1YiI6IjY1ODNiZGZlY2E4MzU0NDEwM2Q3NzZlMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.8u8De19ZTQI0BnXy5ZZb8PGxrs-V7HFn3hGNAhPDODI');
  }

  static String movieUrl = "https://api.themoviedb.org/3/";

  static String guestSession = "${movieUrl}authentication/guest_session/new";
  static String genreMovie = "${movieUrl}genre/movie/list";
  static String nowPlaying = "${movieUrl}movie/now_playing";
  static String popularMovie = "${movieUrl}movie/popular";
  static String topRated = "${movieUrl}movie/top_rated";
  static String upComing = "${movieUrl}movie/upcoming";

  static String genreTv = "${movieUrl}genre/tv/list";
  static String airingToday = "${movieUrl}tv/airing_today";
  static String onTheAir = "${movieUrl}tv/on_the_air";
  static String popularTv = "${movieUrl}tv/popular";
  static String topRatedTv = "${movieUrl}tv/top_rated";
}
