import 'package:flutter/material.dart';
import '../../business/view_models/characters_list_view_model.dart';

class CharacterDetail extends StatelessWidget {
  final CharacterViewModel character;

  CharacterDetail(this.character);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Character Detail"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(character.name),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
/*return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.attributes?.card_artwork_url != null) ...[
              const SizedBox(width: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  width: 150,
                  height: 150,
                  imageUrl: article.attributes!.card_artwork_url!,
                ),
              ),
            ],
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      article.attributes?.name ?? '',
                      style: textTheme.subtitle1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        article.subscriptionType,
                        style: textTheme.subtitle2,
                      ),
                    ),
                    if (article.formattedReleaseDate != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          article.formattedReleaseDate!,
                          style: textTheme.subtitle2,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (article.attributes?.description != null)
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: Text(
              article.attributes!.description!,
              style: textTheme.subtitle1,
            ),
          ),
        if (article.attributes?.contributor_string != null)
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: Text(
              article.attributes!.contributor_string!,
              style: textTheme.subtitle1,
            ),
          ),
        if (article.attributes?.technology_triple_string != null)
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
            child: Text(
              article.attributes!.technology_triple_string!,
              style: textTheme.subtitle2,
            ),
          )
      ],
    );
  }
}*/
