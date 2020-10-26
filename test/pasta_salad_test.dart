import 'dart:io';

import '../lib/src/objects/structured_data.dart';
import '../lib/src/utils/json_ld_parser.dart';
import 'package:html/parser.dart';
import 'package:test/test.dart';

void main() {
  test("Loading pasta json-ld", () {
    var jsonLdFile =
        File("test/test_inputs/pasta_salad_json_ld.html").readAsStringSync();
    var jsonLdString = parse(jsonLdFile);
    List<StructuredData> data = JsonLdParser.extractJsonLd(jsonLdString);
    expect(data[0].schemaType, 'Organization');
    expect(data[1].schemaType, 'WebSite');
    expect(data[2].schemaType, 'ImageObject');
    expect(data[3].schemaType, 'WebPage');
    expect(data[4].schemaType, 'Article');
    expect(data[5].schemaType, 'Person');
    expect(data[6].schemaType, 'Recipe');
  });
}
