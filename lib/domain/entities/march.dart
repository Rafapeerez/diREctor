import 'package:uuid/uuid.dart';

class March {
  final String id;
  final String name;
  final String author;
  final String? history;
  final String? moreInformation;

  March({
    required this.id,
    required this.name,
    required this.author,
    this.history,
    this.moreInformation
  });

  factory March.create({
    required String name,
    required String author,
    String? history,
    String? moreInformation
  }){
    final uuid = const Uuid().v4();
    return March(
      id: uuid,
      name: name,
      author: author,
      history: history,
      moreInformation: moreInformation
    );      
  }
}


