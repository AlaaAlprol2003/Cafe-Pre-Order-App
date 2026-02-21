// ignore_for_file: duplicate_import

import 'package:dash_cup/core/di/service_locator.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'service_locator.config.dart';

final serviceLocator = GetIt.instance;  
  
@InjectableInit(  
  initializerName: 'init', 
  preferRelativeImports: true,  
  asExtension: true,   
)  
void configureDependencies() => serviceLocator.init(); 