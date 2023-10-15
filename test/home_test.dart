import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mock_web_server/mock_web_server.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:nio_demo/api/api_service_client.dart';
import 'package:nio_demo/api/url.dart';
import 'package:nio_demo/components/beer_detail.dart';
import 'package:nio_demo/components/home/home.dart';
import 'package:nio_demo/components/home/models/brew_model.dart';
import 'package:nio_demo/tools/logging_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_test.dart';

main() {
  late MockWebServer _server;
  late ApiServiceClient _client;
  final _headers = {'Content-Type': 'application/json; charset=utf-8'};

  CustomBindings();
  setUpAll(() async {
    // HttpOverrides.global = null;
    _server = MockWebServer();
    // _server.dispatcher = (HttpRequest request) async {
    //   var res = dispatcherMap[request.uri.path];
    //   if (res != null) {
    //     return res;
    //   }
    //   return new MockResponse()..httpCode = 404;
    // };

    // TestWidgetsFlutterBinding.ensureInitialized();
    await _server.start();
    final dio = Dio(BaseOptions()
      ..connectTimeout = const Duration(seconds: 120)
      ..receiveTimeout = const Duration(seconds: 120));

    dio.options.baseUrl = UrlConstants.baseUrl;

    final dioInterceptor = dio.interceptors;
    dioInterceptor.add(LoggingPathInterceptor());
    _client = ApiServiceClient(dio, baseUrl: _server.url);
  });


  /// Open home page
  /// Let it fetch from API
  /// Find 'First brewed' and match to Mock API Response
  /// Find First Grid view First
  testWidgets('Open home', (tester) async {
    SharedPreferences.setMockInitialValues({});

    mockNetworkImagesFor(() async {
      _server.enqueue(headers: _headers, body: BrewItem.sample);
      await tester.pumpWidget(MaterialApp(
        home: Home(client: _client),
      ));
      expect(find.byType(Home), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.text('First brewed 04/2007'), findsOneWidget);
      await tester.fling(
        find.byType(PagedGridView),
        const Offset(0, -200),
        3000,
      );
      await tester.pumpAndSettle();
      expect(find.text('First brewed 04/2007'), findsOneWidget);
    });
  });

  /// Open BeerDetail page
  /// Let it fetch from API
  /// Find 'First brewed' and match to Mock API Response
  testWidgets('Open brew details', (tester) async {
    SharedPreferences.setMockInitialValues({});

    mockNetworkImagesFor(() async {
      _server.enqueue(headers: _headers, body: BrewItem.sample);
      await tester.pumpWidget(MaterialApp(
        home: BeerDetail(1, _client),
      ));
      expect(find.byType(BeerDetail), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.text('Getting know your beer better'), findsOneWidget);
    });
  });

  tearDown(() {
    _server.shutdown();
  });
}
