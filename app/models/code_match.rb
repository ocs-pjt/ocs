# encoding: utf-8
class CodeMatch

  # Mapping of french regions with jVectorMap (see jVectorMap gem (lib/maps directory))
  # Regions are in english because using google geocoder

  # "Google region" => "jVector region code"
  # Sometimes google gives weird results, example region for "Le mont saint michel" instead of being in the lower normandy region it is in the region "Le mont st michel" which doesn't exist
  # so address geocoding can be tricky sometimes

  FRENCH_REGIONS = {
    "Auvergne"                    => "FR-C",
    "Aquitaine"                   => "FR-B",
    "Alsace"                      => "FR-A",
    "Champagne-Ardenne"           => "FR-G",
    "Centre"                      => "FR-F",
    "Brittany"                    => "FR-E",
    "Burgandy"                    => "FR-D", # == Bourgogne (Burgundy in english but for some reason the API returns Burgandy)
    "Languedoc-Roussillon"        => "FR-K",
    "Île-de-France"               => "FR-J",
    "Franche-Comté"               => "FR-I",
    "Corsica"                     => "FR-H",
    "Nord-Pas-de-Calais"          => "FR-O",
    "Midi-Pyrénées"               => "FR-N",
    "Lorraine"                    => "FR-M",
    "Limousin"                    => "FR-L",
    "Picardy"                     => "FR-S",
    "Pays de la Loire"            => "FR-R",
    "Upper Normandy"              => "FR-Q",
    "Lower Normandy"              => "FR-P",
    "Rhone-Alpes"                 => "FR-V",
    "Provence-Alpes-Côte d'Azur"  => "FR-U",
    "Poitou-Charentes"            => "FR-T",
    "French Guiana"               => "FR-GF",
  }


end