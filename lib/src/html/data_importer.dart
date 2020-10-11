import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:html/dom.dart';
import 'package:html/parser.dart';

import '../objects/structured_data.dart';
import '../utils/generic_parser.dart';

class DataImporter {
  DataImporter();

  static Future<List<StructuredData>> importUrl() async {
    HttpClient client = new HttpClient();
    print("Importing data");
    HttpClientRequest req = await client.getUrl(Uri.parse(
        "https://www.foodnetwork.com/recipes/food-network-kitchen/the-best-pot-roast-7434330"));
    HttpClientResponse response = await req.close();

    String documentString = "";
    await for (String chunk in response.transform(utf8.decoder)) {
      documentString += chunk;
    }
    Document doc = parse(documentString);
    return GenericParser.extractStructuredData(doc);
  }
}
