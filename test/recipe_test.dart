import 'package:dart_recipe_schema/dart_recipe_schema.dart';
import 'package:test/test.dart';

void main() {
  test('Test recipe constructor, no input', () {
    Recipe myRecipe = new Recipe();
    expect(myRecipe.cookTime.runtimeType, null.runtimeType);
  });

  test('Test recipe constructor, with cookTime', () {
    Recipe myRecipe = new Recipe(cookTime: "PT30S");
    expect(myRecipe.cookTime?.inSeconds, 30);
  });

  test('Test recipe constructor when specifying inherited values', () {
    Recipe myRecipe = new Recipe(name: "Super name");
    expect(myRecipe.name, "Super name");
  });
}
