// To parse this JSON data, do
//
//     final asteroid = asteroidFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Asteroid asteroidFromJson(String str) => Asteroid.fromJson(json.decode(str));

String asteroidToJson(Asteroid data) => json.encode(data.toJson());

class Asteroid {
  Asteroid({
    required this.links,
    required this.elementCount,
    required this.nearEarthObjects,
  });

  AsteroidLinks links;
  int elementCount;
  Map<String, List<NearEarthObject>> nearEarthObjects;

  factory Asteroid.fromJson(Map<String, dynamic> json) => Asteroid(
        links: AsteroidLinks.fromJson(json["links"]),
        elementCount: json["element_count"],
        nearEarthObjects: Map.from(json["near_earth_objects"]).map((k, v) =>
            MapEntry<String, List<NearEarthObject>>(
                k,
                List<NearEarthObject>.from(
                    v.map((x) => NearEarthObject.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "links": links.toJson(),
        "element_count": elementCount,
        "near_earth_objects": Map.from(nearEarthObjects).map((k, v) =>
            MapEntry<String, dynamic>(
                k, List<dynamic>.from(v.map((x) => x.toJson())))),
      };
}

class AsteroidLinks {
  AsteroidLinks({
    required this.next,
    required this.prev,
    required this.self,
  });

  String next;
  String prev;
  String self;

  factory AsteroidLinks.fromJson(Map<String, dynamic> json) => AsteroidLinks(
        next: json["next"],
        prev: json["prev"],
        self: json["self"],
      );

  Map<String, dynamic> toJson() => {
        "next": next,
        "prev": prev,
        "self": self,
      };
}

class NearEarthObject {
  NearEarthObject({
    required this.links,
    required this.id,
    required this.neoReferenceId,
    required this.name,
    required this.nasaJplUrl,
    required this.absoluteMagnitudeH,
    required this.estimatedDiameter,
    required this.isPotentiallyHazardousAsteroid,
    required this.closeApproachData,
    required this.orbitalData,
    required this.isSentryObject,
  });

  NearEarthObjectLinks links;
  String id;
  String neoReferenceId;
  String name;
  String nasaJplUrl;
  double absoluteMagnitudeH;
  EstimatedDiameter estimatedDiameter;
  bool isPotentiallyHazardousAsteroid;
  List<CloseApproachDatum> closeApproachData;
  OrbitalData orbitalData;
  bool isSentryObject;

  factory NearEarthObject.fromJson(Map<String, dynamic> json) =>
      NearEarthObject(
        links: NearEarthObjectLinks.fromJson(json["links"]),
        id: json["id"],
        neoReferenceId: json["neo_reference_id"],
        name: json["name"],
        nasaJplUrl: json["nasa_jpl_url"],
        absoluteMagnitudeH: json["absolute_magnitude_h"].toDouble(),
        estimatedDiameter:
            EstimatedDiameter.fromJson(json["estimated_diameter"]),
        isPotentiallyHazardousAsteroid:
            json["is_potentially_hazardous_asteroid"],
        closeApproachData: List<CloseApproachDatum>.from(
            json["close_approach_data"]
                .map((x) => CloseApproachDatum.fromJson(x))),
        orbitalData: OrbitalData.fromJson(json["orbital_data"]),
        isSentryObject: json["is_sentry_object"],
      );

  Map<String, dynamic> toJson() => {
        "links": links.toJson(),
        "id": id,
        "neo_reference_id": neoReferenceId,
        "name": name,
        "nasa_jpl_url": nasaJplUrl,
        "absolute_magnitude_h": absoluteMagnitudeH,
        "estimated_diameter": estimatedDiameter.toJson(),
        "is_potentially_hazardous_asteroid": isPotentiallyHazardousAsteroid,
        "close_approach_data":
            List<dynamic>.from(closeApproachData.map((x) => x.toJson())),
        "orbital_data": orbitalData.toJson(),
        "is_sentry_object": isSentryObject,
      };
}

class CloseApproachDatum {
  CloseApproachDatum({
    required this.closeApproachDate,
    required this.closeApproachDateFull,
    required this.epochDateCloseApproach,
    required this.relativeVelocity,
    required this.missDistance,
    required this.orbitingBody,
  });

  DateTime closeApproachDate;
  String closeApproachDateFull;
  int epochDateCloseApproach;
  RelativeVelocity relativeVelocity;
  MissDistance missDistance;
  String orbitingBody;

  factory CloseApproachDatum.fromJson(Map<String, dynamic> json) =>
      CloseApproachDatum(
        closeApproachDate: DateTime.parse(json["close_approach_date"]),
        closeApproachDateFull: json["close_approach_date_full"],
        epochDateCloseApproach: json["epoch_date_close_approach"],
        relativeVelocity: RelativeVelocity.fromJson(json["relative_velocity"]),
        missDistance: MissDistance.fromJson(json["miss_distance"]),
        orbitingBody: orbitingBodyValues.map[json["orbiting_body"]].toString(),
      );

  Map<String, dynamic> toJson() => {
        "close_approach_date":
            "${closeApproachDate.year.toString().padLeft(4, '0')}-${closeApproachDate.month.toString().padLeft(2, '0')}-${closeApproachDate.day.toString().padLeft(2, '0')}",
        "close_approach_date_full": closeApproachDateFull,
        "epoch_date_close_approach": epochDateCloseApproach,
        "relative_velocity": relativeVelocity.toJson(),
        "miss_distance": missDistance.toJson(),
        "orbiting_body": orbitingBodyValues.reverse[orbitingBody],
      };
}

class MissDistance {
  MissDistance({
    required this.astronomical,
    required this.lunar,
    required this.kilometers,
    required this.miles,
  });

  String astronomical;
  String lunar;
  String kilometers;
  String miles;

  factory MissDistance.fromJson(Map<String, dynamic> json) => MissDistance(
        astronomical: json["astronomical"],
        lunar: json["lunar"],
        kilometers: json["kilometers"],
        miles: json["miles"],
      );

  Map<String, dynamic> toJson() => {
        "astronomical": astronomical,
        "lunar": lunar,
        "kilometers": kilometers,
        "miles": miles,
      };
}

enum OrbitingBody { EARTH }

final orbitingBodyValues = EnumValues({"Earth": OrbitingBody.EARTH});

class RelativeVelocity {
  RelativeVelocity({
    required this.kilometersPerSecond,
    required this.kilometersPerHour,
    required this.milesPerHour,
  });

  String kilometersPerSecond;
  String kilometersPerHour;
  String milesPerHour;

  factory RelativeVelocity.fromJson(Map<String, dynamic> json) =>
      RelativeVelocity(
        kilometersPerSecond: json["kilometers_per_second"],
        kilometersPerHour: json["kilometers_per_hour"],
        milesPerHour: json["miles_per_hour"],
      );

  Map<String, dynamic> toJson() => {
        "kilometers_per_second": kilometersPerSecond,
        "kilometers_per_hour": kilometersPerHour,
        "miles_per_hour": milesPerHour,
      };
}

class EstimatedDiameter {
  EstimatedDiameter({
    required this.kilometers,
    required this.meters,
    required this.miles,
    required this.feet,
  });

  Feet kilometers;
  Feet meters;
  Feet miles;
  Feet feet;

  factory EstimatedDiameter.fromJson(Map<String, dynamic> json) =>
      EstimatedDiameter(
        kilometers: Feet.fromJson(json["kilometers"]),
        meters: Feet.fromJson(json["meters"]),
        miles: Feet.fromJson(json["miles"]),
        feet: Feet.fromJson(json["feet"]),
      );

  Map<String, dynamic> toJson() => {
        "kilometers": kilometers.toJson(),
        "meters": meters.toJson(),
        "miles": miles.toJson(),
        "feet": feet.toJson(),
      };
}

class Feet {
  Feet({
    required this.estimatedDiameterMin,
    required this.estimatedDiameterMax,
  });

  double estimatedDiameterMin;
  double estimatedDiameterMax;

  factory Feet.fromJson(Map<String, dynamic> json) => Feet(
        estimatedDiameterMin: json["estimated_diameter_min"].toDouble(),
        estimatedDiameterMax: json["estimated_diameter_max"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "estimated_diameter_min": estimatedDiameterMin,
        "estimated_diameter_max": estimatedDiameterMax,
      };
}

class NearEarthObjectLinks {
  NearEarthObjectLinks({
    required this.self,
  });

  String self;

  factory NearEarthObjectLinks.fromJson(Map<String, dynamic> json) =>
      NearEarthObjectLinks(
        self: json["self"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
      };
}

class OrbitalData {
  OrbitalData({
    required this.orbitId,
    required this.orbitDeterminationDate,
    required this.firstObservationDate,
    required this.lastObservationDate,
    required this.dataArcInDays,
    required this.observationsUsed,
    required this.orbitUncertainty,
    required this.minimumOrbitIntersection,
    required this.jupiterTisserandInvariant,
    required this.epochOsculation,
    required this.eccentricity,
    required this.semiMajorAxis,
    required this.inclination,
    required this.ascendingNodeLongitude,
    required this.orbitalPeriod,
    required this.perihelionDistance,
    required this.perihelionArgument,
    required this.aphelionDistance,
    required this.perihelionTime,
    required this.meanAnomaly,
    required this.meanMotion,
    required this.equinox,
    required this.orbitClass,
  });

  String orbitId;
  DateTime orbitDeterminationDate;
  DateTime firstObservationDate;
  DateTime lastObservationDate;
  int dataArcInDays;
  int observationsUsed;
  String orbitUncertainty;
  String minimumOrbitIntersection;
  String jupiterTisserandInvariant;
  String epochOsculation;
  String eccentricity;
  String semiMajorAxis;
  String inclination;
  String ascendingNodeLongitude;
  String orbitalPeriod;
  String perihelionDistance;
  String perihelionArgument;
  String aphelionDistance;
  String perihelionTime;
  String meanAnomaly;
  String meanMotion;
  String equinox;
  OrbitClass orbitClass;

  factory OrbitalData.fromJson(Map<String, dynamic> json) => OrbitalData(
        orbitId: json["orbit_id"],
        orbitDeterminationDate:
            DateTime.parse(json["orbit_determination_date"]),
        firstObservationDate: DateTime.parse(json["first_observation_date"]),
        lastObservationDate: DateTime.parse(json["last_observation_date"]),
        dataArcInDays: json["data_arc_in_days"],
        observationsUsed: json["observations_used"],
        orbitUncertainty: json["orbit_uncertainty"],
        minimumOrbitIntersection: json["minimum_orbit_intersection"],
        jupiterTisserandInvariant: json["jupiter_tisserand_invariant"],
        epochOsculation: json["epoch_osculation"],
        eccentricity: json["eccentricity"],
        semiMajorAxis: json["semi_major_axis"],
        inclination: json["inclination"],
        ascendingNodeLongitude: json["ascending_node_longitude"],
        orbitalPeriod: json["orbital_period"],
        perihelionDistance: json["perihelion_distance"],
        perihelionArgument: json["perihelion_argument"],
        aphelionDistance: json["aphelion_distance"],
        perihelionTime: json["perihelion_time"],
        meanAnomaly: json["mean_anomaly"],
        meanMotion: json["mean_motion"],
        equinox: equinoxValues.map[json["equinox"]].toString(),
        orbitClass: OrbitClass.fromJson(json["orbit_class"]),
      );

  Map<String, dynamic> toJson() => {
        "orbit_id": orbitId,
        "orbit_determination_date": orbitDeterminationDate.toIso8601String(),
        "first_observation_date":
            "${firstObservationDate.year.toString().padLeft(4, '0')}-${firstObservationDate.month.toString().padLeft(2, '0')}-${firstObservationDate.day.toString().padLeft(2, '0')}",
        "last_observation_date":
            "${lastObservationDate.year.toString().padLeft(4, '0')}-${lastObservationDate.month.toString().padLeft(2, '0')}-${lastObservationDate.day.toString().padLeft(2, '0')}",
        "data_arc_in_days": dataArcInDays,
        "observations_used": observationsUsed,
        "orbit_uncertainty": orbitUncertainty,
        "minimum_orbit_intersection": minimumOrbitIntersection,
        "jupiter_tisserand_invariant": jupiterTisserandInvariant,
        "epoch_osculation": epochOsculation,
        "eccentricity": eccentricity,
        "semi_major_axis": semiMajorAxis,
        "inclination": inclination,
        "ascending_node_longitude": ascendingNodeLongitude,
        "orbital_period": orbitalPeriod,
        "perihelion_distance": perihelionDistance,
        "perihelion_argument": perihelionArgument,
        "aphelion_distance": aphelionDistance,
        "perihelion_time": perihelionTime,
        "mean_anomaly": meanAnomaly,
        "mean_motion": meanMotion,
        "equinox": equinoxValues.reverse[equinox],
        "orbit_class": orbitClass.toJson(),
      };
}

enum Equinox { J2000 }

final equinoxValues = EnumValues({"J2000": Equinox.J2000});

class OrbitClass {
  OrbitClass({
    required this.orbitClassType,
    required this.orbitClassDescription,
    required this.orbitClassRange,
  });

  String orbitClassType;
  String orbitClassDescription;
  String orbitClassRange;

  factory OrbitClass.fromJson(Map<String, dynamic> json) => OrbitClass(
        orbitClassType:
            orbitClassTypeValues.map[json["orbit_class_type"]].toString(),
        orbitClassDescription: json["orbit_class_description"],
        orbitClassRange:
            orbitClassRangeValues.map[json["orbit_class_range"]].toString(),
      );

  Map<String, dynamic> toJson() => {
        "orbit_class_type": orbitClassTypeValues.reverse[orbitClassType],
        "orbit_class_description": orbitClassDescription,
        "orbit_class_range": orbitClassRangeValues.reverse[orbitClassRange],
      };
}

enum OrbitClassRange {
  THE_1017_AU_Q_PERIHELION_13_AU,
  A_SEMI_MAJOR_AXIS_10_AU_Q_PERIHELION_0983_AU,
  A_SEMI_MAJOR_AXIS_10_AU_Q_PERIHELION_1017_AU
}

final orbitClassRangeValues = EnumValues({
  "a (semi-major axis) < 1.0 AU; q (perihelion) > 0.983 AU":
      OrbitClassRange.A_SEMI_MAJOR_AXIS_10_AU_Q_PERIHELION_0983_AU,
  "a (semi-major axis) > 1.0 AU; q (perihelion) < 1.017 AU":
      OrbitClassRange.A_SEMI_MAJOR_AXIS_10_AU_Q_PERIHELION_1017_AU,
  "1.017 AU < q (perihelion) < 1.3 AU":
      OrbitClassRange.THE_1017_AU_Q_PERIHELION_13_AU
});

enum OrbitClassType { AMO, ATE, APO }

final orbitClassTypeValues = EnumValues({
  "AMO": OrbitClassType.AMO,
  "APO": OrbitClassType.APO,
  "ATE": OrbitClassType.ATE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
