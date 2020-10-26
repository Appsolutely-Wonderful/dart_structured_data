import 'dart:convert';

import 'package:html/dom.dart';
import 'package:structured_data/src/utils/parser_helper.dart';

import '../objects/structured_data.dart';
import 'html_parser.dart';

class JsonLdParser {
  static List<StructuredData> extractJsonLd(Document document) {
    var scopes = HtmlQuery.findJsonLds(document);
    List<StructuredData> items = List<StructuredData>();
    scopes.forEach((itemscope) {
      var data = jsonDecode(itemscope.text);
      if (data is List) {
        items = _extractDataFromList(data);
      } else {
        if ((data is Map) && data.containsKey('@graph')) {
          items = _extractDataFromList(data['@graph']);
        } else {
          StructuredData schema = _extractStructuredData(data);
          items.add(schema);
        }
      }
    });

    return items;
  }

  static List<StructuredData> _extractDataFromList(List data) {
    List<StructuredData> items = List<StructuredData>();
    data.forEach((element) {
      StructuredData schema = _extractStructuredData(element);
      items.add(schema);
    });
    return items;
  }

  static StructuredData _extractStructuredData(Map<String, dynamic> jsonObj) {
    StructuredData schema =
        StructuredData(ParserHelper.stripProperty(jsonObj["@type"]));
    jsonObj.keys.forEach((property) {
      if (!_shouldIgnoreProp(property)) {
        var propertyData = jsonObj[property];

        // If it's a map, then parse it as a structured data object
        if (propertyData is Map) {
          StructuredData structuredProperty =
              _extractStructuredData(propertyData);
          schema.addData(property, structuredProperty);
        } else if (propertyData is String) {
          // For a string, strip out any extra data
          schema.addData(property, ParserHelper.stripProperty(propertyData));
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
