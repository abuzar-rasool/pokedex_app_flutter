// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pokedex_app_flutter/app/cubits/home/home_cubit.dart';
import 'package:pokedex_app_flutter/app/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:pokedex_app_flutter/app/data/repositories/pokemon_repository/pokemon_repository.dart';
import 'package:pokedex_app_flutter/app/data/repositories/pokemon_repository/pokemon_repository_impl.dart';
import 'package:pokedex_app_flutter/app/entities/pokemon.dart';
import 'package:pokedex_app_flutter/app/presentation/widgets/animated_logo.dart';
import 'package:pokedex_app_flutter/services/http_service.dart';
import 'package:pokedex_app_flutter/services/snackbar_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Home'),
          leading: IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthenticationRepository>().logout();
            },
          ),
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border))],
        ),
        body: BlocProvider(
          create: (context) => HomeCubit(pokemonRepository: PokemonRepositoryImpl(httpService: context.read<HttpService>()))..loadPokemons(),
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state.status == HomeStatus.failure) {
                context.read<SnackBarService>().showGenericErrorSnackBar(context);
              }
            },
            builder: (context, state) {
              if (state.status == HomeStatus.initial) {
                return const Center(
                  child: AnimatedLogo(
                    isAnimating: true,
                    width: 40,
                    height: 40,
                  ),
                );
              } else if (state.pokemons.isEmpty) {
                return const Center(
                  child: Text('No Pokemon'),
                );
              } else {
                return HomeScreenLoadedView(
                  pokemons: state.pokemons,
                  onPaginate: () async => await context.read<HomeCubit>().loadPokemons(),
                  hasReachedMax: state.hasReachedMax,
                  key: const Key('home_screen_loaded_view'),
                );
              }
            },
          ),
        ));
  }
}

class HomeScreenLoadedView extends StatefulWidget {
  final List<Pokemon> pokemons;
  final FutureOr<void> Function() onPaginate;
  final bool hasReachedMax;

  const HomeScreenLoadedView({
    Key? key,
    required this.pokemons,
    required this.onPaginate,
    required this.hasReachedMax,
  }) : super(key: key);

  @override
  State<HomeScreenLoadedView> createState() => _HomeScreenLoadedViewState();
}

class _HomeScreenLoadedViewState extends State<HomeScreenLoadedView> {
  final _scrollController = ScrollController();
  bool paginating = false;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.hasReachedMax ? widget.pokemons.length : widget.pokemons.length + 1,
      itemBuilder: (context, index) {
        if (index >= widget.pokemons.length) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: AnimatedLogo(
                isAnimating: true,
                width: 40,
                height: 40,
              ),
            ),
          );
        }
        return ListTile(
          key: ValueKey('pokemon_${widget.pokemons[index].name}'),
          title: Text(widget.pokemons[index].name),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() async {
    print('onScroll $_isBottom $paginating');
    if (_isBottom && !paginating) {
      paginating = true;
      await widget.onPaginate();
      paginating = false;
    }
  }

  bool get _isBottom {
    if (_scrollController.position.pixels != 0 && _scrollController.position.atEdge) return true;
    return false;
  }
}
