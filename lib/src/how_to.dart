import 'package:dart_recipe_schema/src/creative_work.dart';
import 'package:dart_recipe_schema/src/utils/iso_8601.dart';

class HowTo extends CreativeWork {
  HowTo({
    String name, // Part of Thing
    dynamic image, // Part of Thing
    String description, // Part of Thing
    String prepTime,
  }) : super(name: name, image: image, description: description) {
    this.prepTime = Iso8601.parseDuration(prepTime);
  }

  /// The length of time it takes to prepare the items to be used in
  /// instructions or a direction.
  Duration prepTime;
}
