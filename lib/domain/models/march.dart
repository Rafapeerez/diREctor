import 'package:uuid/uuid.dart';

class March {
  final String id;
  final String name;
  final String author;
  final String? link;
  final String? moreInformation;

  March({
    required this.id,
    required this.name,
    required this.author,
    this.link,
    this.moreInformation
  });

  March.empty()
    : id = "",
      name = "",
      author = "",
      link = "",
      moreInformation = "";

  factory March.create({
    required String name,
    required String author,
    String? link,
    String? moreInformation
  }){
    final uuid = const Uuid().v4();
    return March(
      id: uuid,
      name: name,
      author: author,
      link: link,
      moreInformation: moreInformation
    );      
  }
}


