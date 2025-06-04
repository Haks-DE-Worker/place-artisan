import 'package:artisan_mobile/common/auth/auth.dart';
import 'package:artisan_mobile/features/home.component.dart';
import 'package:artisan_mobile/features/register.component.dart';
import 'package:flutter/material.dart';
import '../common/constants/app_colors.dart';
import '../common/widgets/app_text_field.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  String agenceEmail = '';
  String password = '';
  bool isLoading = false;
  bool rememberMe = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            builder: (context, constraints){
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
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(height: isLandscape ? 20 : 30),
                          
                                  // Email
                                  _buildFormField(
                                    label: 'Email',
                                    child: AppTextField(
                                      prefixIcon: Icon(Icons.email_outlined, color: AppColors.appColorGray,),
                                      keyboardType: TextInputType.emailAddress,
                                      isObcureText: false,
                                      hintText: 'Entrez votre email',
                                      labelText: '',
                                      isLabelBold: true,
                                      onChanged: (value) {
                                        setState(() {
                                          agenceEmail = value;
                                        });
                                      },
                                    ),
                                  ),
                          
                                  SizedBox(height: isLandscape ? 20 : 24),
                          
                                  // Mot de passe
                                  _buildFormField(
                                    label: 'Mot de passe',
                                    child: AppTextField(
                                      prefixIcon: Icon(Icons.lock_outline, color: AppColors.appColorGray,),
                                      isObcureText: true,
                                      hintText: 'Entrez votre mot de passe',
                                      labelText: '',
                                      isLabelBold: true,
                                      onChanged: (value) {
                                        setState(() {
                                          password = value;
                                        });
                                      },
                                    ),
                                  ),
                          
                                  SizedBox(height: isLandscape ? 24 : 32),
                          
                                  // Bouton de connexion avec design amélioré
                                  Container(
                                    height: 56,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.appColorGray,
                                          AppColors.appColorGray.withOpacity(0.8),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(28),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.appColorGray.withOpacity(0.3),
                                          blurRadius: 12,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      onPressed: _login,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(28),
                                        ),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:  [
                                          Icon(
                                            Icons.login,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          SizedBox(width: 12),
                                          Text(
                                            'Se connecter',
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
                          
                                  SizedBox(height: isLandscape ? 24 : 32),
                          
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
                          
                                  SizedBox(height: isLandscape ? 24 : 32),
                          
                                  // Lien vers l'inscription
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Pas encore de compte ? ',
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
                                              builder: (context) => const RegisterPage(),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'S\'inscrire',
                                          style: TextStyle(
                                            color: AppColors.appColorGray,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          
                                  SizedBox(height: isLandscape ? 15 : 20),
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
            }
            
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isLandscape, double screenHeight) {
    // Calcul de la hauteur adaptative du header
    double headerHeight;
    if (isLandscape) {
      headerHeight = screenHeight * 0.30; // 25% en paysage
    } else {
      headerHeight = 300; // Hauteur fixe en portrait
    }
    
    // Assurer une hauteur minimum et maximum
    headerHeight = headerHeight.clamp(140.0, 300.0);

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
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: isLandscape ? 10 : 20),
            
            // Logo/Icône principale adaptatif
            Container(
              width: isLandscape ? 70 : 100,
              height: isLandscape ? 70 : 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(isLandscape ? 35 : 50),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.login_rounded,
                color: Colors.white,
                size: isLandscape ? 35 : 50,
              ),
            ),
            
            SizedBox(height: isLandscape ? 4 : 24),
            
            // Titre adaptatif
            Text(
              'Bon retour !',
              style: TextStyle(
                color: Colors.white,
                fontSize: isLandscape ? 24 : 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            // Sous-titre visible seulement en portrait
            if (!isLandscape) ...[
              const SizedBox(height: 8),
              const Text(
                'Connectez-vous à votre compte',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
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

  void _showForgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Mot de passe oublié',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Veuillez contacter l\'administrateur pour réinitialiser votre mot de passe.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'OK',
                style: TextStyle(color: AppColors.appColorGray),
              ),
            ),
          ],
        );
      },
    );
  }

  void _login() async {
    // Vérification des informations
    if (agenceEmail != '' && password != '') {
      setState(() {
        isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      // Submit data here
      saveAgenceInfo();

      setState(() {
        isLoading = false;
      });

      // Afficher message de succès
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Connexion effectuée avec succès !'),
          backgroundColor: Colors.green,
        ),
      );

      print('Connexion effectuée avec succès');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // Afficher message d'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}