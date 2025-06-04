import 'package:artisan_mobile/features/home.component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'common/constants/app_colors.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // whenever your initialization is completed, remove the splash screen:
    FlutterNativeSplash.remove();
    return MaterialApp(
      title: 'Place des artisans',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.appColorGray),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
//Formulaire(nom, Emplacement à piquer , probleme audio, probleme texte, probleme image,numero appel, numero payement)
//Inscription agence(Nom, emplacement à piquer, email, numero)
//Formulaire après prestation(nomArtisan, montant)

