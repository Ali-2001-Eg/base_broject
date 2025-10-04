part of "helpers.dart";

class PaginationHandler<T, B extends BlocBase<BaseState<T>>> {
  bool isLoadingMore = false;
  bool hasMoreData = true;
  int currentPage = 1;
  final int pageSize;
  List<T> items = [];
  final B bloc;
  final String? cacheKey;

  PaginationHandler({
    required this.bloc,
    this.cacheKey,
    this.pageSize = 15,
  });

  Future<void> loadFirstPage(PaginateFunc<T> fetchFunction,
      {Map<String, dynamic>? params, String? cacheKey}) async {
    bloc.emit(bloc.state.copyWith(status: Status.loading));
    items.clear();
    currentPage = 1;
    isLoadingMore = false;
    hasMoreData = true;

    final result = await fetchFunction(currentPage, pageSize, params);
    await result.fold((failure) async {
      // On failure, load from cache if available
      if(cacheKey != null){
        final cached = await getIt<IPaginatedCache<T>>().getCachedPage(cacheKey: cacheKey!);
        if (cached.isNotEmpty) {
          items = cached;
          bloc.emit(bloc.state
              .copyWith(status: Status.success, items: List.from(items)));
        }
      }
     else {
        bloc.emit(bloc.state
            .copyWith(status: Status.failure, errorMessage: failure.message));
      }
    }, (data) async {
      items.addAll(data);
      if (cacheKey != null) {
        await getIt<IPaginatedCache<T>>().cachePage(items,
            cacheKey: cacheKey!); // Cache the first page
      }
      if (data.length >= pageSize) {
        currentPage++;
      } else {
        hasMoreData = false;
      }
      bloc.emit(
          bloc.state.copyWith(status: Status.success, items: List.from(items)));
    });
  }

  Future<void> fetchData(PaginateFunc<T> fetchFunction,
      {Map<String, dynamic>? params}) async {
    if (!hasMoreData || isLoadingMore) {
      logger(
          'Not loading more - hasMoreData: $hasMoreData, isLoadingMore: $isLoadingMore');
      return;
    }

    isLoadingMore = true;
    if (currentPage > 1) {
      bloc.emit(bloc.state.copyWith(status: Status.isLoadingMore));
    }

    final result = await fetchFunction(currentPage, pageSize,
        params?..removeWhere((key, value) => value == null || value == ''));
    await result.fold(
          (failure) async {
        isLoadingMore = false;
        bloc.emit(bloc.state
            .copyWith(status: Status.failure, errorMessage: failure.message));
      },
          (data) async {
        items.addAll(data);
        if (data.length >= pageSize) {
          currentPage++;
          loggerFatal('Loaded more data, currentPage: $currentPage');
        } else {
          hasMoreData = false;
          loggerFatal('No more data to load');
        }
        isLoadingMore = false;
        bloc.emit(bloc.state
            .copyWith(status: Status.success, items: List.from(items)));
      },
    );
  }
}

typedef PaginateFunc<T> = Future<Either<Failure, List<T>>>
Function(int page, int limit, [Map<String, dynamic>? params]);