import 'package:dio/dio.dart';
import 'package:nio_demo/components/home/models/brew_detail_model.dart';
import 'package:nio_demo/components/home/models/brew_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service_client.g.dart';

@RestApi()
abstract class ApiServiceClient {
  factory ApiServiceClient(Dio dio, {String? baseUrl}) = _ApiServiceClient;

  @GET('/beers')
  Future<List<BrewItem>?> getAllBeers(
    @Query('page') int page,
    // @Query('per_page') String perPage,
  );


  @GET('/beers/{id}')
  Future<List<BrewItemDetailed>?> getBeerDetail(
    @Path('id') int id,
  );
}
