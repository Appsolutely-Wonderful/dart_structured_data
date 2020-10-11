import 'package:dart_recipe_schema/src/objects/iso_8601.dart';
import 'package:dart_recipe_schema/src/objects/structured_data.dart';

/// Wrapper for accessing the Structured Data object as a recipe object
class Recipe {
  final StructuredData _data;

  const Recipe(StructuredData data) : _data = data;

  Duration get cookTime => Iso8601.parseDuration(_data["cookTime"]);
  String get cookingMethod => _data["cookingMethod"];
  // TODO: NutritionInformation nutrition
  String get recipeCategory => _data["recipeCategory"];
  String get recipeCuisine => _data["recipeCuisine"];
  List<String> get recipeIngredient {
    if (_data["recipeIngredient"] is List) {
      return _data["recipeIngredient"];
    } else {
      return [_data["recipeIngredient"]];
    }
  }

  dynamic operator [](String key) => _data[key];
}
