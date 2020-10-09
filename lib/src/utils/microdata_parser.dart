import 'package:html/dom.dart';

import '../objects/structured_data.dart';

/// This class contains the functions necessary
/// for extracting Microdata from HTML
class MicrodataParser {
  /// This function returns a list of all microdata elements detected
  /// in the provided document
  static List<StructuredData> extractMicrodata(Document document) {
    var scopes = _findItemScopes(document);
    List<StructuredData> items = List<StructuredData>();
    scopes.forEach((itemscope) {
      print("Extracting structured data");
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
    var properties = _getProperties(el);

    // Parse the microdata from each property
    properties.forEach((property) {
      var itemtype = _extract_attribute(property, "itemprop");
      // If the property itself is a schema object, then make a recursive call
      // to parse that microdata
      if (property.attributes.containsKey("itemscope")) {
        StructuredData structuredProperty = _extractStructuredData(property);
        schema.addData(itemtype, structuredProperty);
      } else {
        // Otherwise, it depends on the HTML tag how we parse the microdata
        var data = _extract_property(property);
        schema.addData(itemtype, data);
      }
    });

    return schema;
  }

  static List<Element> _findItemScopes(Document doc) {
    return doc.querySelectorAll("[itemscope]");
  }

  static List<Element> _getProperties(Element el) {
    return el.querySelectorAll("[itemprop]");
  }

  static dynamic _extract_property(Element tag) {
    if (tag?.localName == "meta") return _extract_meta_content(tag);
    if (tag?.localName == "img") return _extract_img_src(tag);
    if (tag?.localName == "span") return _extract_text(tag);
    if (tag?.localName == "link") return _extract_link(tag);
    throw UnimplementedError("Parser for ${tag.localName} is not implemented");
  }

  static String _extract_text(Element span) => span.text;

  static String _extract_img_src(Element img) => _extract_attribute(img, "src");

  static String _extract_meta_content(Element meta) =>
      _extract_attribute(meta, "content");

  static dynamic _extract_link(Element el) => _extract_attribute(el, "href");

  static String _extract_attribute(Element el, String attribute) {
    if (el.attributes.containsKey(attribute)) {
      return el.attributes[attribute];
    } else {
      print("Did not find attribute $attribute on $el");
      return "";
    }
  }
}
