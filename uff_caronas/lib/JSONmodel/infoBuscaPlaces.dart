// To parse this JSON data, do
//
//     final infoBuscaPlaces = infoBuscaPlacesFromJson(jsonString);

import 'dart:convert';

List<InfoBuscaPlaces> infoBuscaPlacesFromJson(String str) => List<InfoBuscaPlaces>.from(json.decode(str).map((x) => InfoBuscaPlaces.fromJson(x)));

String infoBuscaPlacesToJson(List<InfoBuscaPlaces> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InfoBuscaPlaces {
    Geometry? geometry;
    String? type;
    Properties? properties;

    InfoBuscaPlaces({
        this.geometry,
        this.type,
        this.properties,
    });

    factory InfoBuscaPlaces.fromJson(Map<String, dynamic> json) => InfoBuscaPlaces(
        geometry: json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]),
        type: json["type"],
        properties: json["properties"] == null ? null : Properties.fromJson(json["properties"]),
    );

    Map<String, dynamic> toJson() => {
        "geometry": geometry?.toJson(),
        "type": type,
        "properties": properties?.toJson(),
    };
}

class Geometry {
    List<double>? coordinates;
    String? type;

    Geometry({
        this.coordinates,
        this.type,
    });

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
        "type": type,
    };
}

class Properties {
    int? osmId;
    List<double>? extent;
    String? country;
    String? city;
    String? countrycode;
    String? postcode;
    String? county;
    String? type;
    String? osmType;
    String? osmKey;
    String? district;
    String? osmValue;
    String? name;
    String? locality;

    Properties({
        this.osmId,
        this.extent,
        this.country,
        this.city,
        this.countrycode,
        this.postcode,
        this.county,
        this.type,
        this.osmType,
        this.osmKey,
        this.district,
        this.osmValue,
        this.name,
        this.locality,
    });

    factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        osmId: json["osm_id"],
        extent: json["extent"] == null ? [] : List<double>.from(json["extent"]!.map((x) => x?.toDouble())),
        country: json["country"],
        city: json["city"],
        countrycode: json["countrycode"],
        postcode: json["postcode"],
        county: json["county"],
        type: json["type"],
        osmType: json["osm_type"],
        osmKey: json["osm_key"],
        district: json["district"],
        osmValue: json["osm_value"],
        name: json["name"],
        locality: json["locality"],
    );

    Map<String, dynamic> toJson() => {
        "osm_id": osmId,
        "extent": extent == null ? [] : List<dynamic>.from(extent!.map((x) => x)),
        "country": country,
        "city": city,
        "countrycode": countrycode,
        "postcode": postcode,
        "county": county,
        "type": type,
        "osm_type": osmType,
        "osm_key": osmKey,
        "district": district,
        "osm_value": osmValue,
        "name": name,
        "locality": locality,
    };
}
