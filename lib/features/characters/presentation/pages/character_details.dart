import 'package:flutter/material.dart';
import 'package:mbank_test_app/features/characters/domain/entities/character.dart';
import 'package:mbank_test_app/features/characters/presentation/widgets/list_item_image.dart';

class CharacterDetailsScreen extends StatefulWidget {
  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);

  final Character character;

  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.character.name ?? '')),
        body: _Body(character: widget.character));
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key, required this.character}) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          ListItemImage(image: character.image, size: 100),
          const SizedBox(height: 20.0),
          Text(character.name ?? ''),
          const SizedBox(height: 10.0),
          Text(character.species ?? ''),
        ],
      ),
    );
  }
}
