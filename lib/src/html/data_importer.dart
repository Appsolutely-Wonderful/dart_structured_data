import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:html/dom.dart';
import 'package:html/parser.dart';

import '../objects/structured_data.dart';
import '../utils/generic_parser.dart';

class StructuredDataImporter {
  StructuredDataImporter();

  static Future<List<StructuredData>> importUrl(String url) async {
    HttpClient client = new HttpClient();
    HttpClientRequest req = await client.getUrl(Uri.parse(url));
    HttpClientResponse response = await req.close();

    String documentString = "";
    await for (String chunk in response.transform(utf8.decoder)) {
      documentString += chunk;
    }
    Document doc = parse(documentString);
    return GenericParser.extractStructuredData(doc);
  }
}
