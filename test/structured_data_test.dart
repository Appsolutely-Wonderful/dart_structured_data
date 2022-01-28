import 'dart:io';

import 'package:html/parser.dart';
import 'package:structured_data/src/utils/microdata_parser.dart';
import 'package:structured_data/structured_data.dart';
import 'package:test/test.dart';

void main() {
  test('Test sending structured data to and from json', () {
    var microdata = File("test/test_inputs/microdata.html").readAsStringSync();
    var htmlMicrodata = parse(microdata);
    List<StructuredData> data = MicrodataParser.extractMicrodata(htmlMicrodata);
    var testRecipe = data[0];
    var json = testRecipe.toJson();
    testRecipe.keys.forEach((key) {
      expect(json.containsKey(key), true);
      expect(json.containsKey('schemaType'), true);
    });
    var rebuiltData = StructuredData.fromJson(json);
    testRecipe.keys.forEach((key) {
      expect(rebuiltData.keys.contains(key), true);
      if (rebuiltData[key] is StructuredData) {
        expect(
            (rebuiltData[key] as StructuredData).schemaType ==
                testRecipe[key].schemaType,
            true);
      } else {
        expect(rebuiltData[key], testRecipe[key]);
      }
    });
  });
}
