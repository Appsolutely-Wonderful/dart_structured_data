class ParserHelper {
  static String? stripProperty(dynamic schema) {
    if (schema != null) {
      if (schema is String) {
        String stripped = schema.replaceFirst("http://schema.org/", "");
        stripped = stripped.replaceFirst("https://schema.org/", "");
        return stripped;
      } else if (schema is List) {
        return stripProperty(schema[0]);
      }
    }
    return schema;
  }
}
