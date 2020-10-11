import 'dart:convert';

import 'package:dart_recipe_schema/src/objects/structured_data.dart';
import 'package:dart_recipe_schema/src/utils/parser.dart';
import 'package:html/dom.dart';

class JsonLdParser {
  static List<StructuredData> extractJsonLd(Document document) {
    var scopes = HtmlParser.findJsonLds(document);
    List<StructuredData> items = List<StructuredData>();
    scopes.forEach((itemscope) {
      var data = jsonDecode(itemscope.text);
      StructuredData schema = _extractStructuredData(data);
      items.add(schema);
    });

    return items;
  }

  static StructuredData _extractStructuredData(Map<String, dynamic> jsonObj) {
    StructuredData schema = StructuredData(jsonObj["@type"]);

    jsonObj.keys.forEach((property) {
      if (!_shouldIgnoreProp(property)) {
        var propertyData = jsonObj[property];

        // If it's a map, then parse it as a structured data object
        if (propertyData is Map) {
          StructuredData structuredProperty =
              _extractStructuredData(propertyData);
          schema.addData(property, structuredProperty);
        } else {
          schema.addData(property, propertyData);
        }
      }
    });

    return schema;
  }

  static bool _shouldIgnoreProp(String prop) {
    switch (prop) {
      case "@context":
      case "@type":
        return true;
      default:
        return false;
    }
  }
}
