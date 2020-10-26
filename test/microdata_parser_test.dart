import 'dart:io';

import '../lib/src/objects/structured_data.dart';
import '../lib/src/utils/microdata_parser.dart';
import 'package:html/parser.dart';
import 'package:test/test.dart';

void main() {
  test("Running microdata", () {
    var microdata = File("test/test_inputs/microdata.html").readAsStringSync();
    var htmlMicrodata = parse(microdata);
    List<StructuredData> data = MicrodataParser.extractMicrodata(htmlMicrodata);
    var testRecipe = data[0];

    expect(testRecipe.schemaType, "Recipe");
    expect(testRecipe["name"], "Mom's World Famous Banana Bread");
    expect(testRecipe["author"], "John Smith");
    expect(testRecipe["datePublished"], "2009-05-08");
    expect(testRecipe["image"], "bananabread.jpg");
    expect(testRecipe["description"], """This classic banana bread recipe comes
    from my mom -- the walnuts add a nice texture and flavor to the banana
    bread.""");
    expect(testRecipe["prepTime"], "PT15M");
    expect(testRecipe["cookTime"], "PT1H");
    expect(testRecipe["recipeYield"], "1 loaf");
    // expect(testRecipe["suitableForDiet"], RestrictedDiet.LowFatDiet);
    expect(testRecipe["nutrition"]["calories"], "240 calories");
    expect(testRecipe["nutrition"]["fatContent"], "9 grams fat");
    expect(testRecipe["recipeIngredient"][0], "3 or 4 ripe bananas, smashed");
    expect(testRecipe["recipeIngredient"][1], "1 egg");
    expect(testRecipe["recipeIngredient"][2], "3/4 cup of sugar");
    expect(testRecipe["recipeInstructions"],
        """Preheat the oven to 350 degrees. Mix in the ingredients in a bowl. Add
    the flour last. Pour the mixture into a loaf pan and bake for one hour.""");
    expect(
        testRecipe["interactionStatistic"]["interactionType"], "CommentAction");
    expect(testRecipe["interactionStatistic"]["userInteractionCount"], "140");
  });
}
