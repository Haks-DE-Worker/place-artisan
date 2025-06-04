import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'dart:async';
import '../common/constants/app_colors.dart';

class MyRequestsPage extends StatefulWidget {
  const MyRequestsPage({super.key});

  @override
  State<MyRequestsPage> createState() => _MyRequestsPageState();
}

class _MyRequestsPageState extends State<MyRequestsPage> with TickerProviderStateMixin {
  late TabController _tabController;
  
  // Demandes en cours
  List<Map<String, dynamic>> ongoingRequests = [
    {
      'id': 1,
      'name': 'TECHNICIEN MARIE',
      'location': 'Porto-Novo, Benin',
      'problem': 'Réparation connexion internet',
      'description': 'Intervention en cours pour réparer la connexion internet lente. Diagnostic des équipements réseau effectué.',
      'audioProblem': null,
      'imageProblem': 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?fm=jpg&q=60&w=3000',
      'callNumber': '+229 12345678',
      'timeAgo': '1h',
      'status': 'En cours',
      'progress': 0.6,
      'estimatedTime': '2h restantes',
      'technicianNotes': 'Remplacement du routeur en cours. Signal internet stable maintenant.',
    },
    {
      'id': 2,
      'name': 'TECHNICIEN JEAN',
      'location': 'Cotonou, Benin',
      'problem': 'Réparation écran téléphone',
      'description': 'Remplacement de l\'écran fissuré en cours. Nouvelle pièce commandée et en transit.',
      'audioProblem': 'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
      'imageProblem': null,
      'callNumber': '+229 87654321',
      'timeAgo': '3h',
      'status': 'En attente pièces',
      'progress': 0.3,
      'estimatedTime': '1 jour',
      'technicianNotes': 'En attente de la livraison de l\'écran. Sera installé dès réception.',
    },
  ];

  // Demandes traitées
  List<Map<String, dynamic>> completedRequests = [
    {
      'id': 3,
      'name': 'TECHNICIEN PAUL',
      'location': 'Parakou, Benin',
      'problem': 'Réparation ordinateur',
      'description': 'Problème d\'écran bleu résolu. Mise à jour des pilotes et nettoyage système effectués.',
      'audioProblem': null,
      'imageProblem': 'https://images.unsplash.com/photo-1587831990711-23ca6441447b?fm=jpg&q=60&w=3000',
      'callNumber': '+229 56789012',
      'timeAgo': '2j',
      'status': 'Terminé',
      'completedDate': '26 Mai 2025',
      'rating': 5,
      'clientFeedback': 'Excellent service ! Mon ordinateur fonctionne parfaitement maintenant.',
      'technicianNotes': 'Problème de pilote graphique résolu. Système optimisé.',
    },
    {
      'id': 4,
      'name': 'TECHNICIEN CLAIRE',
      'location': 'Cotonou, Benin',
      'problem': 'Installation réseau WiFi',
      'description': 'Installation complète d\'un réseau WiFi domestique avec configuration sécurisée.',
      'audioProblem': 'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
      'imageProblem': 'https://images.unsplash.com/photo-1606664315414-6e1c725717da?fm=jpg&q=60&w=3000',
      'callNumber': '+229 98765432',
      'timeAgo': '5j',
      'status': 'Terminé',
      'completedDate': '23 Mai 2025',
      'rating': 4,
      'clientFeedback': 'Très bon travail, WiFi fonctionne bien partout dans la maison.',
      'technicianNotes': 'Réseau configuré avec sécurité WPA3. 3 points d\'accès installés.',
    },
    {
      'id': 5,
      'name': 'TECHNICIEN AHMED',
      'location': 'Porto-Novo, Benin',
      'problem': 'Maintenance imprimante',
      'description': 'Nettoyage et calibrage de l\'imprimante laser. Remplacement des cartouches d\'encre.',
      'audioProblem': null,
      'imageProblem': null,
      'callNumber': '+229 11223344',
      'timeAgo': '1sem',
      'status': 'Terminé',
      'completedDate': '21 Mai 2025',
      'rating': 5,
      'clientFeedback': 'Imprimante comme neuve ! Merci pour le service rapide.',
      'technicianNotes': 'Maintenance complète effectuée. Imprimante optimisée pour 6 mois.',
    },
  ];

