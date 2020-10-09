import 'package:dart_recipe_schema/dart_recipe_schema.dart';
import 'package:dart_recipe_schema/src/utils/microdata_schema_parser.dart';
import 'package:html/dom.dart';

/// A collection of functions used for parsing various data formats
class SchemaParser {
  static Recipe recipeFromMicrodata(Document doc) {
    RecipeMicrodataParser htmlParser = RecipeMicrodataParser(doc);
    return htmlParser.recipeFromMicrodata();
  }
}
