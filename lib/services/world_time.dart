import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location = ''; // location name for the UI
  String time = ''; // the time in that location
  String date = ''; // the time in that location
  String flag = ''; // url to an asset flag icon
  String url = ''; // location url for api endpoint
  bool isDayTime = true; // true or false if daytime or not

  WorldTime({this.location = '', this.flag = '', this.url = ''});

  Future<void> getTime() async {

    try {

      // make a request
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      // create a DateTime object
      DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
      DateTime now = dateFormat.parse(datetime);
      now.add(Duration(hours: int.parse(offset)));

      // set the date and time property
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
      date = DateFormat.yMMMMd().format(now);

    } catch (e) {
      print('cought error: $e');
      time = 'could not get time data';
    }
  }
}

