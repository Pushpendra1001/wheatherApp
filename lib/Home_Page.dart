import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:mausam/fatch/fatch.dart';
import 'package:mausam/fatch/fatchingwheather.dart';
import 'package:mausam/fatch/secretKey.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

double tempdata = 0;
String newword = "Jaipur";

class _HomePageState extends State<HomePage> {
  Future getCurrentWeather() async {
    try {
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$newword&APPID=$sercretKey',
        ),
      );

      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }
      setState(() {
        tempdata = data["list"][0]["main"]["temp"];

        tempdata = tempdata - 273;
        tempdata = double.parse(tempdata.toStringAsFixed(2));
      });

      // return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getCurrentWeather();
    });
  }

  final cityName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mausam App",
          style: GoogleFonts.cabinSketch(fontSize: 34),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                // print(data);
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      drawer: Drawer(
        elevation: 5,
        child: ListView(
          children: const [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.transparent),
              accountEmail: Text("Pushpendra9122@gmail.com"),
              accountName: Text("Mr Pushpendra"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://media.licdn.com/dms/image/D4D03AQHJH-gbHP2cYw/profile-displayphoto-shrink_400_400/0/1684208939798?e=1702512000&v=beta&t=ngTwDVeIKRgoMRHcQhupqSdSnw0DER6JRPzLs9437k8"),
              ),
            ),
            ListTile(
              title: Text("Profile"),
              leading: Icon(Icons.person),
            ),
            ListTile(
              title: Text("Change Wheather"),
              leading: Icon(Icons.whatshot),
            ),
            ListTile(
              title: Text("Settings"),
              leading: Icon(Icons.settings),
            ),
            ListTile(
              title: Text("Settings"),
              leading: Icon(Icons.settings),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: cityName,
                    decoration: InputDecoration(
                        hintText: "Enter City Name",
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                newword = cityName.text;
                                getCurrentWeather();
                              });
                            },
                            child: const Icon(Icons.done))),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                Text(
                  newword.toUpperCase(),
                  style: GoogleFonts.handjet(fontSize: 44),
                ),
                const SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "$tempdata °C",
                                  style: const TextStyle(fontSize: 32),
                                ),
                                const Icon(
                                  Icons.cloud,
                                  size: 60,
                                ),
                                const Text(
                                  "Rain",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Mausam Forecast",
                    style: TextStyle(fontSize: 25),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                // weather forcast timings
                SizedBox(
                  height: 100,
                  child: Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        var value = int.parse(index.toString());

                        value = index * 3;

                        return SizedBox(
                          width: 100,
                          height: 50,
                          child: Card(
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "$value",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Icon(Icons.cloud),
                                const Text("301.17")
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                //  -----------------------additional information-----------------
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Aditional Information",
                    style: TextStyle(fontSize: 25),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Additionalinformation(),
                    // Additionalinformation(),
                    adinfo(
                      iconname: Icons.water_drop,
                      name: "Humidity",
                      value: "80",
                    ),
                    adinfo(
                      iconname: Icons.air,
                      name: "Wind speed",
                      value: "7.5",
                    ),
                    adinfo(
                      iconname: Icons.beach_access,
                      name: "Pressure",
                      value: "1000",
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class adinfo extends StatelessWidget {
  const adinfo(
      {super.key,
      required this.iconname,
      required this.name,
      required this.value});

  final iconname;
  final name;
  final value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Icon(iconname), Text(name), Text(value)],
      ),
    );
  }
}
