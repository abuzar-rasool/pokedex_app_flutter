import 'package:pokedex_app_flutter/app/app.dart';
import 'package:pokedex_app_flutter/core/bootstrap.dart';

void main() async {
  await bootstrap(() => const App());
}

