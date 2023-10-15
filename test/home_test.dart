import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:nio_demo/api/api_service_client.dart';
import 'package:nio_demo/api/url.dart';
import 'package:nio_demo/components/home/beer_detail.dart';
import 'package:nio_demo/components/home/home.dart';
import 'package:nio_demo/components/home/models/brew_model.dart';
import 'package:nio_demo/tools/logging_interceptor.dart';

import 'login_test.dart';

class MockAdapter extends IOHttpClientAdapter {
  final _adapter = IOHttpClientAdapter();

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future? cancelFuture,
  ) async {
    final uri = options.uri;
    print("Wew path=${uri.path}");

    switch (uri.path) {
      case '/v2/beers':
      case '/v2/beers/1':
        return ResponseBody.fromString(
          BrewItem.sample,
          // jsonEncode(['tag1', 'tag2']),
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      default:
        return ResponseBody.fromString('', 404);
    }
    // return _adapter.fetch(options, requestStream, cancelFuture);
  }

  @override
  void close({bool force = false}) {
    _adapter.close(force: force);
  }
}

main() {
  late ApiServiceClient _client;

  CustomBindings();
  setUpAll(() async {
    final dio = Dio(BaseOptions()
      ..connectTimeout = const Duration(seconds: 120)
      ..receiveTimeout = const Duration(seconds: 120));

    dio.httpClientAdapter = MockAdapter();
    // dio.options.baseUrl = UrlConstants.baseUrl;

    final dioInterceptor = dio.interceptors;
    dioInterceptor.add(LoggingPathInterceptor());
    _client = ApiServiceClient(dio, baseUrl: UrlConstants.baseUrl);
  });

  // setUp(() {
  //   TestWidgetsFlutterBinding.ensureInitialized();
  //   WidgetsBinding.instance.resetEpoch();
  // });

  /// Open home page
  /// Let it fetch from API
  /// Check for Progress Indicator
  /// Find 'First brewed' and match to Mock API Response
  /// Find First Grid view First
  testWidgets('Open home', (WidgetTester tester) async {
    // final FakeAsync fakeAsync = FakeAsync();
    await tester.pumpWidget(MaterialApp(
      home: Home(client: _client),
    ), Duration(seconds: 25));

    // await tester
    //     .runAsync(() async => await tester.pumpAndSettle());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.runAsync(() async {
      for (int i = 0; i < 5; i++) {
        // because pumpAndSettle doesn't work
        await tester.pump(Duration(seconds: 5));
      }
    });

    // await mockNetworkImagesFor(() async {
    // });
    expect(find.text('First brewed 04/2007'), findsAtLeastNWidgets(1));
    await tester.drag(find.byType(RefreshIndicator), Offset(0, 500));

    await tester.pump();
    expect(
      find.byType(RefreshProgressIndicator),
      findsOneWidget,
    );

    // await tester.pumpAndSettle();

  }, timeout: Timeout(Duration(seconds: 25)));

  /// Open BeerDetail page
  /// Let it fetch from API
  /// Find 'First brewed' and match to Mock API Response
  testWidgets('Open brew details', (tester) async {

    mockNetworkImagesFor(() async {
      await tester.pumpWidget(MaterialApp(
        home: BeerDetail(1, _client),
      ));
      expect(find.byType(BeerDetail), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.text('Getting know your beer better'), findsOneWidget);
      expect(find.text('04/2007'), findsOneWidget);
    });
  });
}
