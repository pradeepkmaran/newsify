class Source {
  String id;
  String name;

  Source({required this.id, required this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    Source source = Source(id: json['id'].toString(), name: json['name'].toString());
    return source;
  }

}