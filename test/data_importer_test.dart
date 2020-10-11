import 'package:dart_recipe_schema/src/html/data_importer.dart';
import 'package:dart_recipe_schema/src/objects/structured_data.dart';
import 'package:test/test.dart';

void main() async {
  await test("Data importer test", () async {
    List<StructuredData> data = await DataImporter.importUrl();
    data[0].keys.forEach((element) {
      print(element);
    });
    print(data[0]["recipeIngredient"]);
  });
}
