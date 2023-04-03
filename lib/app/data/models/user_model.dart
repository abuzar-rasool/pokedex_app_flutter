import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;

  const UserModel(this.id);
  
  @override
  List<Object> get props => [id];
}
