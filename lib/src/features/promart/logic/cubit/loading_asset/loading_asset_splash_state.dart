part of 'loading_asset_splash_cubit.dart';

enum LoadingAssetsStatus { initial, loading, loaded }

class LoadingAssetSplashState extends Equatable {
  final LoadingAssetsStatus status;

  const LoadingAssetSplashState({this.status = LoadingAssetsStatus.initial});

  @override
  List<Object?> get props => [status];

  LoadingAssetSplashState copyWith({LoadingAssetsStatus? status}) {
    return LoadingAssetSplashState(status: status ?? this.status);
  }
}
