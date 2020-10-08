class Thing {
  Thing({this.name, this.image, this.description});

  /// The name of the item.
  String name;

  /// An alias for the item.
  String alternateName;

  /// A description of the item.
  String description;

  /// A sub property of description. A short description of the item used to
  /// disambiguate from other, similar items. Information from other properties
  /// (in particular, name) may be necessary for the description to be useful
  /// for disambiguation.
  String disambiguatingDescription;

  /// The identifier property represents any kind of identifier for any kind of
  /// Thing, such as ISBNs, GTIN codes, UUIDs etc. Schema.org provides dedicated
  /// properties for representing many of these, either as textual strings or as
  ///  URL (URI) links. See background notes for more details.
  String identifier;

  /// An image of the item. This can be a URL (String)
  /// or a fully described ImageObject.
  dynamic image;
}
