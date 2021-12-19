import 'dart:convert';

import 'package:asteroids/Models/Asteroid.dart';
import 'package:http/http.dart' as http;

Future<dynamic> fetchAsteroids(String startDate, String endDate) async {
  final response = await http.get(Uri.parse(
      'https://api.nasa.gov/neo/rest/v1/feed?start_date=$startDate&end_date=$endDate&detailed=true&api_key=gNanGeEAEiaUkwXaenj3P1IudVzrBL9fIUy51RdL'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Data');
  }
}
