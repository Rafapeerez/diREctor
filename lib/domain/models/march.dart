import 'package:uuid/uuid.dart';

class March {
  final String id;
  final String name;
  final String author;
  final int number;
  final String? link;
  final String? moreInformation;

  March({
    required this.id,
    required this.name,
    required this.author,
    required this.number,
    this.link,
    this.moreInformation
  });

  March.empty()
    : id = "",
      name = "",
      author = "",
      number = 0,
      link = "",
      moreInformation = "";

  factory March.create({
    required String name,
    required String author,
    required int number,
    String? link,
    String? moreInformation
  }){
    final uuid = const Uuid().v4();
    return March(
      id: uuid,
      name: name,
      author: author,
      number: number,
      link: link,
      moreInformation: moreInformation
    );      
  }

  factory March.update({
    required String uuid,
    required String name,
    required String author,
    required int number,
    required String link,
    required String moreInformation
  }){
    return March(
      id: uuid,
      name: name,
      author: author,
      number: number,
      link: link,
      moreInformation: moreInformation
    );      
  }
}


