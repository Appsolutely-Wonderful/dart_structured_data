import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:html/dom.dart';
import 'package:html/parser.dart';

import '../objects/structured_data.dart';
import '../utils/structured_data_parser.dart';

/// Contains functions for importing structured data
/// from remote sources
class StructuredDataImporter {
  /// Extracts structured data from the given web page URL
  static Future<List<StructuredData>> importUrl(String url) async {
    var response = await http.get(url);
    Document doc = parse(response.body);
    return StructuredDataParser.extract(doc);
  }
}
