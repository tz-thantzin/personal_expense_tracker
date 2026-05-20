class Currency {
  const Currency({
    required this.code,
    required this.name,
    required this.symbol,
    required this.flag,
    this.decimalDigits = 2,
  });

  final String code;
  final String name;
  final String symbol;
  final String flag;
  final int decimalDigits;

  static const usd = Currency(
    code: 'USD',
    name: 'US Dollar',
    symbol: r'$',
    flag: '🇺🇸',
  );
  static const eur = Currency(
    code: 'EUR',
    name: 'Euro',
    symbol: '€',
    flag: '🇪🇺',
  );
  static const gbp = Currency(
    code: 'GBP',
    name: 'British Pound',
    symbol: '£',
    flag: '🇬🇧',
  );
  static const jpy = Currency(
    code: 'JPY',
    name: 'Japanese Yen',
    symbol: '¥',
    flag: '🇯🇵',
    decimalDigits: 0,
  );
  static const cny = Currency(
    code: 'CNY',
    name: 'Chinese Yuan',
    symbol: '¥',
    flag: '🇨🇳',
  );
  static const krw = Currency(
    code: 'KRW',
    name: 'South Korean Won',
    symbol: '₩',
    flag: '🇰🇷',
    decimalDigits: 0,
  );
  static const sgd = Currency(
    code: 'SGD',
    name: 'Singapore Dollar',
    symbol: r'S$',
    flag: '🇸🇬',
  );
  static const hkd = Currency(
    code: 'HKD',
    name: 'Hong Kong Dollar',
    symbol: r'HK$',
    flag: '🇭🇰',
  );
  static const twd = Currency(
    code: 'TWD',
    name: 'Taiwan Dollar',
    symbol: r'NT$',
    flag: '🇹🇼',
  );
  static const inr = Currency(
    code: 'INR',
    name: 'Indian Rupee',
    symbol: '₹',
    flag: '🇮🇳',
  );
  static const idr = Currency(
    code: 'IDR',
    name: 'Indonesian Rupiah',
    symbol: 'Rp',
    flag: '🇮🇩',
    decimalDigits: 0,
  );
  static const myr = Currency(
    code: 'MYR',
    name: 'Malaysian Ringgit',
    symbol: 'RM',
    flag: '🇲🇾',
  );
  static const thb = Currency(
    code: 'THB',
    name: 'Thai Baht',
    symbol: '฿',
    flag: '🇹🇭',
  );
  static const vnd = Currency(
    code: 'VND',
    name: 'Vietnamese Dong',
    symbol: '₫',
    flag: '🇻🇳',
    decimalDigits: 0,
  );
  static const php = Currency(
    code: 'PHP',
    name: 'Philippine Peso',
    symbol: '₱',
    flag: '🇵🇭',
  );
  static const mmk = Currency(
    code: 'MMK',
    name: 'Myanmar Kyat',
    symbol: 'Ks',
    flag: '🇲🇲',
    decimalDigits: 0,
  );
  static const aud = Currency(
    code: 'AUD',
    name: 'Australian Dollar',
    symbol: r'A$',
    flag: '🇦🇺',
  );

  static const supported = <Currency>[
    usd,
    eur,
    gbp,
    jpy,
    cny,
    krw,
    sgd,
    hkd,
    twd,
    inr,
    idr,
    myr,
    thb,
    vnd,
    php,
    mmk,
    aud,
  ];

  static Currency fromCode(String code) {
    return supported.firstWhere(
      (currency) => currency.code == code,
      orElse: () => usd,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Currency && other.code == code);

  @override
  int get hashCode => code.hashCode;
}
