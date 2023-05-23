import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/models/response/pokemon_model.dart';

import '../configs.dart';
import '../utils.dart';

class CardComponent {
  static Widget defaultComponent(PokemonModel pokemon) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Configs.grayMinimumDefault),
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Configs.grayMinimumDefault,
            blurRadius: 9,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              alignment: Alignment.centerRight,
              child: Text(
                Utils.formatIdText(pokemon!.id),
                textAlign: TextAlign.right,
                style: GoogleFonts.poppins(
                    color: Configs.grayMediumDefault, fontSize: 10),
              )),
          CachedNetworkImage(
            imageUrl: Utils.urlOfficialArtwork(pokemon!.id!),
            imageBuilder: (context, imageProvider) => Image(
              image: imageProvider,
            ),
            height: 56,
            width: 56,
          ),
          Text(
            Utils.firstWordUpperCase(pokemon.name),
            style: GoogleFonts.poppins(color: Configs.grayMaximumDefault),
          ),
        ],
      ),
    );
  }
}
