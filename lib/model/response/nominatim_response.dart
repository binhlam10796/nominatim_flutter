/// Represents the response from the Nominatim reverse geocoding API.
///
/// This class contains various details about a location, including its
/// coordinates, classification, and additional metadata.
///
/// For more information, refer to the [Nominatim API documentation](https://nominatim.org/release-docs/latest/api/Output/).
class NominatimResponse {
  /// The internal database ID used by Nominatim.
  ///
  /// Note: This ID is not persistent and may change over time.
  /// See [Nominatim place_id documentation](https://nominatim.org/release-docs/latest/api/Output/#place_id-is-not-a-persistent-id).
  int? placeId;

  /// The licence under which the data is provided.
  String? licence;

  /// The type of the OpenStreetMap (OSM) object (e.g., node, way, relation).
  String? osmType;

  /// The ID of the OSM object.
  int? osmId;

  /// The latitude of the centroid of the object.
  String? lat;

  /// The longitude of the centroid of the object.
  String? lon;

  /// The classification of the location (e.g., building, road).
  String? addressClass;

  /// The main category of the OSM tag.
  String? category;

  /// The specific type of the OSM tag.
  String? type;

  /// The search rank of the object.
  int? placeRank;

  /// The computed importance rank of the location.
  double? importance;

  /// The type of the location (e.g., road, place).
  String? addresstype;

  /// The name of the location.
  String? name;

  /// The full comma-separated address of the location.
  String? displayName;

  /// A map containing detailed address information.
  ///
  /// This is available only when `reverse(addressDetails: true)` is used.
  /// See [Nominatim address details documentation](https://nominatim.org/release-docs/latest/api/Output/#addressdetails).
  Map<String, dynamic>? address;

  /// A map containing additional useful tags such as website or max speed.
  ///
  /// This is available only when `reverse(extraTags: true)` is used.
  Map<String, dynamic>? extraTags;

  /// A map containing a full list of available names, including references.
  ///
  /// This is available only when `reverse(nameDetails: true)` is used.
  Map<String, dynamic>? nameDetails;

  /// A list of corner coordinates defining the bounding box of the area.
  ///
  /// See [Nominatim bounding box documentation](https://nominatim.org/release-docs/latest/api/Output/#boundingbox).
  List<String>? boundingbox;

  /// Constructs a [NominatimResponse] instance.
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

  /// Constructs a [NominatimResponse] instance from a JSON object.
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

/// Represents additional tags for a location, such as road attributes.
///
/// This class contains details like the number of lanes, whether the road
/// is a one-way street, the surface type, and speed limits.
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

  /// Constructs an [Extratags] instance.
  Extratags({
    this.lanes,
    this.oneway,
    this.surface,
    this.maxspeedLanes,
    this.minspeedLanes,
  });

  /// Constructs an [Extratags] instance from a JSON object.
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

/// Represents detailed names for a location, including alternate and regional names.
///
/// This class contains various names associated with a location, such as
/// the primary name, alternate names, regional names, and official names.
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

  /// Constructs a [Namedetails] instance.
  Namedetails({
    this.ref,
    this.name,
    this.nameEs,
    this.altName,
    this.regName,
    this.shortName,
    this.officialName,
  });

  /// Constructs a [Namedetails] instance from a JSON object.
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
