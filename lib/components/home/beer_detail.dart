import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nio_demo/api/api_helper.dart';
import 'package:nio_demo/components/home/cubit/home_cubit.dart';
import 'package:nio_demo/components/home/models/brew_detail_model.dart';
import 'package:nio_demo/gen/assets.gen.dart';
import 'package:nio_demo/tools/context.dart';
import 'package:nio_demo/tools/sized_box.dart';
import 'package:nio_demo/widgets/appbar_action.dart';

import '../../api/api_service_client.dart';

class BeerDetail extends StatelessWidget {
  final int _id;
  final ApiServiceClient _client;
  const BeerDetail(this._id, this._client, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
                height: 300,
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(12)),
                      color: Color(0xFF1E2022)),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppbarAction(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 20,
                  ),
                  onTap: () {
                    context.goRouter.pop();
                  },
                ),
                SpaceVertical(30),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BlocProvider(
                    create: (_) => BrewDetailBloc.new(_id, _client),
                    child: BlocBuilder<BrewDetailBloc,
                            ApiResult<BrewItemDetailed>>(
                        buildWhen: (previous, current) {
                          return previous.mapOrNull(success: (s) => s) !=
                              current.mapOrNull(success: (s) => s);
                        },
                        builder: (_, state) => state.toWidget(
                            successBuilder: (s) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      s.name,
                                      style:
                                          TextStyle(color: Color(0xFFCACCCC), fontWeight: FontWeight.w600),
                                    ),
                                    SpaceVertical(8),
                                    Text(
                                      s.tagline,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                          color: Color(0xFF77838F),
                                          fontSize: 14),
                                    ),
                                    SpaceVertical(20),
                                    Center(
                                      child: SizedBox(
                                        height: 230,
                                        width: 160,
                                        child: ClipRRect(
                                        borderRadius:
                                          BorderRadius.circular(16),
                                        child: ColoredBox(
                                        color: Colors.grey.shade300,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 40.0,
                                                  vertical: 20),
                                          child: CachedNetworkImage(
                                              placeholder: (_, __) => Assets
                                                  .images.icPlaceholder
                                                  .image(),
                                              imageUrl: s.url),
                                        ),
                                        ),
                                        ),
                                      ),
                                    ),
                                    SpaceVertical(28),
                                    Text(
                                      'Description',
                                      style: TextStyle(),
                                    ),
                                    SpaceVertical(10),
                                    Text(
                                      s.description,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF77838F)),
                                    ),
                                    SpaceVertical(20),
                                    Text(
                                      'First Brewed'
                                    ),
                                    SpaceVertical(10),
                                    Text(
                                      s.firstBrewed,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF77838F)),
                                    ),
                                    SpaceVertical(20),
                                    Text(
                                      'Getting know your beer better',
                                      style: TextStyle(fontWeight: FontWeight.w500),
                                    ),
                                    SpaceVertical(20),
                                    Row(
                                      children: [
                                        GettingBetterPlaceHolder(
                                            string1: 'ABV',
                                            string2: s.abv.toString()),
                                        SpaceHorizontal(20),
                                        GettingBetterPlaceHolder(
                                            string1: 'IBU',
                                            string2: s.ibu.toString()),
                                      ],
                                    ),
                                    SpaceVertical(20),
                                    Row(
                                      children: [
                                        GettingBetterPlaceHolder(
                                            string1: 'Target FG',
                                            string2: s.targetFg.toString()),
                                        SpaceHorizontal(20),
                                        GettingBetterPlaceHolder(
                                            string1: 'Target OG',
                                            string2: s.ibu.toString()),
                                      ],
                                    ),
                                    SpaceVertical(20),
                                    Row(
                                      children: [
                                        GettingBetterPlaceHolder(
                                            string1: 'Ebc',
                                            string2: s.ebc.toString()),
                                        SpaceHorizontal(20),
                                        GettingBetterPlaceHolder(
                                            string1: 'Srm',
                                            string2: s.srm.toString()),
                                      ],
                                    ),
                                    SpaceVertical(20),
                                    Row(
                                      children: [
                                        GettingBetterPlaceHolder(
                                            string1: 'Ph',
                                            string2: s.ebc.toString()),
                                        SpaceHorizontal(20),
                                        GettingBetterPlaceHolder(
                                            string1: 'Attenuation level',
                                            string2: s.attenLevel.toString()),
                                      ],
                                    ),
                                    SpaceVertical(16),
                                  ],
                                ))),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GettingBetterPlaceHolder extends StatelessWidget {
  final String string1;
  final String string2;

  const GettingBetterPlaceHolder(
      {required this.string1, required this.string2});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(
      children: [
        SizedBox.square(
          dimension: 40,
          child: Assets.images.icBeerBlack.image(),
        ),
        SpaceHorizontal(11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                string1.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                string2,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 14,
                    // fontWeight: FontWeight.normal,
                    color: Color(0xFF77838F)),
              )
            ],
          ),
        )
      ],
    ));
  }
}
