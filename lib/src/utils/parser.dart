import 'package:html/dom.dart';

class HtmlParser {
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

  static dynamic extract_property(Element tag) {
    if (tag?.localName == "meta") return extract_meta_content(tag);
    if (tag?.localName == "img") return extract_img_src(tag);
    if (tag?.localName == "span") return extract_text(tag);
    if (tag?.localName == "link") return extract_link(tag);
    throw UnimplementedError("Parser for ${tag.localName} is not implemented");
  }

  static String extract_text(Element span) => span.text;

  static String extract_img_src(Element img) => extract_attribute(img, "src");

  static String extract_meta_content(Element meta) =>
      extract_attribute(meta, "content");

  static dynamic extract_link(Element el) => extract_attribute(el, "href");

  static String extract_attribute(Element el, String attribute) {
    if (el.attributes.containsKey(attribute)) {
      return el.attributes[attribute];
    } else {
      return "";
    }
  }
}
