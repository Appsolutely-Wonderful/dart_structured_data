import 'package:dart_recipe_schema/src/utils/parser.dart';
import 'package:html/dom.dart';

import '../objects/structured_data.dart';

/// This class contains the functions necessary
/// for extracting Microdata from HTML
class MicrodataParser {
  /// This function returns a list of all microdata elements detected
  /// in the provided document
  static List<StructuredData> extractMicrodata(Document document) {
    var scopes = HtmlParser.findItemScopes(document);
    List<StructuredData> items = List<StructuredData>();
    scopes.forEach((itemscope) {
      StructuredData schema = _extractStructuredData(itemscope);
      items.add(schema);
    });

    return items;
  }

  /// Create a structured data object from the given microdata
  /// itemscope
  static StructuredData _extractStructuredData(Element el) {
    StructuredData schema = StructuredData(el.attributes["itemtype"]);
    // Query all "itemprop" attributes
    var properties = HtmlParser.getMicrodataProperties(el);

    // Parse the microdata from each property
    properties.forEach((property) {
      var itemtype = HtmlParser.extract_attribute(property, "itemprop");
      // If the property itself is a schema object, then make a recursive call
      // to parse that microdata
      if (property.attributes.containsKey("itemscope")) {
        StructuredData structuredProperty = _extractStructuredData(property);
        schema.addData(itemtype, structuredProperty);
      } else {
        // Otherwise, it depends on the HTML tag how we parse the microdata
        var data = HtmlParser.extract_property(property);
        schema.addData(itemtype, data);
      }
    });

    return schema;
  }
}
