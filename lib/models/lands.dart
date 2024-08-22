//------------------------------ Lands ---------------------------------
class Land {
  Name? name;
  List<String>? tld;
  String? cca2;
  String? ccn3;
  String? cca3;
  bool? independent;
  String? status;
  bool? unMember;
  Currencies? currencies;
  Idd? idd;
  List<String>? capital;
  List<String>? altSpellings;
  String? region;
  String? subregion;
  Languages? languages;
  Translations? translations;
  List<double>? latlng;
  bool? landlocked;
  double? area;
  Demonyms? demonyms;
  String? flag;
  Maps? maps;
  int? population;
  Car? car;
  List<String>? timezones;
  List<String>? continents;
  Flags? flags;
  Flags? coatOfArms;
  String? startOfWeek;
  CapitalInfo? capitalInfo;
  PostalCode? postalCode;

  Land(
      {this.name,
      this.tld,
      this.cca2,
      this.ccn3,
      this.cca3,
      this.independent,
      this.status,
      this.unMember,
      this.currencies,
      this.idd,
      this.capital,
      this.altSpellings,
      this.region,
      this.subregion,
      this.languages,
      this.translations,
      this.latlng,
      this.landlocked,
      this.area,
      this.demonyms,
      this.flag,
      this.maps,
      this.population,
      this.car,
      this.timezones,
      this.continents,
      this.flags,
      this.coatOfArms,
      this.startOfWeek,
      this.capitalInfo,
      this.postalCode});

  Land.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    tld = json['tld'] != null ? json['tld'].cast<String>() : null;
    cca2 = json['cca2'];
    ccn3 = json['ccn3'];
    cca3 = json['cca3'];
    independent = json['independent'];
    status = json['status'];
    unMember = json['unMember'];
    currencies = json['currencies'] != null
        ? Currencies.fromJson(json['currencies'])
        : null;
    idd = json['idd'] != null ? Idd.fromJson(json['idd']) : null;
    capital = json['capital'] != null ? json['capital'].cast<String>() : null;
    altSpellings = json['altSpellings'].cast<String>();
    region = json['region'];
    subregion = json['subregion'];
    languages = json['languages'] != null
        ? Languages.fromJson(json['languages'])
        : null;
    translations = json['translations'] != null
        ? Translations.fromJson(json['translations'])
        : null;
    latlng = json['latlng'].cast<double>();
    landlocked = json['landlocked'];
    area = json['area'];
    demonyms =
        json['demonyms'] != null ? Demonyms.fromJson(json['demonyms']) : null;
    flag = json['flag'];
    maps = json['maps'] != null ? Maps.fromJson(json['maps']) : null;
    population = json['population'];
    car = json['car'] != null ? Car.fromJson(json['car']) : null;
    timezones = json['timezones'].cast<String>();
    continents = json['continents'].cast<String>();
    flags = json['flags'] != null ? Flags.fromJson(json['flags']) : null;
    coatOfArms =
        json['coatOfArms'] != null ? Flags.fromJson(json['coatOfArms']) : null;
    startOfWeek = json['startOfWeek'];
    capitalInfo = json['capitalInfo'] != null
        ? CapitalInfo.fromJson(json['capitalInfo'])
        : null;
    postalCode = json['postalCode'] != null
        ? PostalCode.fromJson(json['postalCode'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['tld'] = tld;
    data['cca2'] = cca2;
    data['ccn3'] = ccn3;
    data['cca3'] = cca3;
    data['independent'] = independent;
    data['status'] = status;
    data['unMember'] = unMember;
    if (currencies != null) {
      data['currencies'] = currencies!.toJson();
    }
    if (idd != null) {
      data['idd'] = idd!.toJson();
    }
    data['capital'] = capital;
    data['altSpellings'] = altSpellings;
    data['region'] = region;
    data['subregion'] = subregion;
    if (languages != null) {
      data['languages'] = languages!.toJson();
    }
    if (translations != null) {
      data['translations'] = translations!.toJson();
    }
    data['latlng'] = latlng;
    data['landlocked'] = landlocked;
    data['area'] = area;
    if (demonyms != null) {
      data['demonyms'] = demonyms!.toJson();
    }
    data['flag'] = flag;
    if (maps != null) {
      data['maps'] = maps!.toJson();
    }
    data['population'] = population;
    if (car != null) {
      data['car'] = car!.toJson();
    }
    data['timezones'] = timezones;
    data['continents'] = continents;
    if (flags != null) {
      data['flags'] = flags!.toJson();
    }
    if (coatOfArms != null) {
      data['coatOfArms'] = coatOfArms!.toJson();
    }
    data['startOfWeek'] = startOfWeek;
    if (capitalInfo != null) {
      data['capitalInfo'] = capitalInfo!.toJson();
    }
    if (postalCode != null) {
      data['postalCode'] = postalCode!.toJson();
    }
    return data;
  }
}

//------------------------------ Name ---------------------------------
class Name {
  String? common;
  String? official;
  NativeName? nativeName;

