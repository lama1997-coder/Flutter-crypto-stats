import 'package:crypto_stats/app/app.dart';
import 'package:crypto_stats/core/helpers/initialize_dependency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDependency();
  runApp(const App());
}
// void main() {
//   FlavorConfig(
//     color: Colors.red,
//     location: BannerLocation.topStart,
//     variables: {
//             "counter": 5,
//             "baseUrl": "https://www.example.com"
//         },
//   );
//    runApp(const App());
// }