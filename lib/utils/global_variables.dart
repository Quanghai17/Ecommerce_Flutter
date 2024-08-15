import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GlobalVariables {
  static const TextStyle appBarTextStyle =
      TextStyle(fontStyle: FontStyle.normal, fontSize: 15, color: Colors.black);

  static const List<String> carouselImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  static AppBar getAppBar({
    required BuildContext context,
    required dynamic onClickSearchNavigateTo,
    bool? wantBackNavigation = true,
    bool? wantActions = true,
    String? title = "",
  }) {
    return AppBar(
      title: Text(
        "$title",
        style: appBarTextStyle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      leading: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * .005)
            .copyWith(right: 0),
        child: wantBackNavigation!
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context))
            : InkWell(
                onTap: () {},
                child: Image.asset(
                  "assets/images/logo.png",
                ),
              ),
      ),
      backgroundColor: Colors.white,
      elevation: 2,
      actions: wantActions!
          ? [
              Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.height * 0.035),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(
                        "assets/images/search-svg.svg",
                        height: 25,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.height * .04),
                    InkWell(
                        onTap: () {}, child: const Icon(Icons.mic, size: 30)),
                  ],
                ),
              ),
            ]
          : [],
    );
  }
}
