import 'package:get_it/get_it.dart';
import 'package:notes/data_sources/objectbox.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerSingletonAsync(() async => ObjectBox.create());
  await getIt.allReady();
}
