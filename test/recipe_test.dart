import 'dart:io';

import 'package:dart_recipe_schema/src/objects/recipe.dart';
import 'package:dart_recipe_schema/src/objects/structured_data.dart';
import 'package:dart_recipe_schema/src/utils/microdata_parser.dart';
import 'package:html/parser.dart';
import 'package:test/test.dart';

void main() {
  test("Running microdata", () {
    var microdata = File("test/test_inputs/microdata.html").readAsStringSync();
    var htmlMicrodata = parse(microdata);
    List<StructuredData> data = MicrodataParser.extractMicrodata(htmlMicrodata);
    Recipe recipe = Recipe(data: data[0]);

    expect(recipe["name"], "Mom's World Famous Banana Bread");
    expect(recipe["author"], "John Smith");
    expect(recipe["datePublished"], "2009-05-08");
    expect(recipe["image"], "bananabread.jpg");
    expect(recipe["description"], """This classic banana bread recipe comes
    from my mom -- the walnuts add a nice texture and flavor to the banana
    bread.""");
    expect(recipe["prepTime"], "PT15M");
    expect(recipe["cookTime"], "PT1H");
    expect(recipe["recipeYield"], "1 loaf");
    // expect(testRecipe["suitableForDiet"], RestrictedDiet.LowFatDiet);
    expect(recipe["nutrition"]["calories"], "240 calories");
    expect(recipe["nutrition"]["fatContent"], "9 grams fat");
    expect(recipe["recipeIngredient"][0], "3 or 4 ripe bananas, smashed");
    expect(recipe["recipeIngredient"][1], "1 egg");
    expect(recipe["recipeIngredient"][2], "3/4 cup of sugar");
    expect(recipe["recipeInstructions"],
        """Preheat the oven to 350 degrees. Mix in the ingredients in a bowl. Add
    the flour last. Pour the mixture into a loaf pan and bake for one hour.""");
    expect(recipe["interactionStatistic"]["interactionType"],
        "https://schema.org/CommentAction");
    expect(recipe["interactionStatistic"]["userInteractionCount"], "140");
  });
  });
}
