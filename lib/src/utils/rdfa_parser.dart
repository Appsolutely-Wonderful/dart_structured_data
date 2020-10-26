import 'package:html/dom.dart';
import 'package:structured_data/src/utils/parser_helper.dart';

import '../objects/structured_data.dart';
import 'html_parser.dart';

class RdfaParser {
  static List<StructuredData> extractRdfa(Document doc) {
    var rdfaTypes = HtmlQuery.findRdfaItems(doc);
    List<StructuredData> items = List<StructuredData>();
    rdfaTypes.forEach((item) {
      StructuredData schema = _extractStructuredData(item);
      items.add(schema);
    });

    return items;
  }

  static StructuredData _extractStructuredData(Element el) {
    StructuredData schema =
        StructuredData(ParserHelper.stripProperty(el.attributes["typeof"]));
    // Query all "property" attributes
    var properties = HtmlQuery.getRdfaProperties(el);

    // Parse each property
    properties.forEach((property) {
      var itemtype = HtmlQuery.extract_attribute(property, "property");
      // If the property itself is a schema object, then make a recursive call
      // to parse that microdata
      if (property.attributes.containsKey("typeof")) {
        StructuredData structuredProperty = _extractStructuredData(property);
        schema.addData(itemtype, structuredProperty);
      } else {
        // Otherwise, it depends on the HTML tag how we parse the microdata
        var data = HtmlQuery.extract_property(property);
        schema.addData(itemtype, data);
      }
    });

    return schema;
  }
}
