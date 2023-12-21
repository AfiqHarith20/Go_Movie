// import "package:go_movie/system_all_library.dart";
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class AuthService {
//   // Singleton pattern
//   static final AuthService _instance = AuthService._internal();

//   factory AuthService() {
//     return _instance;
//   }

//   AuthService._internal();

//   Future<void> saveGuestSessionToken(String token) async {
//     final guestSession = await authService.fetchGuestSession();
//     if (guestSession.guestSessionId != null &&
//         guestSession.guestSessionId.isNotEmpty) {
//       await authService.saveGuestSessionToken(guestSession.guestSessionId);
//     } else {
//       print('Guest session ID is null or empty.');
//     }
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('guestSessionToken', token);
//   }

//   Future<GuestSession> fetchGuestSession() async {
//     final url = Uri.parse(Constants.guestSession);
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final http.Response response = await http.get(
//       url,
//       headers: {
//         'Authorization':
//             'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ZDYxMWVkZWQ0YTBkYTg1YjUxMDY2MWNjN2EzNjE0MSIsInN1YiI6IjY1ODNiZGZlY2E4MzU0NDEwM2Q3NzZlMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.8u8De19ZTQI0BnXy5ZZb8PGxrs-V7HFn3hGNAhPDODI',
//         'Content-Type': 'application/json'
//       },
//     );
//     print('Response Body: ${response.body}');
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> json = jsonDecode(response.body);
//       final guestSession = GuestSession.fromJson(json);
//       return guestSession;
//     } else {
//       throw Exception(
//           'Failed to fetch guest session. Status code: ${response.statusCode}');
//     }
//   }

//   Future<void> clearGuestSession() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.remove('guestSessionToken');
//   }

//   Future<void> logout() async {
//     // Add any additional cleanup logic here
//     await clearGuestSession();
//   }

//   // Add your fetchGuestSession function here (as it is in your MyApp class)
//   // ...

//   // Add any other authentication-related functions here
//   // ...
// }
