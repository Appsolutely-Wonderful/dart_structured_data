import 'dart:io';

import 'package:dart_recipe_schema/dart_recipe_schema.dart';
import 'package:dart_recipe_schema/src/utils/schema_parser.dart';
import 'package:html/parser.dart' show parse;

import 'package:test/test.dart';

void main() {
  test('Test parsing html microdata', () {
    var microdata = File("test/test_inputs/microdata.html").readAsStringSync();
    var htmlMicrodata = parse(microdata);
    Recipe testRecipe = SchemaParser.recipeFromMicrodata(htmlMicrodata);
    expect(testRecipe.name, "Mom's World Famous Banana Bread");
    expect(testRecipe.author, "John Smith");
    expect(testRecipe.datePublished, "2009-05-08");
    expect(testRecipe.image, "bananabread.jpg");
    expect(testRecipe.description, """This classic banana bread recipe comes
    from my mom -- the walnuts add a nice texture and flavor to the banana
    bread.""");
    expect(testRecipe.prepTime.inMinutes, 15);
    expect(testRecipe.cookTime.inHours, 1);
    expect(testRecipe.recipeYield, "1 loaf");
    expect(testRecipe.suitableForDiet, "1 loaf");
  });
}
