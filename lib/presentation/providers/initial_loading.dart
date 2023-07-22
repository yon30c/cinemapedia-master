import 'package:cinemapedia/presentation/providers/animeProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final initialLoadingProvider = Provider<bool>((ref) {
  final step1 = ref.watch(recentAnimeProvider).isEmpty;
  final step2 = ref.watch(popularAnimeProvider).isEmpty;
  final step3 = ref.watch(topRateAnimeProvider).isEmpty;
  // final step4 = ref.watch(topRateMoviesProvider).isEmpty;

  if (step1 || step2 || step3) return true;
  return false;
});