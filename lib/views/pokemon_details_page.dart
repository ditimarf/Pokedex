import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/components/info_card_char_component.dart';
import 'package:pokedex/components/linear_progress_component.dart';
import 'package:pokedex/configs.dart';
import 'package:pokedex/models/response/pokemon_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pokedex/models/response/pokemon_species_model.dart';
import 'package:pokedex/services/pokemon_service.dart';

import '../models/response/pokemon_details_model.dart';
import '../utils.dart';

class PokemonDetailsPage extends StatefulWidget {
  PokemonModel pokemon;
  int qtyMaxPokemons;

  PokemonDetailsPage(this.pokemon, this.qtyMaxPokemons, {Key? key})
      : super(key: key);

  @override
  State<PokemonDetailsPage> createState() =>
      _PokemonDetailsPageState(pokemon, qtyMaxPokemons);
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  int qtyMaxPokemons;
  PokemonModel pokemon;
  PokemonDetailsModel? details;
  PokemonSpeciesModel? species;
  Color backgroundColor = Configs.primaryDefault;

  _PokemonDetailsPageState(this.pokemon, this.qtyMaxPokemons);

  @override
  void initState() {
    super.initState();
    _loadPokemon(pokemon.id!);
  }

  _loadPokemon(String id) async {
    var species = await PokemonService.getPokemonSpecies(id);
    var details = await PokemonService.getPokemonDetails(id);

    var backgroundColor = Utils.getTypeColor(details?.types?.first?.type?.name);

    setState(() {
      this.details = details;
      this.species = species;
      this.backgroundColor = backgroundColor;
    });
  }

  loadPrevious() {
    var previousPokemonId = details!.id! - 1;
    _loadPokemon(previousPokemonId.toString());
  }

  loadNext() {
    var previousPokemonId = details!.id! + 1;
    _loadPokemon(previousPokemonId.toString());
  }

  @override
  Widget build(BuildContext context) {
    double paddingTop = MediaQuery.of(context).viewPadding.top;

    if (details == null) {
      return Container(
        color: backgroundColor,
        child: const Center(
          child: SpinKitFadingCube(
            color: Configs.grayMaximumDefault,
            size: 50.0,
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
          padding: EdgeInsets.only(top: paddingTop),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              createAppBar(),
              createBackgroundImage(),
              createInfosCard(),
            ],
          ),
        ),
      );
    }
  }

  Widget createAppBar() {
    return Row(
      children: [
        IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(true)),
        Text(
          Utils.firstWordUpperCase(details!.name),
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              Utils.formatIdText(details?.id?.toString()),
              textAlign: TextAlign.end,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  Widget createBackgroundImage() {
    return Container(
      alignment: Alignment.topRight,
      child: Image.asset(
        'assets/images/pokeball.png',
        scale: 2,
        color: Colors.white.withOpacity(0.15),
      ),
    );
  }

  Widget createInfosCard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        createTopCardInfo(),
        Container(
            margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                createLabelTypes(),
                createAboutCard(),
                createTextInformations(),
                createBaseStats()
              ],
            ))
      ],
    );
  }

  Widget createPokemonImage() {
    return CachedNetworkImage(
      imageUrl: Utils.urlOfficialArtwork(details!.id!.toString()),
      imageBuilder: (context, imageProvider) => Image(
        image: imageProvider,
      ),
      height: 228,
    );
  }

  Widget createTopCardInfo() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                      visible: details!.id != 1,
                      child: IconButton(
                          icon: const Icon(Icons.chevron_left,
                              color: Colors.white),
                          onPressed: () => loadPrevious())),
                  Visibility(
                      visible: details!.id! < qtyMaxPokemons,
                      child: IconButton(
                          icon: const Icon(Icons.chevron_right,
                              color: Colors.white),
                          onPressed: () => loadNext())),
                ],
              ),
            ),
            Container(
                height: 60,
                margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: null)
          ],
        ),
        createPokemonImage()
      ],
    );
  }

  Widget createLabelTypes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var type in details!.types!)
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
                color: Utils.getTypeColor(type.type!.name!),
                borderRadius: BorderRadius.circular(24)),
            child: Text(
              Utils.firstWordUpperCase(type.type!.name!),
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          )
      ],
    );
  }

  Widget createAboutCard() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text('About',
              style: GoogleFonts.poppins(
                  color: backgroundColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w700)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InfoCardCharComponent.defaultComponent('assets/images/weight.png',
                '${(details!.weight! / 10)!}kg', 'Weight'),
            const SizedBox(
              height: 50,
              child: VerticalDivider(
                color: Configs.grayMinimumDefault,
                thickness: 2,
              ),
            ),
            InfoCardCharComponent.defaultComponent('assets/images/height.png',
                '${(details!.height! / 10)!}m', 'Height'),
            const SizedBox(
              height: 50,
              child: VerticalDivider(
                color: Configs.grayMinimumDefault,
                thickness: 2,
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              for (var ability in details!.abilities!)
                Text(
                  Utils.firstWordUpperCase(ability.ability!.name),
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(fontSize: 12),
                )
            ]),
          ],
        ),
      ],
    );
  }

  Widget createTextInformations() {
    String flavorText = '';
    var descriptionOfSwordInEnglish = species!.flavorTextEntries!.firstWhere(
        (element) =>
            element.language!.name == 'en' && element.version!.name == 'sword');
    if (descriptionOfSwordInEnglish != null) {
      flavorText = descriptionOfSwordInEnglish.flavorText!;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
      child: Text(flavorText.replaceAll('\n', ''),
          style: GoogleFonts.poppins(fontSize: 12)),
    );
  }

  Widget createBaseStats() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 16),
          child: Text('Base stats',
              style: GoogleFonts.poppins(
                  color: backgroundColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w700)),
        ),
        for (var stat in details!.stats!)
          LinearProgressComponent.defaultComponent(
              stat.stat!.name!, stat.baseStat!, backgroundColor),
      ],
    );
  }
}
