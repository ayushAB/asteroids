import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class HeroAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return new Scaffold(
    //   appBar: new AppBar(
    //     title: new Text(
    //       'HERO ANIMATION',
    //       style: new TextStyle(
    //           fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
    //     ),
    //     centerTitle: true,
    //     backgroundColor: Colors.deepPurple,
    //     iconTheme: new IconThemeData(color: Colors.white),
    //   ),
    //   body:
    // );

    return new HeroAnimationScreen(
      screenSize: MediaQuery.of(context).size,
    );
  }
}

class HeroAnimationScreen extends StatefulWidget {
  final Size screenSize;

  HeroAnimationScreen({Key? key, required this.screenSize}) : super(key: key);

  @override
  State createState() => HeroAnimationScreenState();
}

class HeroAnimationScreenState extends State<HeroAnimationScreen>
    with TickerProviderStateMixin {
  static const double kMinRadius = 32.0;
  static const double kMaxRadius = 128.0;
  static const double durationSlowMode = 2.0;

  Color gradientStartFrom = Colors.black;
  Color gradientStartTo = Colors.black;
  Color gradientEndFrom = new Color(0x00000000);
  Color gradientEndTo = new Color(0x00000000);

  late AnimationController animControlStar, animControlPlanet, animControlBg;
  late Animation fadeAnimStar1,
      fadeAnimStar2,
      fadeAnimStar3,
      fadeAnimStar4,
      sizeAnimStar,
      rotateAnimStar;
  late Animation fadeAnimPlanet1,
      fadeAnimPlanet2,
      fadeAnimPlanet3,
      fadeAnimPlanet4;
  late Animation sizeAnimPlanet1,
      sizeAnimPlanet2,
      sizeAnimPlanet3,
      sizeAnimPlanet4;
  late Animation colorAnimBgStart, colorAnimBgEnd;
  late Size screenSize;
  late List<Star> listStar;
  late int numStars;

  RectTween createRectTween(Rect begin, Rect end) {
    return new MaterialRectArcTween(begin: begin, end: end);
  }

  Widget buildStar(
      double left, double top, double extraSize, double angle, int typeFade) {
    return new Positioned(
      child: new Container(
        child: new Transform.rotate(
          child: new Opacity(
            child: new Icon(
              Icons.star,
              color: Colors.white,
              size: sizeAnimStar.value + extraSize,
            ),
            opacity: (typeFade == 1)
                ? fadeAnimStar1.value
                : (typeFade == 2)
                    ? fadeAnimStar2.value
                    : (typeFade == 3)
                        ? fadeAnimStar3.value
                        : fadeAnimStar4.value,
          ),
          angle: angle,
        ),
        alignment: FractionalOffset.center,
        width: 10.0,
        height: 10.0,
      ),
      left: left,
      top: top,
    );
  }

  Widget buildGroupStar() {
    List<Widget> list = [];
    for (int i = 0; i < numStars; i++) {
      list.add(buildStar(listStar[i].left, listStar[i].top,
          listStar[i].extraSize, listStar[i].angle, listStar[i].typeFade));
    }

    return new Stack(
      children: <Widget>[
        list[0],
        list[1],
        list[2],
        list[3],
        list[4],
        list[5],
        list[6],
        list[7],
        list[8],
        list[9],
        list[10],
        list[11],
        list[12],
        list[13],
        list[14],
        list[15],
        list[16],
        list[17],
        list[18],
        list[19],
        list[20],
        list[21],
        list[22],
        list[23],
        list[24],
        list[25],
        list[26],
        list[27],
        list[28],
        list[29],
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    screenSize = widget.screenSize;
    listStar = [];
    numStars = 30;

    // Star
    animControlStar = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 2000));
    fadeAnimStar1 = new Tween(begin: 0.0, end: 1.0).animate(new CurvedAnimation(
        parent: animControlStar, curve: new Interval(0.0, 0.5)));
    fadeAnimStar1.addListener(() {
      setState(() {});
    });
    fadeAnimStar2 = new Tween(begin: 0.0, end: 1.0).animate(new CurvedAnimation(
        parent: animControlStar, curve: new Interval(0.5, 1.0)));
    fadeAnimStar2.addListener(() {
      setState(() {});
    });
    fadeAnimStar3 = new Tween(begin: 1.0, end: 0.0).animate(new CurvedAnimation(
        parent: animControlStar, curve: new Interval(0.0, 0.5)));
    fadeAnimStar3.addListener(() {
      setState(() {});
    });
    fadeAnimStar4 = new Tween(begin: 1.0, end: 0.0).animate(new CurvedAnimation(
        parent: animControlStar, curve: new Interval(0.5, 1.0)));
    fadeAnimStar4.addListener(() {
      setState(() {});
    });
    sizeAnimStar = new Tween(begin: 0.0, end: 5.0).animate(new CurvedAnimation(
        parent: animControlStar, curve: new Interval(0.0, 0.5)));
    sizeAnimStar.addListener(() {
      setState(() {});
    });
    rotateAnimStar = new Tween(begin: 0.0, end: 1.0).animate(
        new CurvedAnimation(
            parent: animControlStar, curve: new Interval(0.0, 0.5)));
    rotateAnimStar.addListener(() {
      setState(() {});
    });

    animControlStar.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animControlStar.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animControlStar.forward();
      }
    });

    for (int i = 0; i < numStars; i++) {
      listStar.add(new Star(
          left: new Random().nextDouble() * screenSize.width,
          top: Random().nextDouble() * screenSize.height,
          extraSize: Random().nextDouble() * 2,
          angle: Random().nextDouble(),
          typeFade: Random().nextInt(4)));
    }

    // Planet
    animControlPlanet = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 2000));
    fadeAnimPlanet1 = new Tween(begin: 0.0, end: 1.0).animate(
        new CurvedAnimation(
            parent: animControlPlanet, curve: new Interval(0.0, 0.5)));
    fadeAnimPlanet1.addListener(() {
      setState(() {});
    });
    fadeAnimPlanet2 = new Tween(begin: 0.0, end: 1.0).animate(
        new CurvedAnimation(
            parent: animControlPlanet, curve: new Interval(0.2, 0.7)));
    fadeAnimPlanet2.addListener(() {
      setState(() {});
    });
    fadeAnimPlanet3 = new Tween(begin: 0.0, end: 1.0).animate(
        new CurvedAnimation(
            parent: animControlPlanet, curve: new Interval(0.4, 0.9)));
    fadeAnimPlanet3.addListener(() {
      setState(() {});
    });
    fadeAnimPlanet4 = new Tween(begin: 0.0, end: 1.0).animate(
        new CurvedAnimation(
            parent: animControlPlanet, curve: new Interval(0.6, 1.0)));
    fadeAnimPlanet4.addListener(() {
      setState(() {});
    });
    sizeAnimPlanet1 = new Tween(begin: 0.0, end: 100.0).animate(
        new CurvedAnimation(
            parent: animControlPlanet, curve: new Interval(0.0, 0.5)));
    sizeAnimPlanet1.addListener(() {
      setState(() {});
    });
    sizeAnimPlanet2 = new Tween(begin: 0.0, end: 100.0).animate(
        new CurvedAnimation(
            parent: animControlPlanet, curve: new Interval(0.2, 0.7)));
    sizeAnimPlanet2.addListener(() {
      setState(() {});
    });
    sizeAnimPlanet3 = new Tween(begin: 0.0, end: 100.0).animate(
        new CurvedAnimation(
            parent: animControlPlanet, curve: new Interval(0.4, 0.9)));
    sizeAnimPlanet3.addListener(() {
      setState(() {});
    });
    sizeAnimPlanet4 = new Tween(begin: 0.0, end: 100.0).animate(
        new CurvedAnimation(
            parent: animControlPlanet, curve: new Interval(0.6, 1.0)));
    sizeAnimPlanet4.addListener(() {
      setState(() {});
    });

    // Background
    animControlBg = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 5000));
    animControlBg.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animControlBg.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animControlBg.forward();
      }
    });
    colorAnimBgStart =
        new ColorTween(begin: gradientStartFrom, end: gradientStartTo)
            .animate(animControlBg);
    colorAnimBgEnd = new ColorTween(begin: gradientEndFrom, end: gradientEndTo)
        .animate(animControlBg);

    // Let's go
    animControlStar.forward();
    animControlPlanet.forward();
    animControlBg.forward();
  }

  @override
  void dispose() {
    animControlStar.dispose();
    animControlPlanet.dispose();
    animControlBg.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = durationSlowMode;

    return new Stack(
      children: <Widget>[
        new Container(
            width: double.infinity,
            height: double.infinity,
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [colorAnimBgStart.value, colorAnimBgEnd.value],
                    begin: new FractionalOffset(0.0, 0.5),
                    end: new FractionalOffset(0.5, 1.0),
                    tileMode: TileMode.mirror)),
            child: buildGroupStar()),
      ],
    );
  }
}

class Star {
  // angle should be value 0.0 -> 1.0
  // left 0.0 -> 360.0
  // height 0.0 -> 640.0
  // typeFade 1 -> 4

  double left;
  double top;
  double extraSize;
  double angle;
  int typeFade;

  Star(
      {required this.left,
      required this.top,
      required this.extraSize,
      required this.angle,
      required this.typeFade});
}
