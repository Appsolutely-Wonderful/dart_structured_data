import 'dart:io';

import '../lib/src/objects/structured_data.dart';
import '../lib/src/utils/json_ld_parser.dart';
import 'package:html/parser.dart';
import 'package:test/test.dart';

void main() {
  test("Running microdata", () {
    var jsonLdFile =
        File("test/test_inputs/pasta_salad_json_ld.html").readAsStringSync();
    var jsonLdString = parse(jsonLdFile);
    List<StructuredData> data = JsonLdParser.extractJsonLd(jsonLdString);
    data.forEach((element) {
      print("Found ${element.schemaType}");
    });
  });
}
