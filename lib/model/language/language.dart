// ignore_for_file: public_member_api_docs, sort_constructors_first
class Language {
  String name;
  String flag;
  String languageCode;
  Language(
      {required this.name, required this.languageCode, required this.flag});

  static List<Language> languageList() {
    return <Language>[
      Language(name: "English", languageCode: "en", flag: "🇬🇧"),
      Language(name: "Myanmar", languageCode: "my", flag: "🇲🇲")
    ];
  }
}
