# Structured Data
A collection of functions for parsing structured data from web pages. The library supports parsing
microdata, rdfa, and jsonld forms of structured data embedded in a web page.

## Warning
This has not been used in any production application yet, so it may be lacking features or have
some bugs that I haven't encountered yet. Please create issue reports on github to give feedback.
I am actively developing another application that uses this and am fixing issues as I find them, often these updates are potential breaking changes. Use at your own risk, but I would really appreciate any support and feedback!

## Usage
To parse structured data from a web page:
```
List<StructuredData> data = await StructuredDataImporter.importUrl("path/to/website");
```

To parse structured data from an already loaded web page
```
List<StructuredData> data = StructuredDataParser.extract(htmlDocument);
```

`StructuredData` is a dictionary-like object
```
StructuredData someData;
// Load data by importing from URL
someData["property"]
```

## Future Improvements
Eventually I may overlay some wrapper classes for accessing structured data so it's more than
a glorified map.

## References
- [Schema.org](https://schema.org)
- [Google Structured Data](https://developers.google.com/search/docs/guides/intro-structured-data)