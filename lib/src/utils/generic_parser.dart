import 'package:html/dom.dart';

import '../objects/structured_data.dart';
import '../utils/json_ld_parser.dart';
import '../utils/microdata_parser.dart';
import '../utils/rdfa_parser.dart';

class GenericParser {
  static List<StructuredData> extractStructuredData(Document document) {
    List<StructuredData> jsonLd = JsonLdParser.extractJsonLd(document);
    List<StructuredData> microdata = MicrodataParser.extractMicrodata(document);
    List<StructuredData> rdfa = RdfaParser.extractRdfa(document);
    return jsonLd + microdata + rdfa;
  }
}
