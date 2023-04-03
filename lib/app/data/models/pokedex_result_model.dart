import 'package:equatable/equatable.dart';

class PokedexResultModel extends Equatable {
  final String name;
  final String url;

  const PokedexResultModel({required this.name, required this.url});

  PokedexResultModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        url = json['url'];

  @override
  List<Object?> get props => [name, url];
}
