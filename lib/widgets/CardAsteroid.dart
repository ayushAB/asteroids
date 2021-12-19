import 'package:asteroids/widgets/AnimatedImage.dart';
import 'package:flutter/material.dart';

class AsteroidCard extends StatefulWidget {
  AsteroidCard({Key? key, required this.asteroid}) : super(key: key);
  dynamic asteroid;

  @override
  _AsteroidCardState createState() => _AsteroidCardState();
}

class _AsteroidCardState extends State<AsteroidCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.asteroid['name']),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        backgroundColor: Color(0xFFE6734F),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: AsteroidHeading(
                  id: widget.asteroid['id'],
                  asteroidName: widget.asteroid['name'],
                  asterodDescription: widget.asteroid['orbital_data']
                      ['orbit_class']['orbit_class_description']),
            ),
            CardTile(
              asteroidDetails: widget.asteroid,
            ),
          ],
        ),
      ),
    );
  }
}

class CardTile extends StatelessWidget {
  const CardTile({Key? key, required this.asteroidDetails}) : super(key: key);
  final dynamic asteroidDetails;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.all(2),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              DetailText(
                  label: "Miss Distance: ",
                  value: asteroidDetails['close_approach_data'][0]
                      ['miss_distance']['kilometers']),
              SizedBox(
                height: 10,
              ),
              DetailText(
                  label: "Minimum Orbit Intersection: ",
                  value: asteroidDetails['orbital_data']
                          ['minimum_orbit_intersection']
                      .toString()),
              SizedBox(
                height: 10,
              ),
              DetailText(
                  label: "Jupiter Tisserand Invariant: ",
                  value: asteroidDetails['orbital_data']
                          ['jupiter_tisserand_invariant']
                      .toString()),
              SizedBox(
                height: 10,
              ),
              DetailText(
                  label: "Perihelion Time: ",
                  value: asteroidDetails['orbital_data']['perihelion_time']
                      .toString()),
              SizedBox(
                height: 10,
              ),
              DetailText(
                  label: "Orbital Period: ",
                  value: asteroidDetails['orbital_data']['orbital_period']
                      .toString()),
            ]),
      ),
    );
  }
}

class AsteroidHeading extends StatelessWidget {
  const AsteroidHeading(
      {Key? key,
      required this.asteroidName,
      required this.asterodDescription,
      required this.id})
      : super(key: key);
  final String asteroidName;
  final String asterodDescription;
  final id;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            asteroidName,
            style: TextStyle(
                height: 1.2,
                fontSize: 16,
                color: Colors.white,
                decoration: TextDecoration.none),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Text(asterodDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 1.2,
                    color: Colors.white,
                    fontSize: 12,
                    decoration: TextDecoration.none)),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 250,
            height: 200,
            child: Hero(
              tag: id,
              child: AnimatedThumbnail(
                  imageUrl:
                      "https://www.pngarts.com/files/12/Vector-Asteroid-PNG-Transparent-Image.png"),
            ),
          )
        ],
      ),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.only(
      //       bottomLeft: Radius.circular(100),
      //       bottomRight: Radius.circular(100)),
      //   color: Color(0xFFE6734F),
      // ),
    );
  }
}

class DetailText extends StatelessWidget {
  const DetailText({Key? key, required this.label, required this.value})
      : super(key: key);
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        Text(
          label,
          style: TextStyle(
              height: 1,
              color: Colors.white,
              fontStyle: FontStyle.normal,
              fontSize: 11,
              decoration: TextDecoration.none),
        ),
        Text(
          value,
          style: TextStyle(
              height: 1,
              color: Color(0xFFE6734F),
              fontStyle: FontStyle.normal,
              fontSize: 11,
              decoration: TextDecoration.none),
        )
      ]),
    );
  }
}
