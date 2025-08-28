import 'package:artisan_mobile/features/new_request.component.dart';
import 'package:flutter/material.dart';

import '../../common/constants/app_colors.dart';
import '../../common/widgets/app_text_field.dart';
import '../../common/constants/app_constant.dart';
import '../../common/widgets/conditional_drawer.dart';
import '../../common/auth/auth.dart';
import '../login.component.dart';
import '../register.component.dart';
import '../../common/widgets/request_listview.dart';
import '../../common/constants/notification_popup.dart';

class AgencyHomePage extends StatefulWidget {
  const AgencyHomePage({super.key});

  @override
  State<AgencyHomePage> createState() {
    return _AgencyHomePageState();
  }
}

class _AgencyHomePageState extends State<AgencyHomePage> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Données des indicateurs (normalement récupérées via API)
  final Map<String, dynamic> dashboardStats = {
    "averageRequestsPerDay": 12,
    "satisfiedRequestsPerDay": 8,
    "pendingRequests": 4,
    "submittedRequests": 25,
  };

  // List of Demands - json from API
  List<Map<String, dynamic>> requests_list = [
    {
      'id': 1,
      'name': 'HESSOU HERMANE',
      'location': 'Cotonou, Benin',
      'description': 'Ma connexion internet est très lente depuis hier.',
      'audioProblem':
          'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
      'imageProblem':
          'https://images.unsplash.com/photo-1735825764460-c5dec05d6253',
      'callNumber': '+229 12345678',
      'timeAgo': '2h',
    },
    {
      'id': 2,
      'name': 'MARIE CLAIRE',
      'location': 'Porto-Novo, Benin',
      'problem': 'Écran cassé sur téléphone',
      'description':
          'L\'écran de mon téléphone s\'est fissuré après une chute. L\'écran tactile ne répond plus correctement.',
      'audioProblem': null,
      'imageProblem':
          'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?fm=jpg&q=60&w=3000',
      'callNumber': '+229 87654321',
      'timeAgo': '5h',
    },
    {
      'id': 3,
      'name': 'JEAN BAPTISTE',
      'location': 'Parakou, Benin',
      'problem': 'Problème logiciel ordinateur',
      'description':
          'Mon ordinateur plante régulièrement et affiche un écran bleu. Cela arrive surtout quand j\'ouvre plusieurs programmes.',
      'audioProblem':
          'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
      'imageProblem': null,
      'callNumber': '+229 56789012',
      'timeAgo': '1j',
    },
    {
      'id': 1,
      'name': 'HESSOU HERMANE',
      'location': 'Cotonou, Benin',
      'description':
          'Ma connexion internet est très lente depuis hier. Je n\'arrive pas à me connecter correctement et les pages web ne se chargent pas.',
      'audioProblem':
          'https://d500.d2mefast.net/tb/a/2c/christina_aac_38100.m4a?play',
      'imageProblem':
          'https://images.unsplash.com/photo-1735825764460-c5dec05d6253?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'callNumber': '+229 12345678',
      'timeAgo': '2h',
    },
    {
      'id': 2,
      'name': 'MARIE CLAIRE',
      'location': 'Porto-Novo, Benin',
      'problem': 'Écran cassé sur téléphone',
      'description':
          'L\'écran de mon téléphone s\'est fissuré après une chute. L\'écran tactile ne répond plus correctement.',
      'audioProblem': null,
      'imageProblem':
          'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?fm=jpg&q=60&w=3000',
      'callNumber': '+229 87654321',
      'timeAgo': '5h',
    },
    {
      'id': 3,
      'name': 'JEAN BAPTISTE',
      'location': 'Parakou, Benin',
      'problem': 'Problème logiciel ordinateur',
      'description':
          'Mon ordinateur plante régulièrement et affiche un écran bleu. Cela arrive surtout quand j\'ouvre plusieurs programmes.',
      'audioProblem':
          'https://d500.d2mefast.net/tb/a/2c/christina_aac_38100.m4a?play',
      'imageProblem': null,
      'callNumber': '+229 56789012',
      'timeAgo': '1j',
    },
  ];

  // List of services -> json from API
  final List<Map<String, dynamic>> serviceList = [
    {
      "id": "1",
      "name": "Plomberie",
      "description":
          "Installation et réparation de canalisations, robinets, douches et sanitaires.",
    },
    {
      "id": "2",
      "name": "Électricité",
      "description":
          "Installation électrique, dépannage, mise aux normes et maintenance.",
    },
    {
      "id": "3",
      "name": "Mécanique",
      "description":
          "Réparation et entretien de véhicules et équipements mécaniques.",
    },
    {
      "id": "4",
      "name": "Menuiserie",
      "description":
          "Conception et fabrication de meubles, portes, fenêtres et autres ouvrages en bois.",
    },
    {
      "id": "5",
      "name": "Maçonnerie",
      "description":
          "Construction, rénovation de murs, dalles, fondations et structures en béton ou briques.",
    },
    {
      "id": "6",
      "name": "Peinture",
      "description":
          "Travaux de peinture intérieure et extérieure, décoration murale.",
    },
    {
      "id": "7",
      "name": "Maintenance Informatique",
      "description":
          "Dépannage, installation de logiciels, configuration de réseaux et maintenance d'équipements.",
    },
    {
      "id": "8",
      "name": "Climatisation",
      "description":
          "Installation, entretien et réparation de systèmes de climatisation.",
    },
    {
      "id": "9",
      "name": "Soudure",
      "description":
          "Travaux de soudure sur métaux, assemblage de structures métalliques.",
    },
    {
      "id": "10",
      "name": "Tôlerie",
      "description":
          "Réparation et fabrication de pièces en tôle, carrosserie automobile.",
    },
  ];

  //filtered list of services
  List<Map<String, dynamic>> filteredServiceList = [];

  //Variables to get request form informations
  String selectedServiceId = "";
  String clientFullName = "";
  String clientPhone = "";
  String clientPayementNumber = "";
  bool isPayementNumber = false;
  String clientAddress = "";
  String problemDescription = "";

  @override
  void initState() {
    super.initState();
    filteredServiceList = List.from(serviceList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: ConditionalDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.appColorGray,
        elevation: 0,
        title: const Text(
          AppConstant.appName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () async {
                String? token = await getAgenceInfo();
                print("Token: $token");
                (token != null) ? _openDrawer() : _showAuthModal(context);
              },
              icon: const Icon(
                Icons.menu,
                size: 24,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.appColorGray,
              AppColors.appColorGray.withOpacity(0.8)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.appColorGray.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewRequestPage()),
            );
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Simuler un refresh des données
          await Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header avec gradient
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.appColorGray,
                      AppColors.appColorGray.withOpacity(0.8)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  children: [
                    // Section indicateurs de performance
                    _buildStatsSection(),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 24,
              ),

              // Section des services
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  "Demandes disponibles pour vous",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.appColorGray,
                  ),
                ),
              ),
              // Barre de recherche
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: AppTextField(
                    isObcureText: false,
                    controller: _searchController,
                    hintText: "Rechercher des artisans",
                    labelText: "",
                    prefixIcon:
                        Icon(Icons.search, color: AppColors.appColorGray),
                    onChanged: _filterSearchResults,
                    isLabelBold: true,
                  ),
                ),
              ),

              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: RequestListView(
                  requests: requests_list,
                  descriptionMaxLength: 80, // Optionnel, 100 par défaut
                  onTakeRequest: (request) {
                    // Logique de prise en charge
                    print('Demande prise en charge: ${request['name']}');
                    showMessage("Demande prise en charge avec succès.");
                  },
                  onRefresh: () async {
                    // Logique de rafraîchissement
                    await Future.delayed(const Duration(seconds: 3));
                    showMessage("Un rafraîchissement a été effectué.");
                  },
                ),
                // child: buildServiceGrid(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Nos performances",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: "Demandes/jour",
                  value: "${dashboardStats['averageRequestsPerDay']}",
                  icon: Icons.trending_up,
                  color: Colors.blue,
                  subtitle: "Moyenne",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  title: "Satisfaites",
                  value: "${dashboardStats['satisfiedRequestsPerDay']}",
                  icon: Icons.check_circle,
                  color: Colors.green,
                  subtitle: "Par jour",
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: "En cours",
                  value: "${dashboardStats['pendingRequests']}",
                  icon: Icons.hourglass_empty,
                  color: Colors.orange,
                  subtitle: "Actives",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  title: "Soumises",
                  value: "${dashboardStats['submittedRequests']}",
                  icon: Icons.send,
                  color: Colors.purple,
                  subtitle: "Total",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // widget to build each stat card
  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // Function to open the drawer-
  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  // Function to close the drawer
  void _closeDrawer() {
    _scaffoldKey.currentState?.closeDrawer();
  }

  // Function to filter the lists based on the search query
  void _filterSearchResults(String query) {
    print("Query: $query");
    if (query.isEmpty) {
      setState(() {
        filteredServiceList = List.from(serviceList);
      });
    } else {
      setState(() {
        filteredServiceList = serviceList.where((service) {
          return service['name']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              service['description']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  // Function to build the service grid
  Widget buildServiceGrid() {
    return filteredServiceList.isEmpty
        ? Container(
            height: 200,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "Aucun service trouvé",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredServiceList.length,
            itemBuilder: (context, index) {
              final service = filteredServiceList[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ServiceCard(
                  id: service['id'],
                  name: service['name'],
                  description: service['description'],
                ),
              );
            },
          );
  }

  // Function to show the authentication modal
  void _showAuthModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.center,
          insetPadding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.appColorGray,
                  AppColors.appColorGray.withOpacity(0.9)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.business,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Devenir agence',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Rejoignez notre réseau d\'artisans',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.appColorGray,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'S\'inscrire',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Se connecter'),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Fermer',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Custom widget for each service card with new style
class ServiceCard extends StatelessWidget {
  final String id;
  final String name;
  final String description;

  const ServiceCard({
    Key? key,
    required this.id,
    required this.name,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              AppColors.appColorGray.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.appColorGray.withOpacity(0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.appColorGray.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 6),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.8),
              blurRadius: 8,
              offset: const Offset(0, -2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            // Indicateur coloré à gauche
            Container(
              width: 4,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.appColorGray,
                    AppColors.appColorGray.withOpacity(0.6),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 16),
            // Contenu principal
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.appColorGray,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: AppColors.appColorGray.withOpacity(0.5),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.4,
                      letterSpacing: 0.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
