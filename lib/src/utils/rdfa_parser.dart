import 'package:dart_recipe_schema/src/objects/structured_data.dart';
import 'package:dart_recipe_schema/src/utils/parser.dart';
import 'package:html/dom.dart';

class RdfaParser {
  static List<StructuredData> extractRdfa(Document doc) {
    var rdfaTypes = HtmlParser.findRdfaItems(doc);
    List<StructuredData> items = List<StructuredData>();
    rdfaTypes.forEach((item) {
      print("Extracting structured data");
      StructuredData schema = _extractStructuredData(item);
      items.add(schema);
    });

    return items;
  }

  static StructuredData _extractStructuredData(Element el) {
    StructuredData schema = StructuredData(el.attributes["typeof"]);
    // Query all "property" attributes
    var properties = HtmlParser.getRdfaProperties(el);

    // Parse each property
    properties.forEach((property) {
      var itemtype = HtmlParser.extract_attribute(property, "property");
      // If the property itself is a schema object, then make a recursive call
      // to parse that microdata
      if (property.attributes.containsKey("typeof")) {
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
