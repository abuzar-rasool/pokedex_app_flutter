import 'package:equatable/equatable.dart';
import 'package:pokedex_app_flutter/app/data/models/pokedex_result_model.dart';

class PokedexResponseModel extends Equatable{
  final int count;
  final String? next;
  final String? previous;
  final List<PokedexResultModel> results;

  const PokedexResponseModel({required this.count, this.next, this.previous,required this.results});

  PokedexResponseModel.fromJson(Map<String, dynamic> json):
    count = json['count'],
    next = json['next'],
    previous = json['previous'],
   results = <PokedexResultModel>[] {
    json['results'].forEach((v) {
        results.add(PokedexResultModel.fromJson(v));
      });
   }
   
     @override
     List<Object?> get props => [count, next, previous, results];
}

