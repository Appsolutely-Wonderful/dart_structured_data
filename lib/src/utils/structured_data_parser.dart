import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;

import '../objects/structured_data.dart';
import 'json_ld_parser.dart';
import 'microdata_parser.dart';
import 'rdfa_parser.dart';

/// Functions for extracting structured data from a given HTML document
class StructuredDataParser {
  /// Extracts jsonld, microdata, and rdfa data objects from the given
  /// document
  static List<StructuredData> extract(Document document) {
    List<StructuredData> jsonLd = JsonLdParser.extractJsonLd(document);
    List<StructuredData> microdata = MicrodataParser.extractMicrodata(document);
    List<StructuredData> rdfa = RdfaParser.extractRdfa(document);
    return jsonLd + microdata + rdfa;
  }

  /// Extracts jsonld, microdata, and rdfa data objects from the given
  /// string
  static List<StructuredData> parse(String string) =>
      extract(parser.parse(string));
}
