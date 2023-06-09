import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/infracstructure.dart';

final localStorageRepoProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(IsarDatasource());
});
