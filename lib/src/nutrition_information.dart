/// Nutritional information about the recipe.
///
/// Defined by http://schema.org/NutritionInformation
class NutritionInformation {
  NutritionInformation(
      {this.calories,
      this.carbohydrateContent,
      this.cholesterolContent,
      this.fatContent,
      this.fiberContent,
      this.proteinContent,
      this.saturatedFatContent,
      this.servingSize,
      this.sodiumContent,
      this.sugarContent,
      this.transFatContent,
      this.unsaturatedFatContent});

  /// The number of calories
  String calories;

  /// The number of grams of carbohydrates.
  String carbohydrateContent;

  /// The number of milligrams of cholesterol.
  String cholesterolContent;

  /// The number of grams of fat.
  String fatContent;

  /// The number of grams of fiber.
  String fiberContent;

  /// The number of grams of protein.
  String proteinContent;

  /// The number of grams of saturated fat.
  String saturatedFatContent;

  /// The serving size, in terms of the number of volume or mass.
  String servingSize;

  /// The number of milligrams of sodium.
  String sodiumContent;

  /// The number of grams of sugar.
  String sugarContent;

  /// The number of grams of trans fat.
  String transFatContent;

  /// The number of grams of unsaturated fat.
  String unsaturatedFatContent;
}
