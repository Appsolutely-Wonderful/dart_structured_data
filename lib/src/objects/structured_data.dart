/// Represents a generic schema object
class StructuredData {
  StructuredData(this.schemaType);

  final String schemaType;
  Map<String, dynamic> _data = Map<String, dynamic>();

  dynamic operator [](String key) => _data[key];

  /// Retrieves all properties that have been added to this object
  Iterable<String> get keys => _data.keys;

  /// Adds property data to the structured data
  /// It can later be accessed through obj["property"]
  ///
  /// If a single property is provided multiple times, the property
  /// becomes a List
  addData(String propertyName, dynamic propertyData) {
    // If the property is being added multiple times, then it becomes
    // a list attribute.
    var cleanData = _cleanData(propertyData);
    if (_data.containsKey(propertyName)) {
      _convertPropertyToList(propertyName);
      // Now that the property is a list, add the 2nd property
      _data[propertyName].add(cleanData);
    } else {
      // Otherwise this is the first time the property is being added.
      // just add it to the list.
      _data[propertyName] = cleanData;
    }
  }

  _convertPropertyToList(String property) {
    var is_list = _data[property] is List;

    if (!is_list) {
      var tmp = _data[property];
      _data[property] = List<dynamic>();
      _data[property].add(tmp);
    }
  }

  dynamic _cleanData(dynamic property) {
    if (property is String) {
      return property.trim();
    } else {
      return property;
    }
  }

  @override
  String toString() {
    return "StructuredData<$schemaType>";
  }

  List<dynamic> _jsonifyList(List list) {
    if (list[0] is StructuredData) {
      return list.map((e) => (e as StructuredData).toJson()).toList();
    }
    if (list[0] is List) {
      return list.map((e) => _jsonifyList(e)).toList();
    }
    if (list[0] is Map) {
      return list.map((e) => _jsonifyMap(e)).toList();
    }
    return list;
  }

  Map<String, dynamic> _jsonifyMap(Map<String, dynamic> map) {
    var json = Map<String, dynamic>();
    map.forEach((key, value) {
      if (value is StructuredData) {
        json[key] = value.toJson();
      } else if (value is List) {
        json[key] = _jsonifyList(value);
      } else if (value is Map) {
        json[key] = _jsonifyMap(value);
      } else {
        json[key] = value;
      }
    });
    return json;
  }

  dynamic _objectifyMap(Map map) {
    if (map.containsKey('schemaType')) {
      return StructuredData.fromJson(map);
    }
    return map;
  }

  List _objectifyList(List list) {
    return list.map((e) {
      if (e is Map) {
        return _objectifyMap(e);
      }
      if (e is List) {
        return _objectifyList(e);
      }
      return e;
    }).toList();
  }

  Map<String, dynamic> toJson() {
    var json = _jsonifyMap(_data);
    json['schemaType'] = schemaType;
    return json;
  }

  StructuredData.fromJson(Map<String, dynamic> json)
      : assert(json.containsKey('schemaType')),
        schemaType = json['schemaType'] {
    json.forEach((key, value) {
      if (value is List) {
        _data[key] = _objectifyList(value);
      } else if (value is Map) {
        _data[key] = _objectifyMap(value);
      } else {
        _data[key] = value;
      }
    });
  }
}