  Set<int> expandedRequests = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _toggleExpanded(int requestId) {
    setState(() {
      if (expandedRequests.contains(requestId)) {
        expandedRequests.remove(requestId);
      } else {
        expandedRequests.add(requestId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: const Text(
                "Mes Demandes",
                style: TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              backgroundColor: AppColors.appColorGray,
              foregroundColor: Colors.white,
              floating: true,
              pinned: true,
              elevation: 0,
              expandedHeight: 120,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.appColorGray,
                        AppColors.appColorGray.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
              ),
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: Colors.white,
                indicatorWeight: 3,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.access_time, size: 18),
                        const SizedBox(width: 8),
                        const Text('En cours'),
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${ongoingRequests.length}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle, size: 18),
                        const SizedBox(width: 8),
                        const Text('Traitées'),
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${completedRequests.length}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildOngoingRequestsTab(),
            _buildCompletedRequestsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildOngoingRequestsTab() {
    if (ongoingRequests.isEmpty) {
      return _buildEmptyState(
        icon: Icons.hourglass_empty,
        title: 'Aucune demande en cours',
        subtitle: 'Vos demandes en cours d\'intervention apparaîtront ici',
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {});
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: ongoingRequests.length,
        itemBuilder: (context, index) {
          return _buildOngoingRequestCard(ongoingRequests[index]);
        },
      ),
    );
  }

  Widget _buildCompletedRequestsTab() {
    if (completedRequests.isEmpty) {
      return _buildEmptyState(
        icon: Icons.check_circle_outline,
        title: 'Aucune demande traitée',
        subtitle: 'Vos demandes terminées apparaîtront ici',
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {});
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: completedRequests.length,
        itemBuilder: (context, index) {
          return _buildCompletedRequestCard(completedRequests[index]);
        },
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildOngoingRequestCard(Map<String, dynamic> request) {
    final bool isExpanded = expandedRequests.contains(request['id']);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.orange.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => _toggleExpanded(request['id']),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.orange.withOpacity(0.1),
                        child: Text(
                          request['name'].split(' ').map((e) => e[0]).take(2).join(),
                          style: const TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              request['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 16,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    request['location'],
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child:  Text(
                          'En cours',
                          style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    request['description'].isNotEmpty 
                      ? request['description'] 
                      : 'Aucune description fournie',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Barre de progression
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text(
                  //           'Progression',
                  //           style: TextStyle(
                  //             fontSize: 12,
                  //             color: Colors.grey[600],
                  //           ),
                  //         ),
                  //         Text(
                  //           '${(request['progress'] * 100).toInt()}%',
                  //           style: const TextStyle(
                  //             fontSize: 12,
                  //             fontWeight: FontWeight.bold,
                  //             color: Colors.orange,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     const SizedBox(height: 4),
                  //     LinearProgressIndicator(
                  //       value: request['progress'],
                  //       backgroundColor: Colors.grey[300],
                  //       valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
                  //     ),
                  //     const SizedBox(height: 8),
                  //     Row(
                  //       children: [
                  //         Icon(
                  //           Icons.schedule,
                  //           size: 14,
                  //           color: Colors.grey[600],
                  //         ),
                  //         const SizedBox(width: 4),
                  //         Text(
                  //           request['estimatedTime'],
                  //           style: TextStyle(
                  //             fontSize: 12,
                  //             color: Colors.grey[600],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  //const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        request['timeAgo'],
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                      Icon(
                        isExpanded 
                          ? Icons.keyboard_arrow_up 
                          : Icons.keyboard_arrow_down,
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) _buildOngoingExpandedContent(request),
        ],
      ),
    );
  }

  Widget _buildCompletedRequestCard(Map<String, dynamic> request) {
    final bool isExpanded = expandedRequests.contains(request['id']);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.green.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => _toggleExpanded(request['id']),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green.withOpacity(0.1),
                        child: Text(
                          request['name'].split(' ').map((e) => e[0]).take(2).join(),
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              request['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 16,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    request['location'],
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                             Icon(
                              Icons.check_circle,
                              size: 14,
                              color: Colors.green,
                            ),
                             SizedBox(width: 4),
                            Text(
                              'Terminé',
                              style:  TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    request['description'].isNotEmpty 
                      ? request['description'] 
                      : 'Aucune description fournie',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Note d'évaluation
                  Row(
                    children: [
                      ...List.generate(5, (index) {
                        return const Icon(
                           Icons.star 
                            ,
                          color: Colors.amber,
                          size: 16,
                        );
                      }),
                      const SizedBox(width: 8),
                      const Text(
                        '5/5',
                        style:TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Terminé',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      Icon(
                        isExpanded 
                          ? Icons.keyboard_arrow_up 
                          : Icons.keyboard_arrow_down,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) _buildCompletedExpandedContent(request),
        ],
      ),
    );
  }

  Widget _buildOngoingExpandedContent(Map<String, dynamic> request) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.05),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(height: 1),
            const SizedBox(height: 16),
            
            // Description détaillée
            const Text(
              'Description détaillée :',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              request['description'],
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            // Notes du technicien
            // const Text(
            //   'Notes du technicien :',
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 14,
            //   ),
            // ),
            // const SizedBox(height: 8),
            // Container(
            //   padding: const EdgeInsets.all(12),
            //   decoration: BoxDecoration(
            //     color: Colors.blue.withOpacity(0.1),
            //     borderRadius: BorderRadius.circular(8),
            //     border: Border.all(
            //       color: Colors.blue.withOpacity(0.3),
            //     ),
            //   ),
            //   child: Text(
            //     request['technicianNotes'],
            //     style: const TextStyle(
            //       fontSize: 14,
            //       fontStyle: FontStyle.italic,
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 16),
            
            // Contact
            Row(
              children: [
                Icon(
                  Icons.phone,
                  size: 18,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Text(
                  'Contact : ${request['callNumber']}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Médias attachés
            if (request['imageProblem'] != null || request['audioProblem'] != null)
              _buildMediaSection(request),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletedExpandedContent(Map<String, dynamic> request) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.05),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(height: 1),
            const SizedBox(height: 16),
            
            // Description détaillée
            const Text(
              'Description détaillée :',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              request['description'],
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            // Notes du technicien
            // const Text(
            //   'Notes du technicien :',
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 14,
            //   ),
            // ),
            // const SizedBox(height: 8),
            // Container(
            //   padding: const EdgeInsets.all(12),
            //   decoration: BoxDecoration(
            //     color: Colors.blue.withOpacity(0.1),
            //     borderRadius: BorderRadius.circular(8),
            //     border: Border.all(
            //       color: Colors.blue.withOpacity(0.3),
            //     ),
            //   ),
            //   child: Text(
            //     request['technicianNotes'],
            //     style: const TextStyle(
            //       fontSize: 14,
            //       fontStyle: FontStyle.italic,
            //     ),
            //   ),
            // ),
             const SizedBox(height: 16),

            // Avis client
            // const Text(
            //   'Avis du client :',
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 14,
            //   ),
            // ),
            // const SizedBox(height: 8),
            // Container(
            //   padding: const EdgeInsets.all(12),
            //   decoration: BoxDecoration(
            //     color: Colors.green.withOpacity(0.1),
            //     borderRadius: BorderRadius.circular(8),
            //     border: Border.all(
            //       color: Colors.green.withOpacity(0.3),
            //     ),
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Row(
            //         children: [
            //           ...List.generate(5, (index) {
            //             return Icon(
            //               index < request['rating'] 
            //                 ? Icons.star 
            //                 : Icons.star_border,
            //               color: Colors.amber,
            //               size: 18,
            //             );
            //           }),
            //           const SizedBox(width: 8),
            //           Text(
            //             '${request['rating']}/5',
            //             style: const TextStyle(
            //               fontSize: 14,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //         ],
            //       ),
            //       const SizedBox(height: 8),
            //       Text(
            //         request['clientFeedback'],
            //         style: const TextStyle(
            //           fontSize: 14,
            //           fontStyle: FontStyle.italic,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 16),
            
            // Contact
            Row(
              children: [
                Icon(
                  Icons.phone,
                  size: 18,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Text(
                  'Contact : ${request['callNumber']}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Médias attachés
            if (request['imageProblem'] != null || request['audioProblem'] != null)
              _buildMediaSection(request),
          ],
        ),
      ),
    );
  }

 Widget _buildMediaSection(Map<String, dynamic> request) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Médias joints :',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            if (request['imageProblem'] != null)
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Ouvrir l'image en plein écran
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: Image.network(request['imageProblem']),
                      ),
                    );
                  },
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(request['imageProblem']),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black.withOpacity(0.3),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.image,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (request['imageProblem'] != null && request['audioProblem'] != null)
              const SizedBox(width: 8),
            if (request['audioProblem'] != null)
              Expanded(
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.appColorGray.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.appColorGray.withOpacity(0.3),
                    ),
                  ),
                  child: AudioPlayerWidget(
                    audioUrl: request['audioProblem'],
                ),
              )
              ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}



class AudioPlayerWidget extends StatefulWidget {
  final String audioUrl;

  const AudioPlayerWidget({Key? key, required this.audioUrl}) : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _isPlayerInitialized = false;
  bool _isPlaying = false;
  bool _isLoading = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  StreamSubscription? _playerSubscription;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  @override
  void dispose() {
    _cleanupPlayer();
    super.dispose();
  }

  Future<void> _initializePlayer() async {
    try {
      await _player.openPlayer();
      setState(() {
        _isPlayerInitialized = true;
      });
    } catch (e) {
      print('Erreur lors de l\'initialisation du lecteur: $e');
    }
  }

  Future<void> _cleanupPlayer() async {
    try {
      await _playerSubscription?.cancel();
      if (_isPlaying) {
        await _player.stopPlayer();
      }
      if (_isPlayerInitialized) {
        await _player.closePlayer();
      }
    } catch (e) {
      print('Erreur lors du nettoyage du lecteur: $e');
    }
  }

  Future<void> _toggleAudio() async {
    if (!_isPlayerInitialized) return;

    try {
      if (_isPlaying) {
        await _pauseAudio();
      } else {
        await _playAudio();
      }
    } catch (e) {
      print('Erreur lors de la lecture audio: $e');
      _showErrorSnackBar('Erreur lors de la lecture audio');
      setState(() {
        _isPlaying = false;
        _isLoading = false;
      });
    }
  }

  Future<void> _playAudio() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Arrêter toute lecture en cours
      if (_player.isPlaying) {
        await _player.stopPlayer();
      }

      // Commencer la lecture
      await _player.startPlayer(
        fromURI: widget.audioUrl,
        codec: Codec.mp3, // Vous pouvez ajuster selon le format
        whenFinished: () {
          setState(() {
            _isPlaying = false;
            _position = Duration.zero;
          });
        },
      );

      // S'abonner aux mises à jour de position
      _playerSubscription = _player.onProgress!.listen((event) {
        setState(() {
          _duration = event.duration;
          _position = event.position;
        });
      });

      setState(() {
        _isPlaying = true;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isPlaying = false;
      });
      rethrow;
    }
  }

  Future<void> _pauseAudio() async {
    await _player.pausePlayer();
    setState(() {
      _isPlaying = false;
    });
  }

  Future<void> _stopAudio() async {
    await _player.stopPlayer();
    await _playerSubscription?.cancel();
    setState(() {
      _isPlaying = false;
      _position = Duration.zero;
    });
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Boutons de contrôle
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Bouton Stop
              if (_isPlaying || _position > Duration.zero)
                IconButton(
                  onPressed: _stopAudio,
                  icon: const Icon(
                    Icons.stop,
                    color: Colors.grey,
                  ),
                  iconSize: 20,
                ),

              // Bouton Play/Pause principal
              IconButton(
                onPressed: _isPlayerInitialized ? _toggleAudio : null,
                icon: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                        ),
                      )
                    : Icon(
                        _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                        color: _isPlayerInitialized ? Colors.grey : Colors.grey[300],
                        size: 32,
                      ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          // Indicateur de progression
          if (_duration > Duration.zero)
            Column(
              children: [
                LinearProgressIndicator(
                  value: _duration.inMilliseconds > 0
                      ? _position.inMilliseconds / _duration.inMilliseconds
                      : 0.0,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.grey),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(_position),
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      _formatDuration(_duration),
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            )
          else
            const Text(
              'Audio',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }
}