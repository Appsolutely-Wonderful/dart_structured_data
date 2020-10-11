import 'dart:io';

import 'package:structured_data/structured_data.dart';
import 'package:html/parser.dart';

fromUrlExample() async {
  // Import data from a remote web page
  List<StructuredData> importedData = await StructuredDataImporter.importUrl(
      "https://www.foodnetwork.com/recipes/katie-lee/cauliflower-alfredo-sauce-3278457");
  print("Found ${importedData.length} structured data instances");
  importedData.forEach((data) {
    print("Found a ${data.schemaType}.");
  });
  var recipe = importedData[0];
  print("Ingredients for the ${recipe['name']} are: ");
  recipe["recipeIngredient"].forEach((ingredient) {
    print("    - $ingredient");
  });
}

fromFileExample() {
  var sample = File("sample.html").readAsStringSync();
  var sampleDom = parse(sample);
  List<StructuredData> data = StructuredDataParser.extract(sampleDom);
  var recipe = data[0];
  print("Ingredients for ${recipe['name']}:");
  recipe["recipeIngredient"].forEach((ingredient) {
    print("    - $ingredient");
  });
}

void main() async {
  await fromUrlExample();
  print("");
  fromFileExample();
}
