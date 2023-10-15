import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:nio_demo/api/api_helper.dart';
import 'package:nio_demo/widgets/symmetric_loader.dart';

extension ContextAct on BuildContext {
  GoRouter get goRouter => GoRouter.of(this);
  // Object? get goExtra => GoRouterState.of(this).extra;

  get args =>
      ModalRoute
          .of(this)!
          .settings
          .arguments;
}

extension ApiResultExt<T> on ApiResult<T> {
  Widget toWidget(
          {final Widget Function(T)? successBuilder,
          final Widget Function()? loadBuilder,
          final Widget Function(String)? errorBuilder}) =>
      map(
          success: (success) {
            return successBuilder?.call(success.data) ??
                Text(success.data.toString());
          },
          loading: (_) =>
              loadBuilder?.call() ??
              const Center(
                child: SymmetricSizeBoxedProgressIndicator(),
              ),
          error: (error) =>
              errorBuilder?.call(error.error) ??
              Center(child: Text(error.error)));
}
