import '../lib/src/html/data_importer.dart';
import '../lib/src/objects/structured_data.dart';
import 'package:test/test.dart';

void main() async {
  await test("Data importer test", () async {
    List<StructuredData> data = await StructuredDataImporter.importUrl(
        "https://www.foodnetwork.com/recipes/food-network-kitchen/the-best-pot-roast-7434330");
    data[0].keys.forEach((element) {
      print(element);
    });
    print(data[0]["recipeIngredient"]);
  });
}
