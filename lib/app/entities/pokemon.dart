import 'package:equatable/equatable.dart';

class Pokemon extends Equatable {
  final String name;
  final bool isLiked;

  const Pokemon({required this.name,required this.isLiked});

  @override
  List<Object?> get props => [name, isLiked];

  Pokemon copyWith({
    String? name,
    bool? isLiked,
  }) {
    return Pokemon(
      name: name ?? this.name,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
