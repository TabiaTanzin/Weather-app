import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() =>runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  title: "Weather app",
  home: Home(),
));


class Home extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var des;
  var cur;
  var hum;
  var windSpeed;
  Future getWeather() async{
    http.Response response=await http.get("http://api.openweathermap.org/data/2.5/weather?q=Ishwardi&appid=18d941538a46ed6b9b25ee6737657167");
     var result= jsonDecode(response.body);
     setState(() {
       this.temp=result['main']['temp'];
       this.des=result['weather'][0]['description'];
       this.cur=result['weather']['main'];
       this.hum=result['main']['humidity'];
       this. windSpeed=result['wind']['speed'];


     });
  }
  @override
  void initState(){
    super.initState();
    this.getWeather();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/3,
            width: MediaQuery.of(context).size.width,
            color: Colors.pink,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Weather of Ishwardi",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(temp!=null?temp.toString()+"\u00B0":"Loading",
                  style: TextStyle(
                      color: Colors.white,fontSize: 50,fontWeight: FontWeight.bold),),

                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    des!=null?des.toString():"Loading",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ),


              ],
            ),

          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: ListView(
                children: [
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Tempareture"),
                    trailing: Text(temp!=null?temp.toString()+"\u00B0":"Loading"),
                  ),
                  ListTile(
                     leading: FaIcon(FontAwesomeIcons.cloud),
                      title: Text("Weather"),
                      trailing: Text(des!=null?des.toString():"Loading"),
                    ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("Tempareture Humidity"),
                    trailing: Text(hum!=null?hum.toString():"Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Wind Speed"),
                    trailing: Text( windSpeed!=null? windSpeed.toString():"Loading"),
                  ),
                ],

              ),
            ),
          ),
                ],

              ),



      );


  }
}