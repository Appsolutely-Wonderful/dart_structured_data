import 'package:dart_recipe_schema/src/nutrition_information.dart';
import 'package:dart_recipe_schema/src/restricted_diet.dart';
import 'package:html/dom.dart';

import '../../dart_recipe_schema.dart';

class RecipeMicrodataParser {
  Document doc;
  Element _element;

  RecipeMicrodataParser(Document doc) {
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
      suitableForDiet: _find_property("suitableForDiet"),
      nutrition: _find_nutrition(),
      ingredients: _find_properties("recipeIngredient"),
    );
  }

  Element _find_tag(Element el, String property) {
    return el.querySelector("[itemprop=\"$property\"]");
  }

  List<Element> _find_tags(Element el, String property) {
    return el.querySelectorAll("[itemprop=\"$property\"]");
  }

  NutritionInformation _find_nutrition() {
    var tag = _find_tag(_element, "nutrition");
    if (tag != null) {
      return NutritionInformation(
        calories: _find_property_in_tag(tag, "calories"),
        carbohydrateContent: _find_property_in_tag(tag, "carbohydrateContent"),
        cholesterolContent: _find_property_in_tag(tag, "cholesterolContent"),
        fatContent: _find_property_in_tag(tag, "fatContent"),
        fiberContent: _find_property_in_tag(tag, "fiberContent"),
        proteinContent: _find_property_in_tag(tag, "proteinContent"),
        saturatedFatContent: _find_property_in_tag(tag, "saturatedFatContent"),
        servingSize: _find_property_in_tag(tag, "servingSize"),
        sodiumContent: _find_property_in_tag(tag, "sodiumContent"),
        sugarContent: _find_property_in_tag(tag, "sugarContent"),
        transFatContent: _find_property_in_tag(tag, "transFatContent"),
        unsaturatedFatContent:
            _find_property_in_tag(tag, "unsaturatedFatContent"),
      );
    } else {
      return null;
    }
  }

  dynamic _extract_property(Element tag) {
    if (tag?.localName == "meta") return _extract_meta_content(tag);
    if (tag?.localName == "img") return _extract_img_src(tag);
    if (tag?.localName == "span") return _extract_text(tag);
    if (tag?.localName == "link") return _extract_link(tag);
  }

  dynamic _find_property_in_tag(Element tag, String property) {
    var found_tag = _find_tag(tag, property);
    return _extract_property(found_tag);
  }

  dynamic _find_property(String property) {
    return _find_property_in_tag(_element, property);
  }

  dynamic _find_properties(String property) {
    var tags = _find_tags(_element, property);
    List<String> elements = List<String>();
    tags.forEach((element) {
      elements.add(_extract_property(element));
    });
    return elements;
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

  dynamic _extract_link(Element el) {
    String href = el.attributes['href'];
    return schemaToEnum(href);
  }
}
