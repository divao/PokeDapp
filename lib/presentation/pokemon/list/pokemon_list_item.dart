import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poke_dapp/presentation/adaptive_progress_indicator.dart';
import 'package:poke_dapp/presentation/common/pd_theme.dart';
import 'package:poke_dapp/presentation/common/selectable/adaptive_selectable.dart';

class PokemonListItem extends StatelessWidget {
  const PokemonListItem(
      {@required this.name, @required this.imageUrl, this.onTap})
      : assert(name != null),
        assert(imageUrl != null);

  final String name;
  final String imageUrl;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CachedNetworkImage(
                placeholder: (context, _) => AdaptativeProgressIndicator(),
                imageUrl: imageUrl,
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.error),
                ),
              ),
              Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: PDTheme.of(context).primaryTextColor,
                ),
              ),
            ],
          ),
          Material(
            color: Colors.transparent,
            child: AdaptiveSelectable(
              onTap: onTap,
              child: Container(),
            ),
          )
        ],
      );
}
