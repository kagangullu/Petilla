// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_service/models/pet_model.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/other_view/petilla_detail_view/petilla_detail_view.dart';
import 'package:petilla_app_project/constant/localization/localization.dart';
import 'package:petilla_app_project/constant/other_constant/icon_names.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_icon_sizes.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_radius.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NormalPetWidget extends StatefulWidget {
  const NormalPetWidget({Key? key, required this.petModel}) : super(key: key);

  final PetModel petModel;

  @override
  State<NormalPetWidget> createState() => _NormalPetWidgetState();
}

class _NormalPetWidgetState extends State<NormalPetWidget> {
  late bool _isClaim;
  bool? _isFav;

  favButton(docId) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getStringList("favs") == null) {
      _isFav = false;
    } else if (sharedPreferences.getStringList("favs")!.contains(docId)) {
      _isFav = true;
    } else {
      _isFav = false;
    }
  }

  addFav(docId) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> myList = sharedPreferences.getStringList("favs")!;
    myList.add(docId);
    await sharedPreferences.setStringList("favs", myList);
    setState(() {
      _isFav = true;
    });
  }

  removeFav(docId) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> myList = sharedPreferences.getStringList("favs")!;
    for (int i = 0; i < myList.length; i++) {
      if (myList[i] == docId) {
        myList.removeAt(i);
        break;
      }
    }
    await sharedPreferences.setStringList("favs", myList);
    setState(() {
      _isFav = false;
    });
  }

  changeFav(docId) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getStringList("favs") == null) {
      await sharedPreferences.setStringList("favs", []);
      addFav(docId);
    } else if (_isFav == false) {
      addFav(docId);
    } else if (_isFav == true) {
      removeFav(docId);
    }
  }

  @override
  void initState() {
    super.initState();
    widget.petModel.price == "0" ? _isClaim = true : _isClaim = false;
  }

  callDetailView() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return DetailView(
            petModel: widget.petModel,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subtitle2 = Theme.of(context).textTheme.subtitle2;
    return GestureDetector(
      onTap: () {
        callDetailView();
      },
      child: _mainContainer(subtitle2),
    );
  }

  Container _mainContainer(TextStyle? subtitle2) {
    return Container(
      decoration: _boxDecoration(),
      child: Padding(
        padding: ProjectPaddings.horizontalMainPadding,
        child: Column(
          children: [
            const SizedBox(height: 8),
            _imageContainer(),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _nameText(subtitle2)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _priceText(subtitle2),
                      const SizedBox(height: 4),
                      _location(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      borderRadius: ProjectRadius.allRadius,
      color: LightThemeColors.snowbank,
    );
  }

  Text _priceText(TextStyle? subtitle2) {
    return Text(
      _isClaim ? Localization.claim : "${widget.petModel.price}TL",
      style: _isClaim
          ? subtitle2?.copyWith(color: LightThemeColors.miamiMarmalade, overflow: TextOverflow.ellipsis)
          : subtitle2?.copyWith(overflow: TextOverflow.ellipsis),
    );
  }

  Row _location() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _placeIcon(),
        Text(
          widget.petModel.city,
          style: const TextStyle(fontSize: 13),
        ),
      ],
    );
  }

  Icon _placeIcon() {
    return const Icon(
      AppIcons.locationOnOtlinedIcon,
      size: ProjectIconSizes.smallIconSize,
      color: LightThemeColors.pastelStrawberry,
    );
  }

  Text _nameText(TextStyle? subtitle2) => Text(
        widget.petModel.name,
        style: subtitle2,
        overflow: TextOverflow.clip,
      );

  Expanded _imageContainer() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: ProjectRadius.allRadius,
          color: LightThemeColors.grey,
          image: DecorationImage(
            image: NetworkImage(widget.petModel.imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: _favButton(),
      ),
    );
  }

  FutureBuilder<Object?> _favButton() {
    return FutureBuilder(
      future: favButton(widget.petModel.docId),
      builder: (context, snapshot) {
        return Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {
              changeFav(widget.petModel.docId);
            },
            icon: _isFav ?? false
                ? const Icon(AppIcons.favoriteIcon, color: Colors.red)
                : const Icon(AppIcons.favoriteBorderIcon),
          ),
        );
      },
    );
  }
}
