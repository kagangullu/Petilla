// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:petilla_app_project/view/other_view/detail_view.dart';
import 'package:petilla_app_project/view/theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/theme/sizes/project_card_sizes.dart';
import 'package:petilla_app_project/view/theme/sizes/project_icon_sizes.dart';
import 'package:petilla_app_project/view/theme/sizes/project_padding.dart';
import 'package:petilla_app_project/view/theme/sizes/project_radius.dart';
import 'package:petilla_app_project/view/widgets/fav_button.dart';

class NormalPetWidget extends StatefulWidget {
  const NormalPetWidget({
    Key? key,
    required this.sex,
    required this.name,
    required this.ageRange,
    required this.petBreed,
    required this.imagePath,
    required this.description,
    required this.city,
    required this.price,
    required this.petType,
    required this.ilce,
  }) : super(key: key);

  final String name;
  final String description;
  final String imagePath;
  final String ageRange;
  final String city;
  final String ilce;
  final String petBreed;
  final String petType;
  final String price;
  final String sex;

  @override
  State<NormalPetWidget> createState() => _NormalPetWidgetState();
}

class _NormalPetWidgetState extends State<NormalPetWidget> {
  late String name;
  late String price;
  late String city;
  late String imagePath;
  late bool _isSahiplen;

  @override
  void initState() {
    super.initState();
    name = widget.name;
    price = widget.price;
    city = widget.city;
    price == "0" ? _isSahiplen = true : _isSahiplen = false;
    imagePath = widget.imagePath;
  }

  @override
  Widget build(BuildContext context) {
    final subtitle2 = Theme.of(context).textTheme.subtitle2;

    return InkWell(
      borderRadius: ProjectRadius.allRadius,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailView(
              name: widget.name,
              description: widget.description,
              imagePath: widget.imagePath,
              ageRange: widget.ageRange,
              city: widget.city,
              ilce: widget.ilce,
              petBreed: widget.petBreed,
              petType: widget.petType,
              price: widget.price,
              sex: widget.sex,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: LightThemeColors.white,
          borderRadius: ProjectRadius.allRadius,
        ),
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
                  Expanded(
                    flex: 45,
                    child: _nameText(
                      subtitle2?.copyWith(fontSize: 16, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  const Spacer(flex: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Expanded(
                      flex: 45,
                      child: _priceText(subtitle2),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              _location(),
            ],
          ),
        ),
      ),
    );
  }

  Text _priceText(TextStyle? subtitle2) {
    return Text(
      _isSahiplen ? "Sahiplen" : "${price}TL",
      style: _isSahiplen
          ? subtitle2?.copyWith(color: LightThemeColors.miamiMarmalade, overflow: TextOverflow.ellipsis)
          : subtitle2?.copyWith(overflow: TextOverflow.ellipsis),
    );
  }

  Text _nameText(TextStyle? subtitle2) => Text(name, style: subtitle2);

  Row _location() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _placeIcon(),
        Text(city, overflow: TextOverflow.clip),
      ],
    );
  }

  Icon _placeIcon() {
    return const Icon(
      Icons.location_on_outlined,
      size: ProjectIconSizes.smallIconSize,
      color: LightThemeColors.pastelStrawberry,
    );
  }

  Container _imageContainer() {
    return Container(
      width: ProjectCardSizes.secondaryCardWidth,
      height: ProjectCardSizes.secondaryCardHeight,
      decoration: BoxDecoration(
        color: LightThemeColors.miamiMarmalade,
        borderRadius: ProjectRadius.allRadius,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(imagePath),
        ),
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: FavButton(
          ageRange: widget.ageRange,
          city: widget.city,
          ilce: widget.ilce,
          petBreed: widget.petBreed,
          petType: widget.petType,
          price: widget.price,
          description: widget.description,
          name: widget.name,
          imagePath: widget.imagePath,
          sex: widget.sex,
        ),
      ),
    );
  }
}
