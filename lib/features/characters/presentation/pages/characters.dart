import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mbank_test_app/core/constants/strings.dart';
import 'package:mbank_test_app/core/injection_container.dart';
import 'package:mbank_test_app/core/resources/colors.dart';
import 'package:mbank_test_app/core/resources/text_styles.dart';
import 'package:mbank_test_app/core/routes/routes.dart';
import 'package:mbank_test_app/features/characters/domain/entities/character.dart';
import 'package:mbank_test_app/features/characters/presentation/bloc/character/character_bloc.dart';
import 'package:mbank_test_app/features/characters/presentation/bloc/character/character_event.dart';
import 'package:mbank_test_app/features/characters/presentation/widgets/list_item_image.dart';

class CharactersScreen extends StatelessWidget {
  CharactersScreen({Key? key}) : super(key: key);

  final CharacterBloc characterBloc = sl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(AppStrings.characters)),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return BlocProvider<CharacterBloc>(
                        create: (context) => sl(),
                        child: _AlertDialog(characterBloc: characterBloc,));
                  },
                );
              },
              icon: const Icon(Icons.filter_alt_outlined)),
          const SizedBox(width: 20),
        ],
      ),
      body: BlocProvider<CharacterBloc>(
        create: (context) => characterBloc,
        child: const _Body(),
      ),
    );
  }
}

class _AlertDialog extends StatefulWidget {
  const _AlertDialog({Key? key, required this.characterBloc}) : super(key: key);
  final CharacterBloc characterBloc;

  @override
  State<_AlertDialog> createState() => _AlertDialogState();
}

class _AlertDialogState extends State<_AlertDialog> {

  String? _selectedSpecie;

  @override
  void initState() {
    super.initState();
    _selectedSpecie = widget.characterBloc.filterModel.specie;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text(
        AppStrings.setupFilter,
        style: AppTextStyles.alertDialogTitle,
      )),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              AppStrings.chooseSpecies,
              style: AppTextStyles.alertDialogItem,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 4.0,
              runSpacing: 0.0,
              children: SpeciesChip.speciesList.map((specie) {
                return _ChoiceChipWidget(
                  specie: specie,
                  selectedSpecie: _selectedSpecie,
                  onSelectionChanged: (selected) {
                    setState(() {
                      _selectedSpecie = selected;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
            onPressed: () {
              widget.characterBloc.add(SpeciesCharacterEvent(_selectedSpecie));
              Navigator.of(context).pop();
            },
            child: Text(AppStrings.ok)),
        ElevatedButton(
            onPressed: () {
              widget.characterBloc.add(const ClearFilterCharacterEvent());
              Navigator.of(context).pop();
            },
            child: Text(AppStrings.clear)),
      ],
    );
  }
}

class _ChoiceChipWidget extends StatefulWidget {
  final String specie;
  final String? selectedSpecie;
  final Function(String?) onSelectionChanged;

  const _ChoiceChipWidget({
    Key? key,
    required this.specie,
    required this.selectedSpecie,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  State<_ChoiceChipWidget> createState() => _ChoiceChipWidgetState();
}

class _ChoiceChipWidgetState extends State<_ChoiceChipWidget> {
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(widget.specie),
      onSelected: (isSelected) {
        widget.onSelectionChanged(isSelected ? widget.specie : null);
        setState(() {});
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(46)),
        side: BorderSide(color: AppColors.greyscale300, width: 1.0),
      ),
      selected: widget.specie == widget.selectedSpecie,
      selectedColor: AppColors.blue600,
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 10),
        _SearchField(),
        SizedBox(height: 10),
        _CharacterListWidget(),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        onChanged: (value) {
          BlocProvider.of<CharacterBloc>(context)
              .add(SearchCharacterEvent(value));
        },
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          filled: true,
          fillColor: Colors.grey.shade200,
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
          hintText: AppStrings.searchCharacters,
          hintStyle: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}

class _CharacterListWidget extends StatefulWidget {
  const _CharacterListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_CharacterListWidget> createState() => _CharacterListWidgetState();
}

class _CharacterListWidgetState extends State<_CharacterListWidget> {
  @override
  void initState() {
    final bloc = BlocProvider.of<CharacterBloc>(context);
    bloc.pagingController.addPageRequestListener((pageKey) {
      bloc.add(PagingCharacterEvent(pageKey));
    });
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<CharacterBloc>(context).pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CharacterBloc>(context);
    return Expanded(
      child: PagedListView<int, Character>(
          pagingController: bloc.pagingController,
          builderDelegate: PagedChildBuilderDelegate<Character>(
              itemBuilder: (context, character, index) => _ItemListWidget(
                    character: character,
                  ))),
    );
  }
}

class _ItemListWidget extends StatelessWidget {
  const _ItemListWidget({
    Key? key,
    required this.character,
  }) : super(key: key);

  final Character? character;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: GestureDetector(
          onTap: () {
            context.goNamed(
              AppPages.toCharacterDetails,
              extra: character,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Row(
                children: [
                  ListItemImage(image: character?.image, size: 60),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          character?.name ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          character?.status ?? '',
                          style: const TextStyle(color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          character?.species ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class SpeciesChip {
  static final speciesList = [
    AppStrings.alien,
    AppStrings.human,
    AppStrings.humanoid,
    AppStrings.cronenberg,
  ];
}
