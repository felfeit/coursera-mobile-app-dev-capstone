class CountryModel {
  final String name;
  final String code;
  final String flagUrl;

  const CountryModel({
    required this.name,
    required this.code,
    required this.flagUrl,
  });

  @override
  String toString() => name;
}
