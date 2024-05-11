class MarchDB {
  final String id;
  final String name;
  final String author;
  final String? link;
  final String? moreInformation;

  MarchDB(
      {required this.id,
      required this.name,
      required this.author,
      this.link,
      this.moreInformation});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'author': author,
      'link': link,
      'moreInformation': moreInformation,
    };
  }

  static fromMap(Map<String, dynamic> map) {
    return MarchDB(
      id: map['id'],
      name: map['name'],
      author: map['author'],
      link: map['link'],
      moreInformation: map['moreInformation']
    );
  }
}
