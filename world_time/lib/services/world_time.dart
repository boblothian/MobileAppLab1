import 'dart:convert';

import 'package:http/http.dart';

class WorldTime {
  late String location; //location name for the UI
  late String time; //time in that location
  String flag; //url to asset flag icon
  String url; //location url for API endpoint

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      //make request
      Response response =
          await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0, 3);

      //print(datetime);
      //print(offset);

      //create datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset) - 1));

      //set time property
      time = now.toString();
    } catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
  }
}
