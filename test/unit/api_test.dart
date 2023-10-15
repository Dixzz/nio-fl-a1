import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_web_server/mock_web_server.dart';
import 'package:nio_demo/api/api_service_client.dart';
import 'package:nio_demo/api/url.dart';
import 'package:nio_demo/components/home/models/brew_model.dart';
import 'package:nio_demo/tools/iterables.dart';
import 'package:nio_demo/tools/logging_interceptor.dart';

void main() {
  late MockWebServer _server;
  late ApiServiceClient _client;
  final _headers = {'Content-Type': 'application/json; charset=utf-8'};

  setUp(() async {
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

  List<BrewItem> _sampleItems() {
    final itemsStr = BrewItem.sample;

    final List demoList = jsonDecode(itemsStr) ?? List.empty();
    final List<BrewItem> items = demoList
        .map((dynamic i) => BrewItem.fromJson(i as Map<String, dynamic>))
        .toList();
    return items;
  }

  test('check null response body', () async {
    _server.enqueue(headers: _headers);
    final task = await _client.getAllBeers(1);
    expect(task, isNull);
  });

  /// Hits API with mock response body
  /// Checks type NULL AND ID with response
  /// For EP `/beers`
  test('test GET all beer', () async {
    _server.enqueue(headers: _headers, body: BrewItem.sample);

    final task = await _client.getAllBeers(1);
    expect(task, isNotNull);
    expect(task, isNotEmpty);
    final item = task.firstOrNull();
    final demoItem = _sampleItems().first;

    expect(item, isNotNull);
    expect(item!.id, demoItem.id);
  });

  /// Hits API with mock response body
  /// Checks type NULL AND ID with response
  /// For EP `/beers/{id}`
  test('test getBeerDetail EP', () async {
    _server.enqueue(headers: _headers, body: BrewItem.sample);

    final demoItem = _sampleItems().first;
    final task = await _client.getBeerDetail(demoItem.id);
    expect(task, isNotNull);
    expect(task, isNotEmpty);
    final item = task.firstOrNull();

    expect(item, isNotNull);
    expect(item!.id, demoItem.id);
  });

  tearDown(() {
    _server.shutdown();
  });
}
