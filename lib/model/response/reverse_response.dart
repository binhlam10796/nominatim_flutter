class NominatimResponse {
  /// Reference to the Nominatim internal database ID
  /// See https://nominatim.org/release-docs/latest/api/Output/#place_id-is-not-a-persistent-id
  int? placeId;
  String? licence;

  /// Reference to the OSM object
  String? osmType;

  /// Reference to the OSM object
  int? osmId;

  /// Latitude of the centroid of the object
  String? lat;

  /// Longitude of the centroid of the object
  String? lon;

  /// Classification of location
  String? addressClass;

  /// Key of the main OSM tag
  String? category;

  /// Value of the main OSM tag
  String? type;

  /// Search rank of the object
  int? placeRank;

  /// Computed importance rank
  double? importance;

  /// Type of the location: road, place, etc..
  String? addresstype;

  /// Name of the location
  String? name;

  /// Full comma-separated address
  String? displayName;

  /// Map of address details
  /// Only with [reverse(addressDetails: true)]
  /// See https://nominatim.org/release-docs/latest/api/Output/#addressdetails
  Map<String, dynamic>? address;

  /// Map with additional useful tags like website or max speed
  /// Only with [reverse(extraTags: true)]
  Map<String, dynamic>? extraTags;

  /// Map with full list of available names including ref etc.
  /// Only with [reverse(nameDetails: true)]
  Map<String, dynamic>? nameDetails;

  /// Area of corner coordinates
  /// See https://nominatim.org/release-docs/latest/api/Output/#boundingbox
  List<String>? boundingbox;

  NominatimResponse({
    this.placeId,
    this.licence,
    this.osmType,
    this.osmId,
    this.lat,
    this.lon,
    this.addressClass,
    this.category,
    this.type,
    this.placeRank,
    this.importance,
    this.addresstype,
    this.name,
    this.displayName,
    this.address,
    this.extraTags,
    this.nameDetails,
    this.boundingbox,
  });

  NominatimResponse.fromJson(Map<String, dynamic> json) {
    placeId = json['place_id'];
    licence = json['licence'];
    osmType = json['osm_type'];
    osmId = json['osm_id'];
    lat = json['lat'];
    lon = json['lon'];
    addressClass = json['class'];
    category = json['category'];
    type = json['type'];
    placeRank = json['place_rank'];
    importance = json['importance'];
    addresstype = json['addresstype'];
    name = json['name'];
    displayName = json['display_name'];
    address = json['address'] != null
        ? json['address'] as Map<String, dynamic>
        : null;
    extraTags = json['extratags'] != null
        ? json['extratags'] as Map<String, dynamic>
        : null;
    nameDetails = json['namedetails'] != null
        ? json['namedetails'] as Map<String, dynamic>
        : null;
    boundingbox = json['boundingbox'].cast<String>();
  }

  @override
  String toString() {
    return 'ReverseResponse: {\n'
        '  placeId: $placeId,\n'
        '  licence: $licence,\n'
        '  osmType: $osmType,\n'
        '  osmId: $osmId,\n'
        '  lat: $lat,\n'
        '  lon: $lon,\n'
        '  category: $category,\n'
        '  type: $type,\n'
        '  placeRank: $placeRank,\n'
        '  importance: $importance,\n'
        '  addresstype: $addresstype,\n'
        '  name: $name,\n'
        '  displayName: $displayName,\n'
        '  address: $address,\n'
        '  extratags: $extraTags,\n'
        '  namedetails: $nameDetails,\n'
        '  boundingbox: $boundingbox\n'
        '}';
  }
}

class Extratags {
  /// The number of lanes on a road.
  String? lanes;

  /// Indicates if the road is a one-way street.
  String? oneway;

  /// The surface type of the road.
  String? surface;

  /// The maximum speed in lanes on the road.
  String? maxspeedLanes;

  /// The minimum speed in lanes on the road.
  String? minspeedLanes;

  Extratags({
    this.lanes,
    this.oneway,
    this.surface,
    this.maxspeedLanes,
    this.minspeedLanes,
  });

  Extratags.fromJson(Map<String, dynamic> json) {
    lanes = json['lanes'];
    oneway = json['oneway'];
    surface = json['surface'];
    maxspeedLanes = json['maxspeed:lanes'];
    minspeedLanes = json['minspeed:lanes'];
  }

  @override
  String toString() {
    return 'Extratags: {\n'
        '  lanes: $lanes,\n'
        '  oneway: $oneway,\n'
        '  surface: $surface,\n'
        '  maxspeedLanes: $maxspeedLanes,\n'
        '  minspeedLanes: $minspeedLanes\n'
        '}';
  }
}

class Namedetails {
  /// A reference associated with the named details.
  String? ref;

  /// The primary name.
  String? name;

  /// The name in Spanish language.
  String? nameEs;

  /// An alternate name.
  String? altName;

  /// A regional name.
  String? regName;

  /// A short name.
  String? shortName;

  /// The official name.
  String? officialName;

  Namedetails({
    this.ref,
    this.name,
    this.nameEs,
    this.altName,
    this.regName,
    this.shortName,
    this.officialName,
  });

  Namedetails.fromJson(Map<String, dynamic> json) {
    ref = json['ref'];
    name = json['name'];
    nameEs = json['name:es'];
    altName = json['alt_name'];
    regName = json['reg_name'];
    shortName = json['short_name'];
    officialName = json['official_name'];
  }

  @override
  String toString() {
    return 'Namedetails: {\n'
        '  ref: $ref,\n'
        '  name: $name,\n'
        '  nameEs: $nameEs,\n'
        '  altName: $altName,\n'
        '  regName: $regName,\n'
        '  shortName: $shortName,\n'
        '  officialName: $officialName\n'
        '}';
  }
}
