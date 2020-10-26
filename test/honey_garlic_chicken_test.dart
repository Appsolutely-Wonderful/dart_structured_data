import 'package:structured_data/structured_data.dart';
import 'package:test/test.dart';

void main() {
  test("Loading honey garlic chick", () async {
    var result = await StructuredDataImporter.importUrl(
        "https://damndelicious.net/2015/06/05/slow-cooker-honey-garlic-chicken-and-veggies/");
    result.forEach((data) {
      if (data.schemaType == 'Recipe') {
        expect(data['name'], 'Slow Cooker Honey Garlic Chicken and Veggies');
      }
    });
  });
}
