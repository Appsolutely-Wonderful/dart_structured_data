/// Note, many portions of the Schema are unimplemented.
/// I implemented the minimum necessary for my use case.
/// The community may contribute as needed for their own use cases.
///
/// All fields for all inherited attributes are settable through the
/// constructor. This makes for very long constructors, but I suppose
/// it's better than needing to manually set all fields after creating
/// the object.
library dart_schema_recipe;

export 'src/recipe.dart';
