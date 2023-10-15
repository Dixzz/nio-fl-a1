import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nio_demo/api/api_helper.dart';
import 'package:nio_demo/api/api_service_client.dart';
import 'package:nio_demo/components/home/models/brew_detail_model.dart';
import 'package:nio_demo/tools/iterables.dart';

class BrewDetailBloc extends Cubit<ApiResult<BrewItemDetailed>> {
  final ApiServiceClient _client;
  final int _id;

  BrewDetailBloc(this._id, this._client)
      : super(ApiResult<BrewItemDetailed>.loading()) {
    fetchBeers();
  }

  Future<void> fetchBeers() async {
    emit(ApiResult.loading());
    final res = (await _client.getBeerDetail(_id)).firstOrNull();
    if (res == null) {
      emit(ApiResult.error("No details"));
      return;
    }
    emit(ApiResult.success(res));
  }
}
