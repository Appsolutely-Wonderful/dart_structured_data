import 'package:html/dom.dart';

import '../../dart_recipe_schema.dart';

class HtmlSchemaParser {
  Document doc;
  Element _element;

  HtmlSchemaParser(Document doc) {
    this.doc = doc;
  }

  /// Builds a recipe based on the microdata found in the provided html document
  ///
  /// If no microdata is found, or if the microdata cannot be parsed, then
  /// this returns null
  Recipe recipeFromMicrodata() {
    _element = doc
        .querySelector("[itemscope][itemtype=\"https://schema.org/Recipe\"]");
    // no microdata in this document
    if (_element == null) {
      return null;
    }

    return Recipe(
      name: _find_property("name"),
      author: _find_property("author"),
      datePublished: _find_property("datePublished"),
      image: _find_property("image"),
      description: _find_property("description"),
      prepTime: _find_property("prepTime"),
      cookTime: _find_property("cookTime"),
      recipeYield: _find_property("recipeYield"),
    );
  }

  dynamic _find_property(String property) {
    var tag = _element.querySelector("[itemprop=\"$property\"]");
    if (tag?.localName == "meta") return _extract_meta_content(tag);
    if (tag?.localName == "img") return _extract_img_src(tag);
    if (tag?.localName == "span") return _extract_text(tag);
  }

  String _extract_text(Element span) => span.text;

  String _extract_img_src(Element img) => _extract_attribute(img, "src");

  String _extract_meta_content(Element meta) =>
      _extract_attribute(meta, "content");

  String _extract_attribute(Element el, String attribute) {
    if (el.attributes.containsKey(attribute)) {
      return el.attributes[attribute];
    } else {
      print("Did not find attribute $attribute on $el");
      return "";
    }
  }
}
