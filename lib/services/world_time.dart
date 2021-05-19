import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location, time, flag, url;
  bool isDayTime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      // make the request
      String completeUrl = 'https://worldtimeapi.org/api/timezone/$url';
      print("completeUrl = $completeUrl");

      Response response = await get(completeUrl);
      Map data = jsonDecode(response.body);

      // get properties from JSON
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set the time property
      isDayTime = (now.hour > 6 && now.hour < 20) ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print(e);
      time = 'Could not get Time';
    }
  }
}
