import 'package:asteroids/Services/fetch.dart';
import 'package:asteroids/widgets/AnimatedImage.dart';
import 'package:flutter/material.dart';

import 'CardAsteroid.dart';

class AsteroidList extends StatefulWidget {
  AsteroidList({Key? key, required this.startDate, required this.endDate})
      : super(key: key);
  final String startDate, endDate;
  @override
  _AsteroidListState createState() => _AsteroidListState();
}

class _AsteroidListState extends State<AsteroidList> {
  List<dynamic> asteroidsList = [];
  dynamic minDist = 99999999999999999.99;
  dynamic closestAsteroid;
  dynamic fastestAsteroid;
  dynamic maxSpeed = -1.0;
  void genrateAsteroidsList(var asteroids) {
    asteroidsList = [];
    asteroids.forEach((key, data) => {
          data.forEach((data) => {
                if (double.parse(data['close_approach_data'][0]['miss_distance']
                        ['kilometers']) <
                    minDist)
                  {
                    minDist = double.parse(data['close_approach_data'][0]
                        ['miss_distance']['kilometers']),
                    closestAsteroid = {
                      "heading": "Closest to Earth",
                      "data": data
                    }
                  },
                if (double.parse(data['close_approach_data'][0]
                        ['relative_velocity']['kilometers_per_hour']) >
                    maxSpeed)
                  {
                    maxSpeed = double.parse(data['close_approach_data'][0]
                        ['relative_velocity']['kilometers_per_hour']),
                    fastestAsteroid = {
                      "heading": "Fastest Asteroid",
                      "data": data
                    }
                  }
              }),
        });
    asteroidsList.add(closestAsteroid);
    asteroidsList.add(fastestAsteroid);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: fetchAsteroids(widget.startDate, widget.endDate),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            genrateAsteroidsList(snapshot.data['near_earth_objects']);
            return Container(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: asteroidsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListCard(
                        heading: asteroidsList[index]['heading'],
                        asteroid: asteroidsList[index]['data'],
                        title: asteroidsList[index]['data']['name'],
                        id: asteroidsList[index]['data']['id'],
                        subTitle: asteroidsList[index]['data']
                                ['close_approach_data'][0]['relative_velocity']
                            ['kilometers_per_hour']);
                  }),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
        }
        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}

class ListCard extends StatelessWidget {
  const ListCard(
      {Key? key,
      required this.id,
      required this.title,
      required this.subTitle,
      required this.asteroid,
      required this.heading})
      : super(key: key);
  final asteroid;
  final dynamic id;
  final dynamic title;
  final dynamic subTitle;
  final String heading;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Center(
              child: Text(
                heading,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          decoration: BoxDecoration(
              color: Color(0xFFE6734F),
              borderRadius: BorderRadius.all(Radius.circular(4))),
        ),
        GestureDetector(
          child: Card(
            elevation: 2,
            color: Color(0xff334756).withOpacity(0.3),
            child: ListTile(
              leading: Hero(
                  tag: id,
                  child: AnimatedThumbnail(
                    imageUrl:
                        "https://images.vexels.com/media/users/3/203033/isolated/preview/bad8b13b449cf80e9cdbf1c355d63f4f-big-asteroid-illustration.png",
                  )),
              title: Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              subtitle: Text(
                subTitle + " km/hr",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AsteroidCard(
                        asteroid: asteroid,
                      )),
            )
          },
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
