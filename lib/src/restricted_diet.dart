enum RestrictedDiet {
  DiabeticDiet,
  GlutenFreeDiet,
  HalalDiet,
  HinduDiet,
  KosherDiet,
  LowCalorieDiet,
  LowFatDiet,
  LowLactoseDiet,
  LowSaltDiet,
  VeganDiet,
  VegetarianDiet
}

RestrictedDiet schemaToEnum(String val) {
  String stripped_val = val.replaceAll("https://schema.org/", "");
  stripped_val = stripped_val.replaceAll("http://schema.org/", "");
  switch (stripped_val) {
    case "DiabeticDiet":
      return RestrictedDiet.DiabeticDiet;
    case "GlutenFreeDiet":
      return RestrictedDiet.GlutenFreeDiet;
    case "HalalDiet":
      return RestrictedDiet.HalalDiet;
    case "HinduDiet":
      return RestrictedDiet.HinduDiet;
    case "KosherDiet":
      return RestrictedDiet.KosherDiet;
    case "LowCalorieDiet":
      return RestrictedDiet.LowCalorieDiet;
    case "LowFatDiet":
      return RestrictedDiet.LowFatDiet;
    case "LowLactoseDiet":
      return RestrictedDiet.LowLactoseDiet;
    case "LowSaltDiet":
      return RestrictedDiet.LowSaltDiet;
    case "VeganDiet":
      return RestrictedDiet.VeganDiet;
    case "VegetarianDiet":
      return RestrictedDiet.VegetarianDiet;
    default:
      return null;
  }
}
