import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncValueWidget<T> extends ConsumerWidget {
  AsyncValueWidget({
    Key? key,
    required this.value,
    required this.data,
    this.loading = const Center(
      child: CircularProgressIndicator(),
    ),
  }) : super(key: key);

  AsyncValue<T> value;
  Widget Function(T) data;
  Widget loading;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return value.when(
      data: data,
      error: (err, s) => Text(err.toString()),
      loading: () => loading,
    );
  }
}
