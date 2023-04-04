# pokedex_app_flutter
[![Codemagic - Deployed](https://img.shields.io/badge/Heroku-Deployed-2ea44f)](https://pokedex_app.codemagic.app)

[![Live Web Preview](https://img.shields.io/badge/Live_Preview-2ea44f?style=for-the-badge)](https://pokedex_app.codemagic.app)

Pokedex app with flutter_bloc and form_builder_flutter and layered archiectecture.

## Flutter Version 
Flutter and dart version on which the app was built on

```
Flutter 3.7.6 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 12cb4eb7a0 (5 weeks ago) • 2023-03-01 10:29:26 -0800
Engine • revision ada363ee93
Tools • Dart 2.19.3 • DevTools 2.20.1
```

## Application Features 
1. Users can login/signup via Firebase and manage their authentication state using Cubit.
2. User sessions are persistent using Cubit and Firebase Authentication.
3. Email and password fields are validated using Flutter Formbuilder. The password field requires a minimum of 6 characters.
4. User favorite data is persisted in SharedPreferences which only gets deleted if the user explicilty logs out.
5. The app includes a paginated list view to display Pokemons.
6. All state management is done through cubit
7. Layered archiectecture is used.

## Application Preview

<div style="display:flex; justify-content:center">
  <img src="https://github.com/abuzar-rasool/pokedex_app_flutter/blob/main/gifs/favourite.gif" width="300" />
  <img src="https://github.com/abuzar-rasool/pokedex_app_flutter/blob/main/gifs/login.gif" width="300" />
</div>
