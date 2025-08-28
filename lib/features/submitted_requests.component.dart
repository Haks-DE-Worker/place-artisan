import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'dart:async';

import '../common/constants/app_colors.dart';

class SubmittedRequests extends StatefulWidget {
  const SubmittedRequests({super.key});

  @override
  State<SubmittedRequests> createState() {
    return _SubmittedRequestsState();
  }
}

class _SubmittedRequestsState extends State<SubmittedRequests> {

  List<Map<String, dynamic>> requests = [
    {
      'id': 1,
      'name': 'HESSOU HERMANE',
      'location': 'Cotonou, Benin',
      'description': 'Ma connexion internet est très lente depuis hier.',
      'audioProblem': 'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
      'imageProblem': 'https://images.unsplash.com/photo-1735825764460-c5dec05d6253',
      'callNumber': '+229 12345678',
      'timeAgo': '2h',
    },
    {
      'id': 2,
      'name': 'MARIE CLAIRE',
      'location': 'Porto-Novo, Benin',
      'problem': 'Écran cassé sur téléphone',
      'description': 'L\'écran de mon téléphone s\'est fissuré après une chute. L\'écran tactile ne répond plus correctement.',
      'audioProblem': null,
      'imageProblem': 'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?fm=jpg&q=60&w=3000',
      'callNumber': '+229 87654321',
      'timeAgo': '5h',

    },
    {
      'id': 3,
      'name': 'JEAN BAPTISTE',
      'location': 'Parakou, Benin',
      'problem': 'Problème logiciel ordinateur',
      'description': 'Mon ordinateur plante régulièrement et affiche un écran bleu. Cela arrive surtout quand j\'ouvre plusieurs programmes.',
      'audioProblem': 'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
      'imageProblem': null,
      'callNumber': '+229 56789012',
      'timeAgo': '1j',
    },{
      'id': 1,
      'name': 'HESSOU HERMANE',
      'location': 'Cotonou, Benin',
      'description': 'Ma connexion internet est très lente depuis hier. Je n\'arrive pas à me connecter correctement et les pages web ne se chargent pas.',
      'audioProblem': 'https://d500.d2mefast.net/tb/a/2c/christina_aac_38100.m4a?play',
      'imageProblem': 'https://images.unsplash.com/photo-1735825764460-c5dec05d6253?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'callNumber': '+229 12345678',
      'timeAgo': '2h',
    },
    {
      'id': 2,
      'name': 'MARIE CLAIRE',
      'location': 'Porto-Novo, Benin',
      'problem': 'Écran cassé sur téléphone',
      'description': 'L\'écran de mon téléphone s\'est fissuré après une chute. L\'écran tactile ne répond plus correctement.',
      'audioProblem': null,
      'imageProblem': 'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?fm=jpg&q=60&w=3000',
      'callNumber': '+229 87654321',
      'timeAgo': '5h',

    },
    {
      'id': 3,
      'name': 'JEAN BAPTISTE',
      'location': 'Parakou, Benin',
      'problem': 'Problème logiciel ordinateur',
      'description': 'Mon ordinateur plante régulièrement et affiche un écran bleu. Cela arrive surtout quand j\'ouvre plusieurs programmes.',
      'audioProblem': 'https://d500.d2mefast.net/tb/a/2c/christina_aac_38100.m4a?play',
      'imageProblem': null,
      'callNumber': '+229 56789012',
      'timeAgo': '1j',
    },
  ];

  Set<int> expandedRequests = {};

  void _toggleExpanded(int requestId) {
    setState(() {
      if (expandedRequests.contains(requestId)) {
        expandedRequests.remove(requestId);
      } else {
        expandedRequests.add(requestId);
      }
    });
  }

  void _takeRequest(Map<String, dynamic> request) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmer la prise en charge'),
          content: Text(
            'Voulez-vous prendre en charge la demande de ${request['name']} ?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _handleTakeRequest(request);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.appColorGray,
              ),
              child: const Text('Confirmer', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _handleTakeRequest(Map<String, dynamic> request) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Demande de ${request['name']} prise en charge avec succès'),
        backgroundColor: Colors.green,
      ),
    );
    // Ici vous pouvez ajouter la logique pour traiter la demande
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Nouvelles demandes soumises",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.appColorGray,
        foregroundColor: Colors.white,
      ),
      body: requests.isEmpty 
        ? _buildEmptyState()
        : RefreshIndicator(
            onRefresh: () async {
              // Logique de rafraîchissement
              await Future.delayed(const Duration(seconds: 1));
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: requests.length,
              itemBuilder: (context, index) {
                return _buildRequestCard(requests[index]);
              },
            ),
          ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Aucune nouvelle demande',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Les nouvelles demandes soumises apparaîtront ici',
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

  Widget _buildRequestCard(Map<String, dynamic> request) {
    final bool isExpanded = expandedRequests.contains(request['id']);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // En-tête de la carte (toujours visible)
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
                        backgroundColor: AppColors.appColorGray.withOpacity(0.1),
                        child: Text(
                          request['name'].split(' ').map((e) => e[0]).take(2).join(),
                          style: TextStyle(
                            color: AppColors.appColorGray,
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
                      Text(
                        request['timeAgo'],
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    request['description'].isEmpty? 'Aucune description' : request['description'],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                     
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
          
          // Section détails (visible uniquement si étendu)
          if (isExpanded) _buildExpandedContent(request),
        ],
      ),
    );
  }

  Widget _buildExpandedContent(Map<String, dynamic> request) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[50],
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
              request['description'].isNotEmpty? request['description'] : 'Aucune description fournie',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            
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
            
            const SizedBox(height: 20),
            
            // Bouton d'action
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _takeRequest(request),
                icon: const Icon(Icons.handyman, color: Colors.white),
                label: const Text(
                  'Prendre cette demande',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.appColorGray,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
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
              Flexible(
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
