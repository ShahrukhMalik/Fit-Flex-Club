import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

late GetIt sl;

@injectableInit
configureDependencies() => sl = GetIt.instance;

