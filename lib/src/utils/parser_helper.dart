import 'package:html/dom.dart';

class ParserHelper {
  static String stripProperty(String schema) {
    if (schema != null) {
      String stripped = schema.replaceFirst("http://schema.org/", "");
      stripped = stripped.replaceFirst("https://schema.org/", "");
      return stripped;
    } else {
      return schema;
    }
  }
}
