import '../lib/src/html/data_importer.dart';
import '../lib/src/objects/structured_data.dart';

import 'package:test/test.dart';

void main() {
  test("Data importer test", () async {
    List<StructuredData> data = await StructuredDataImporter.importUrl(
        "https://foodnetwork.co.uk/recipes/perfect-pot-roast");
    bool recipeFound = false;
    data.forEach((sData) {
      if (sData.schemaType == 'Recipe') {
        recipeFound = true;
        expect(sData['name'], 'Perfect Pot Roast');
      }
    });
    expect(recipeFound, true);
  });
}
