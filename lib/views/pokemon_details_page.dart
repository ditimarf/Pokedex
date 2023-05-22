import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/components/info_card_char_component.dart';
import 'package:pokedex/components/linear_progress_component.dart';
import 'package:pokedex/configs.dart';
import 'package:pokedex/models/response/pokemon_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pokedex/services/pokemon_service.dart';

import '../models/response/pokemon_details_model.dart';
import '../utils.dart';

class PokemonDetailsPage extends StatefulWidget {
  PokemonModel pokemon;

  PokemonDetailsPage(this.pokemon, {Key? key}) : super(key: key);

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState(pokemon);
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  PokemonModel pokemon;
  PokemonDetailsModel? details;
  Color backgroundColor = Configs.primaryDefault;

  _PokemonDetailsPageState(this.pokemon);

  @override
  void initState() {
    super.initState();
    _requestDetails();
  }

  _requestDetails() async {
    var details = await PokemonService.getPokemonDetails(pokemon.id!);
    var backgroundColor = Utils.getTypeColor(details?.types?.first?.type?.name);

    setState(() {
      this.details = details;
      this.backgroundColor = backgroundColor;
    });
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
              //appbar
              Row(
                children: [
                  IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(true)),
                  Text(
                    Utils.firstWordUpperCase(details!.name),
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        details?.idText() ?? "",
                        textAlign: TextAlign.end,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),

              //Pokeball Icon
              Container(
                alignment: Alignment.topRight,
                child: Image.asset(
                  'assets/images/pokeball.png',
                  scale: 2,
                  color: Colors.white.withOpacity(0.15),
                ),
              ),

              //Stats Card
              Container(
                margin: EdgeInsets.fromLTRB(8, paddingTop + 228, 8, 8),
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var type in details!.types!)
                          Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
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
                    ),
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
                        InfoCardCharComponent.defaultComponent(
                            'assets/images/weight.png',
                            '${(details!.weight! / 10)!}kg',
                            'Weight'),
                        const SizedBox(
                          height: 50,
                          child: VerticalDivider(
                            color: Configs.grayMinimumDefault,
                            thickness: 2,
                          ),
                        ),
                        InfoCardCharComponent.defaultComponent(
                            'assets/images/height.png',
                            '${(details!.height! / 10)!}m',
                            'Height'),
                        const SizedBox(
                          height: 50,
                          child: VerticalDivider(
                            color: Configs.grayMinimumDefault,
                            thickness: 2,
                          ),
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var ability in details!.abilities!)
                                Text(
                                  Utils.firstWordUpperCase(
                                      ability.ability!.name),
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.poppins(fontSize: 12),
                                )
                            ]),
                      ],
                    ),
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
                ),
              ),

              //Pokemon Image
              Padding(
                padding: EdgeInsets.only(top: paddingTop + 64),
                child: Image.network(
                  Utils.urlOfficialArtwork(details!.id!.toString()),
                  height: 228,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
