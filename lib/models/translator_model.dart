class Translator {
  final int id;
  final String name;
  final String language;

  Translator({required this.id, required this.name, required this.language});

  factory Translator.fromMap(Map<String, dynamic> map) {
    return Translator(
      id: map['id'],
      name: map['translator_name'],
      language: map['language'],
    );
  }
}