  Name({this.common, this.official, this.nativeName});

  Name.fromJson(Map<String, dynamic> json) {
    common = json['common'];
    official = json['official'];
    nativeName = json['nativeName'] != null
        ? NativeName.fromJson(json['nativeName'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['common'] = common;
    data['official'] = official;
    if (nativeName != null) {
      data['nativeName'] = nativeName!.toJson();
    }
    return data;
  }
}

//------------------------------ NativeName ---------------------------------
class NativeName {
  Kal? kal;

  NativeName({this.kal});

  NativeName.fromJson(Map<String, dynamic> json) {
    kal = json['kal'] != null ? Kal.fromJson(json['kal']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (kal != null) {
      data['kal'] = kal!.toJson();
    }
    return data;
  }
}

//------------------------------ Kal ---------------------------------
class Kal {
  String? official;
  String? common;

  Kal({this.official, this.common});

  Kal.fromJson(Map<String, dynamic> json) {
    official = json['official'];
    common = json['common'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['official'] = official;
    data['common'] = common;
    return data;
  }
}

//------------------------------ Currencies ---------------------------------
class Currencies {
  DKK? dKK;

  Currencies({this.dKK});

  Currencies.fromJson(Map<String, dynamic> json) {
    dKK = json['DKK'] != null ? DKK.fromJson(json['DKK']) : null;
    dKK = json['ARS'] != null ? DKK.fromJson(json['ARS']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dKK != null) {
      data['DKK'] = dKK!.toJson();
      data['ARS'] = dKK!.toJson();
    }
    return data;
  }
}

//------------------------------ DKK ---------------------------------
class DKK {
  String? name;
  String? symbol;

  DKK({this.name, this.symbol});

  DKK.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['symbol'] = symbol;
    return data;
  }
}

//------------------------------ Idd ---------------------------------
class Idd {
  String? root;
  List<String>? suffixes;

  Idd({this.root, this.suffixes});

  Idd.fromJson(Map<String, dynamic> json) {
    root = json['root'];
    suffixes =
        json['suffixes'] != null ? json['suffixes'].cast<String>() : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['root'] = root;
    data['suffixes'] = suffixes;
    return data;
  }
}

//------------------------------ Languages ---------------------------------
class Languages {
  String? kal;

  Languages({this.kal});

  Languages.fromJson(Map<String, dynamic> json) {
    kal = json['kal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kal'] = kal;
    return data;
  }
}

//------------------------------ Translations ---------------------------------
class Translations {
  Kal? ara;
  Kal? ces;
  Kal? cym;
  Kal? deu;
  Kal? est;
  Kal? fin;
  Eng? fra;
  Kal? hrv;
  Kal? hun;
  Kal? ita;
  Kal? jpn;
  Kal? kor;
  Kal? nld;
  Kal? per;
  Kal? pol;
  Kal? por;
  Kal? rus;
  Kal? slk;
  Kal? spa;
  Kal? swe;
  Kal? urd;
  Kal? zho;

  Translations(
      {this.ara,
      this.ces,
      this.cym,
      this.deu,
      this.est,
      this.fin,
      this.fra,
      this.hrv,
      this.hun,
      this.ita,
      this.jpn,
      this.kor,
      this.nld,
      this.per,
      this.pol,
      this.por,
      this.rus,
      this.slk,
      this.spa,
      this.swe,
      this.urd,
      this.zho});

  Translations.fromJson(Map<String, dynamic> json) {
    ara = json['ara'] != null ? Kal.fromJson(json['ara']) : null;
    ces = json['ces'] != null ? Kal.fromJson(json['ces']) : null;
    cym = json['cym'] != null ? Kal.fromJson(json['cym']) : null;
    deu = json['deu'] != null ? Kal.fromJson(json['deu']) : null;
    est = json['est'] != null ? Kal.fromJson(json['est']) : null;
    fin = json['fin'] != null ? Kal.fromJson(json['fin']) : null;
    fra = json['fra'] != null ? Eng.fromJson(json['fra']) : null;
    hrv = json['hrv'] != null ? Kal.fromJson(json['hrv']) : null;
    hun = json['hun'] != null ? Kal.fromJson(json['hun']) : null;
    ita = json['ita'] != null ? Kal.fromJson(json['ita']) : null;
    jpn = json['jpn'] != null ? Kal.fromJson(json['jpn']) : null;
    kor = json['kor'] != null ? Kal.fromJson(json['kor']) : null;
    nld = json['nld'] != null ? Kal.fromJson(json['nld']) : null;
    per = json['per'] != null ? Kal.fromJson(json['per']) : null;
    pol = json['pol'] != null ? Kal.fromJson(json['pol']) : null;
    por = json['por'] != null ? Kal.fromJson(json['por']) : null;
    rus = json['rus'] != null ? Kal.fromJson(json['rus']) : null;
    slk = json['slk'] != null ? Kal.fromJson(json['slk']) : null;
    spa = json['spa'] != null ? Kal.fromJson(json['spa']) : null;
    swe = json['swe'] != null ? Kal.fromJson(json['swe']) : null;
    urd = json['urd'] != null ? Kal.fromJson(json['urd']) : null;
    zho = json['zho'] != null ? Kal.fromJson(json['zho']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ara != null) {
      data['ara'] = ara!.toJson();
    }
    if (ces != null) {
      data['ces'] = ces!.toJson();
    }
    if (cym != null) {
      data['cym'] = cym!.toJson();
    }
    if (deu != null) {
      data['deu'] = deu!.toJson();
    }
    if (est != null) {
      data['est'] = est!.toJson();
    }
    if (fin != null) {
      data['fin'] = fin!.toJson();
    }
    if (fra != null) {
      data['fra'] = fra!.toJson();
    }
    if (hrv != null) {
      data['hrv'] = hrv!.toJson();
    }
    if (hun != null) {
      data['hun'] = hun!.toJson();
    }
    if (ita != null) {
      data['ita'] = ita!.toJson();
    }
    if (jpn != null) {
      data['jpn'] = jpn!.toJson();
    }
    if (kor != null) {
      data['kor'] = kor!.toJson();
    }
    if (nld != null) {
      data['nld'] = nld!.toJson();
    }
    if (per != null) {
      data['per'] = per!.toJson();
    }
    if (pol != null) {
      data['pol'] = pol!.toJson();
    }
    if (por != null) {
      data['por'] = por!.toJson();
    }
    if (rus != null) {
      data['rus'] = rus!.toJson();
    }
    if (slk != null) {
      data['slk'] = slk!.toJson();
    }
    if (spa != null) {
      data['spa'] = spa!.toJson();
    }
    if (swe != null) {
      data['swe'] = swe!.toJson();
    }
    if (urd != null) {
      data['urd'] = urd!.toJson();
    }
    if (zho != null) {
      data['zho'] = zho!.toJson();
    }
    return data;
  }
}

//------------------------------ Demonyms ----------------------------------
class Demonyms {
  Eng? eng;
  Eng? fra;

  Demonyms({this.eng, this.fra});

  Demonyms.fromJson(Map<String, dynamic> json) {
    eng = json['eng'] != null ? Eng.fromJson(json['eng']) : null;
    fra = json['fra'] != null ? Eng.fromJson(json['fra']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (eng != null) {
      data['eng'] = eng!.toJson();
    }
    if (fra != null) {
      data['fra'] = fra!.toJson();
    }
    return data;
  }
}

//------------------------------ Eng ----------------------------------
class Eng {
  String? f;
  String? m;

  Eng({this.f, this.m});

  Eng.fromJson(Map<String, dynamic> json) {
    f = json['f'];
    m = json['m'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['f'] = f;
    data['m'] = m;
    return data;
  }
}

//------------------------------ Maps ----------------------------------
class Maps {
  String? googleMaps;
  String? openStreetMaps;

  Maps({this.googleMaps, this.openStreetMaps});

  Maps.fromJson(Map<String, dynamic> json) {
    googleMaps = json['googleMaps'];
    openStreetMaps = json['openStreetMaps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['googleMaps'] = googleMaps;
    data['openStreetMaps'] = openStreetMaps;
    return data;
  }
}

//------------------------------ Car ----------------------------------
class Car {
  List<String>? signs;
  String? side;

  Car({this.signs, this.side});

  Car.fromJson(Map<String, dynamic> json) {
    signs = json['signs'] != null ? json['signs'].cast<String>() : null;
    side = json['side'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['signs'] = signs;
    data['side'] = side;
    return data;
  }
}

//------------------------------ Flags ----------------------------------
class Flags {
  String? png;
  String? svg;

  Flags({this.png, this.svg});

  Flags.fromJson(Map<String, dynamic> json) {
    png = json['png'];
    svg = json['svg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['png'] = png;
    data['svg'] = svg;
    return data;
  }
}

//------------------------------ CapitalInfo ----------------------------------
class CapitalInfo {
  List<double>? latlng;

  CapitalInfo({this.latlng});

  CapitalInfo.fromJson(Map<String, dynamic> json) {
    latlng = json['latlng'] != null ? json['latlng'].cast<double>() : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latlng'] = latlng;
    return data;
  }
}

//------------------------------ PostalCode -----------------------------------
class PostalCode {
  String? format;
  String? regex;

  PostalCode({this.format, this.regex});

  PostalCode.fromJson(Map<String, dynamic> json) {
    format = json['format'];
    regex = json['regex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['format'] = format;
    data['regex'] = regex;
    return data;
  }
}
