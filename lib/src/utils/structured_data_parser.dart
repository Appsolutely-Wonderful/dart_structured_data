import 'package:html/dom.dart';

import '../objects/structured_data.dart';
import 'json_ld_parser.dart';
import 'microdata_parser.dart';
import 'rdfa_parser.dart';

class StructuredDataParser {
  static List<StructuredData> extract(Document document) {
    List<StructuredData> jsonLd = JsonLdParser.extractJsonLd(document);
    List<StructuredData> microdata = MicrodataParser.extractMicrodata(document);
    List<StructuredData> rdfa = RdfaParser.extractRdfa(document);
    return jsonLd + microdata + rdfa;
  }
}
