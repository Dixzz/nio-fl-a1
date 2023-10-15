import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nio_demo/api/api_service_client.dart';
import 'package:nio_demo/components/home/models/brew_model.dart';
import 'package:nio_demo/gen/assets.gen.dart';
import 'package:nio_demo/routes/router.dart';
import 'package:nio_demo/tools/asset_image_gen.dart';
import 'package:nio_demo/tools/cards.dart';
import 'package:nio_demo/tools/sized_box.dart';
import 'package:nio_demo/widgets/appbar_action.dart';

class Home extends StatefulWidget {
  final ApiServiceClient client;
  const Home({Key? key, required this.client}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final pagingController =
      PagingController<int, BrewItem>(firstPageKey: 1);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pagingController.addPageRequestListener(fetchBeers);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    pagingController.dispose();
  }

  Future<void> fetchBeers([int? pageKeyTemp]) async {
    final pageKey = pageKeyTemp ??
        pagingController.nextPageKey ??
        pagingController.firstPageKey;

    final newItems = (await widget.client.getAllBeers(pageKey)) ?? List.empty();
    final isLastPage = newItems.isEmpty && pageKey > 0;
    if (isLastPage) {
      pagingController.appendLastPage(newItems);
    } else {
      final nextPageKey = pageKey + 1;
      pagingController.appendPage(newItems, nextPageKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E2022),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 0));
          pagingController.refresh();
          return;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppbarAction(
              icon: SizedBox.square(
                dimension: 16,
                child: Assets.images.icPerson.svg(),
              ),
              onTap: () {
                RouteNames.profile.navigate(context);
              },
            ),
            const SpaceVertical(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: const Text(
                'Time to Cheers! Choose your beer...',
                style: TextStyle(color: Color(0xFFCACCCC)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: PagedGridView<int, BrewItem>(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 300,
                      mainAxisSpacing: 28,
                      crossAxisSpacing: 14,
                      crossAxisCount: 2),
                  pagingController: pagingController,
                  builderDelegate:
                      PagedChildBuilderDelegate(itemBuilder: (c, item, index) {
                    return buildCard(c, item);
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(BuildContext c, BrewItem item) {
    return InkWell(
        onTap: () => RouteNames.beerDetail.navigate(c, item.id),
        child: RoundedCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 165,
                child: Stack(
                  children: [
                    Assets.images.icMask.image(
                        height: double.maxFinite,
                        width: double.maxFinite,
                        fit: BoxFit.fill),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SpaceVertical(12),
                        Center(
                          child: SizedBox.square(
                            dimension: 108,
                            child: CachedNetworkImage(
                              imageUrl: item.url,
                              placeholder: (_, __) => Center(
                                  child: SizedBox.square(
                                dimension: 48,
                                child: Assets.images.icPlaceholder
                                    .toImage(color: Colors.grey),
                              )),
                            ),
                          ),
                        ),
                        SpaceVertical(18),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: ColoredBox(
                              color: Colors.black,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: FittedBox(
                                  child: Text(
                                    "First brewed ${item.firstBrewed}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SpaceVertical(0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14),
                    ),
                    SpaceVertical(8),
                    Text(item.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal)),
                    SpaceVertical(12),
                    Wrap(
                      children: [
                        Wrap(
                          direction: Axis.vertical,
                          children: [
                            Text(
                              'Abv'.toUpperCase(),
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              item.abv.toString(),
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFF77838F)),
                            )
                          ],
                        ),
                        SpaceHorizontal(12),
                        Wrap(
                          direction: Axis.vertical,
                          children: [
                            Text(
                              'ibu'.toUpperCase(),
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              item.ibu.toString(),
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFF77838F)),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          radius: 12,
        ));
  }
}
