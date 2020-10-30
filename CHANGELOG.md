# 0.1.6+1

- Add toJson function to StructuredData

# 0.1.6

- Fix json+ld error where parser stops after seeing the @graph attribute without parsing
  the rest of the data.

# 0.1.5

- Fix error where parsing fails if "@type" property is a List<String> in json-ld

# 0.1.4

- When parsing json+ld, this will now parse lists of structured datas into StructuredData objects.
  previously, the list would just contain the string of undecoded data.

# 0.1.3

- When parsing microdata, leading "http(s)://schema.org/" string will be stripped out

# 0.1.2

- Expose parser that can convert Iso8601 duration strings to Duration objects

# 0.1.1

- Any JSON-LD graphs will automatically be parsed into a List<StructuredData> object

# 0.1.0

- Initial development release.
