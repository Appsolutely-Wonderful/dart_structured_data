import 'package:html/dom.dart';
import 'package:structured_data/src/utils/parser_helper.dart';

class HtmlQuery {
  static List<Element> findItemScopes(Document doc) {
    return doc.querySelectorAll("[itemscope]");
  }

  static List<Element> findRdfaItems(Document doc) {
    return doc.querySelectorAll("[typeof]");
  }

  static List<Element> findJsonLds(Document doc) {
    return doc.querySelectorAll("[type=\"application/ld+json\"]");
  }

  static List<Element> getMicrodataProperties(Element el) {
    return el.querySelectorAll("[itemprop]");
  }

  static List<Element> getRdfaProperties(Element el) {
    return el.querySelectorAll("[property]");
  }

  static String extract_property(Element tag) {
    String prop;
    if (tag?.localName == "meta")
      prop = extract_meta_content(tag);
    else if (tag?.localName == "img")
      prop = extract_img_src(tag);
    else if (tag?.localName == "span")
      prop = extract_text(tag);
    else if (tag?.localName == "link")
      prop = extract_link(tag);
    else
      prop = extract_text(tag);

    return ParserHelper.stripProperty(prop);
  }

  static String extract_text(Element span) => span.text;

  static String extract_img_src(Element img) => extract_attribute(img, "src");

  static String extract_meta_content(Element meta) =>
      extract_attribute(meta, "content");

  static String extract_link(Element el) => extract_attribute(el, "href");

  static String extract_attribute(Element el, String attribute) {
    if (el.attributes.containsKey(attribute)) {
      return el.attributes[attribute];
    } else {
      return "";
    }
  }
}
