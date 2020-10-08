import 'how_to.dart';
import 'nutrition_information.dart';
import 'utils/iso_8601.dart';
import 'restricted_diet.dart';

/// A recipe.
///
/// Canonical URL: http://schema.org/Recipe
class Recipe extends HowTo {
  Recipe(
      {String name, // Part of Thing
      dynamic image, // Part of Thing
      String description, // Part of Thing
      String prepTime, // Part of HowTo
      this.author,
      this.datePublished,
      String cookTime,
      this.cookingMethod,
      this.nutrition,
      this.recipeCategory,
      this.recipeCuisine,
      this.ingredients,
      this.recipeInstructions,
      this.recipeYield,
      this.suitableForDiet})
      : super(
            name: name,
            image: image,
            description: description,
            prepTime: prepTime) {
    if (cookTime != null) this.cookTime = Iso8601.parseDuration(cookTime);
  }

  /// The author of this recipe.
  String author;

  /// Date of first broadcast/publication.
  /// TODO: Update to DateTime
  String datePublished;

  /// The time it takes to actually cook the dish, in ISO 8601 duration format.
  Duration cookTime;

  /// The method of cooking, such as Frying, Steaming, ...
  String cookingMethod;

  /// Nutrition information about the recipe or menu item.
  NutritionInformation nutrition;

  /// The category of the recipe—for example, appetizer, entree, etc.
  String recipeCategory;

  /// The cuisine of the recipe (for example, French or Ethiopian).
  String recipeCuisine;

  /// List of ingredients used in the recipe
  ///
  /// NOTE: This deviates from the schema, the schema uses a single tag
  /// called "recipeIngredient" that can be used to define multiple
  /// ingredients. This field aggregates all ingredients into this field
  /// which is not defined by the schema.
  List<String> ingredients;

  /// A step in making the recipe, in the form of a single item
  /// (document, video, etc.) or an ordered list with HowToStep and/or
  /// HowToSection items.
  ///
  /// NOTE: HowToSteps are stripped out into a string when parsing.
  ///       If the single item is a document or video, this list will have
  ///       1 item with the URL to the document or video.
  List<String> recipeInstructions;

  /// The quantity produced by the recipe
  /// (for example, number of people served, number of servings, etc).
  String recipeYield;

  /// Indicates a dietary restriction or guideline for which this recipe or
  /// menu item is suitable, e.g. diabetic, halal etc.
  RestrictedDiet suitableForDiet;
}
