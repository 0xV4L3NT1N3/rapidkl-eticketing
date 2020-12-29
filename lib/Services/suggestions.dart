




class Stations {
  static final List<String> stations = [
    'Sungai Buloh', 'Tun Razak Exchange',

    'Kampung Selamat', 'Cochrane',

    'Kwasa Damansara', 'Maluri',

    'Kwasa Sentral', 'Taman Pertama',

    'Kota Damansara', 'Taman Midah',

    'Surian', 'Taman Mutiara',

    'Mutiara Damansara', 'Taman Connaught',

    'Bandar Utama', 'Taman Suntex',

    'Taman Tun Dr Ismail', 'Sri Raya',

    'Phileo Damansara', 'Bandar Tun Hussein Onn',

    'Pusat Bandar Damansara', 'Batu 11 Cheras',

    'Semantan', 'Bukit Dukung',

    'Muzium Negara', 'Sungai Jernih',

    'Pasar Seni',

    'Merdeka', 'Kajang',

    'Bukit Bintang',
  ];


  static List<String> getSuggestions(String query) {
    List<String> matches = List();
    matches.addAll(stations);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}