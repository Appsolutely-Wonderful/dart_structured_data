import 'package:dart_recipe_schema/src/thing.dart';

class CreativeWork extends Thing {
  CreativeWork({
    String name, // Part of Thing
    dynamic image, // Part of Thing
    String description, // Part of Thing
  }) : super(name: name, image: image, description: description);

  /// The subject matter of the content.
  /// Inverse property: subjectOf.
  Thing about;

  /// An abstract is a short description that summarizes a CreativeWork.
  String abstract;

  /// The human sensory perceptual system or cognitive faculty through which a
  /// person may process or perceive information. Expected values include:
  /// auditory, tactile, textual, visual, colorDependent, chartOnVisual,
  /// chemOnVisual, diagramOnVisual, mathOnVisual, musicOnVisual, textOnVisual.
  String accessMode;

  /// 	A list of single or combined accessModes that are sufficient to
  /// understand all the intellectual content of a resource. Expected values
  /// include: auditory, tactile, textual, visual.
  List<String> accessModeSufficient;
}
