import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex/components/card_component.dart';
import 'package:pokedex/configs.dart';
import 'package:pokedex/models/response/pokemon_model.dart';
import 'package:pokedex/services/pokemon_service.dart';
import 'package:pokedex/views/pokemon_details_page.dart';

class PokedexHomePage extends StatefulWidget {
  final String title;

  const PokedexHomePage({super.key, required this.title});

  @override
  State<PokedexHomePage> createState() => _PokedexHomePageState();
}

class _PokedexHomePageState extends State<PokedexHomePage> {
  int qtyMaxItens = 0;
  final PagingController<int, PokemonModel> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _getNewPokemonPage(pageKey);
    });

    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _getNewPokemonPage(int page) async {
    try {
      final newPokemonPage =
          await PokemonService.getPokemonList(page, Configs.pageSize);
      if (newPokemonPage != null && newPokemonPage.results != null) {
        qtyMaxItens = newPokemonPage.count!;
        final isLastPage = newPokemonPage.results!.length < Configs.pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(newPokemonPage.results!);
        } else {
          final nextPage = page + 1;
          _pagingController.appendPage(newPokemonPage.results!, nextPage);
        }
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    double paddingTop = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      backgroundColor: Configs.primaryDefault,
      body: Padding(
        padding: EdgeInsets.fromLTRB(8, paddingTop + 16, 8, 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 16),
              child: Row(children: [
                Image.asset(
                  'assets/images/pokeball.png',
                  color: Colors.white,
                  scale: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'Pokédex',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ]),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: PagedGridView<int, PokemonModel>(
                  padding: EdgeInsets.zero,
                  pagingController: _pagingController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  builderDelegate: PagedChildBuilderDelegate<PokemonModel>(
                    itemBuilder: (context, item, index) => GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PokemonDetailsPage(item, qtyMaxItens)),
                      ),
                      child: CardComponent.defaultComponent(item),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
