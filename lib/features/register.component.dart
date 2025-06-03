import 'package:artisan_mobile/common/widgets/app_text_field.dart';
import 'package:artisan_mobile/features/login.component.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';

import '../common/constants/app_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  String agenceName = '';
  String agenceEmail = '';
  String agencePhone = '';
  String agenceAddress = '';
  String password = '';
  String passwordConfirmed = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return LoadingOverlayPro(
      isLoading: isLoading,
      child: Scaffold(
        backgroundColor: AppColors.appColorGray,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
                return SingleChildScrollView(
                padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      // Header adaptatif selon l'orientation
                      _buildHeader(isLandscape, screenHeight),
                      
                      // Corps du formulaire
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  SizedBox(height: isLandscape ? 10 : 20),
                              
                                  // Nom de l'agence
                                  _buildFormField(
                                    label: 'Nom de l\'agence',
                                    child: AppTextField(
                                      prefixIcon: Icon(Icons.business_center, color: AppColors.appColorGray,),
                                      isObcureText: false,
                                      hintText: 'Entrez le nom de votre agence',
                                      labelText: '',
                                      isLabelBold: true,
                                      onChanged: (value) {
                                        setState(() {
                                          agenceName = value;
                                        });
                                      },
                                    ),
                                  ),
                              
                                  SizedBox(height: isLandscape ? 15 : 20),
                              
                                  // Email
                                  _buildFormField(
                                    label: 'Email professionnel',
                                    child: AppTextField(
                                      prefixIcon: Icon(Icons.email_outlined, color: AppColors.appColorGray,),
                                      keyboardType: TextInputType.emailAddress,
                                      isObcureText: false,
                                      hintText: 'votre.email@exemple.com',
                                      labelText: '',
                                      isLabelBold: true,
                                      onChanged: (value) {
                                        setState(() {
                                          agenceEmail = value;
                                        });
                                      },
                                    ),
                                  ),
                              
                                  SizedBox(height: isLandscape ? 15 : 20),
                              
                                  // Numéro de téléphone
                                  _buildFormField(
                                    label: 'Numéro de téléphone',
                                    child: AppTextField(
                                      prefixIcon:Icon(Icons.phone_outlined, color: AppColors.appColorGray,),
                                      keyboardType: TextInputType.phone,
                                      isObcureText: false,
                                      hintText: '+229 X XX XX XX XX',
                                      labelText: '',
                                      isLabelBold: true,
                                      onChanged: (value) {
                                        setState(() {
                                          agencePhone = value;
                                        });
                                      },
                                    ),
                                  ),
                              
                                  SizedBox(height: isLandscape ? 15 : 20),
                              
                                  // Adresse
                                  _buildFormField(
                                    label: 'Adresse de l\'agence',
                                    child: AppTextField(
                                      prefixIcon: Icon(Icons.location_on_outlined, color: AppColors.appColorGray,),
                                      isObcureText: false,
                                      hintText: 'Adresse complète de votre agence',
                                      labelText: '',
                                      isLabelBold: true,
                                      maxLines: 2,
                                      onChanged: (value) {
                                        setState(() {
                                          agenceAddress = value;
                                        });
                                      },
                                    ),
                                  ),
                              
                                  SizedBox(height: isLandscape ? 15 : 20),
                              
                                  // Mot de passe
                                  _buildFormField(
                                    label: 'Mot de passe',
                                    child: AppTextField(
                                      prefixIcon: Icon(Icons.lock_outline, color: AppColors.appColorGray,),
                                      isObcureText: true,
                                      hintText: 'Choisissez un mot de passe sécurisé',
                                      labelText: '',
                                      isLabelBold: true,
                                      onChanged: (value) {
                                        setState(() {
                                          password = value;
                                        });
                                      },
                                    ),
                                  ),
                              
                                  SizedBox(height: isLandscape ? 15 : 20),
                              
                                  // Confirmation mot de passe
                                  _buildFormField(
                                    label: 'Confirmer le mot de passe',
                                    child: AppTextField(
                                      prefixIcon: Icon(Icons.lock_outline, color: AppColors.appColorGray,),
                                      isObcureText: true,
                                      hintText: 'Répétez votre mot de passe',
                                      labelText: '',
                                      isLabelBold: true,
                                      onChanged: (value) {
                                        setState(() {
                                          passwordConfirmed = value;
                                        });
                                      },
                                    ),
                                  ),
                              
                                  SizedBox(height: isLandscape ? 20 : 30),
                              
                                  // Bouton d'inscription avec design amélioré
                                  Container(
                                    height: 55,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.appColorGray,
                                          AppColors.appColorGray.withOpacity(0.8),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(27.5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.appColorGray.withOpacity(0.3),
                                          blurRadius: 10,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      onPressed: _register,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(27.5),
                                        ),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:  [
                                          Icon(
                                            Icons.app_registration,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            'Créer mon compte',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              
                                  SizedBox(height: isLandscape ? 20 : 30),
                              
                                  // Divider avec "OU"
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        color: Colors.grey.withOpacity(0.3),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 16),
                                      child: Text(
                                        'OU',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        color: Colors.grey.withOpacity(0.3),
                                      ),
                                    ),
                                  ],
                                ),
                              
                                const SizedBox(height: 32),
                              
                                // Lien vers l'inscription
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Déjà un compte? ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const LoginPage(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Se connecter',
                                        style: TextStyle(
                                          color: AppColors.appColorGray,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              
                                const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
            },
             
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isLandscape, double screenHeight) {
    // Calcul de la hauteur adaptative du header
    double headerHeight;
    if (isLandscape) {
      headerHeight = screenHeight * 0.25; // 25% en paysage
    } else {
      headerHeight = 280; // Hauteur fixe en portrait
    }
    
    // Assurer une hauteur minimum
    headerHeight = headerHeight.clamp(120.0, 280.0);

    return Container(
      width: double.infinity,
      height: headerHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.appColorGray,
            AppColors.appColorGray.withOpacity(0.8),
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
            
            // Contenu principal du header adaptatif
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.business,
                    color: Colors.white,
                    size: isLandscape ? 30 : 50,
                  ),
                  SizedBox(height: isLandscape ? 5 : 10),
                  Text(
                    'Inscription Agence',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isLandscape ? 22 : 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (!isLandscape) ...[
                    const SizedBox(height: 5),
                    const Text(
                      'Créez votre compte professionnel',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  void _register() async {
    // Vérification des informations
    if (agenceName != '' &&
        agenceEmail != '' &&
        agencePhone != '' &&
        agenceAddress != '' &&
        password != '' &&
        passwordConfirmed != '') {
      if (password != passwordConfirmed) {
        // Afficher erreur de confirmation mot de passe
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Les mots de passe ne correspondent pas'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() {
        isLoading = true;
      });

      // Simuler une requête réseau
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        isLoading = false;
      });

      // Action après inscription
      agenceName = '';
      agenceEmail = '';
      agencePhone = '';
      agenceAddress = '';
      password = '';
      passwordConfirmed = '';

      // Afficher message de succès
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Inscription effectuée avec succès !'),
          backgroundColor: Colors.green,
        ),
      );

      print('Inscription effectuée avec succès'); 
      //call LoginPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );

    } else {
      // Afficher message d'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs'),
          backgroundColor: Colors.red,
        ),
      );
      print('Veuillez remplir tous les champs');
    }
  }
}