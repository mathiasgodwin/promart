import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'loading_asset_splash_state.dart';

class LoadingAssetSplashCubit extends Cubit<LoadingAssetSplashState> {
  LoadingAssetSplashCubit() : super(const LoadingAssetSplashState());

  void loadAssets(bool isLoading) {
    isLoading
        ? emit(state.copyWith(status: LoadingAssetsStatus.loading))
        : emit(state.copyWith(status: LoadingAssetsStatus.loaded));
  }
}
