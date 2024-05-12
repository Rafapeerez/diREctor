class MarchDB {
  final String id;
  final String name;
  final String author;
  final int number;
  final String? link;
  final String? moreInformation;

  MarchDB({
    required this.id,
    required this.name,
    required this.author,
    required this.number,
    this.link,
    this.moreInformation
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'author': author,
      'number': number,
      'link': link,
      'moreInformation': moreInformation,
    };
  }

  static fromMap(Map<String, dynamic> map) {
    return MarchDB(
      id: map['id'],
      name: map['name'],
      author: map['author'],
      number: map['number'],
      link: map['link'],
      moreInformation: map['moreInformation']
    );
  }
}
