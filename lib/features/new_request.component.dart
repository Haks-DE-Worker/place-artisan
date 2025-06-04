import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'dart:async';
import 'dart:io';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';

import '../common/constants/app_colors.dart';
import '../common/widgets/app_text_field.dart';
import '../common/widgets/map_picker_page.dart';

class NewRequestPage extends StatefulWidget {
  const NewRequestPage({super.key});

  @override
  State<NewRequestPage> createState() {
    return _NewRequestPageState();
  }
}

class _NewRequestPageState extends State<NewRequestPage> {
  // Variables to get request form informations
  String selectedServiceId = "";
  String clientName = ""; 
  String clientPhone = "";
  String clientPayementNumber = "";
  bool isPayementNumber = false;
  String clientAddress = "";
  String problemDescription = "";
  String audioIssue = "";
  String imageIssue = "";
  bool useCurrentLocation = true; // Checkbox pour utiliser la position actuelle

  String? _audioPath;
  String? _imagePath;
   bool _isLoading = false; // Pour gérer l'état de chargement

  //Fonction pour recupere la position actuelle
  Future<Position?> _getCurrentPosition() async{
     // 1. Demander la permission de localisation
  var status = await Permission.location.status;
  if (!status.isGranted) {
    status = await Permission.location.request();
    if (!status.isGranted) {
      // Permission refusée
      
      return null;
    }
  }

  // 2. Vérifier que le service de localisation est activé
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Le service localisation n'est pas activé sur le téléphone
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Service de localisation désactivé'),
        content: const Text(
          'Veuillez activer la localisation pour utiliser cette fonctionnalité.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    return null;
  }
  try {
    // 3. Récupérer la position actuelle
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );
    return position;
  } catch (e) {
    print("Erreur lors de la récupération de la position: $e");
    return null;
  }

  }


  // Fonction pour récupérer l'adresse actuelle
  Future<void> _getCurrentLocation(BuildContext context) async {
    try{
    Position? position = await _getCurrentPosition();
    if (position == null) {
      // Si la position n'a pas pu être récupérée, afficher un message d'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Impossible de récupérer votre position actuelle.')),
      );
      return null;
    }

    // 4. Convertir latitude/longitude en adresse
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      // Construire une adresse lisible
      
      String address = "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
      
      setState(() {
        clientAddress = address; 
      });
      print("Position actuelle: $clientAddress");
    }
  } catch (e) {
    print("Erreur lors de la récupération de la position ou de l'adresse: $e");
    return null;
  }

  return null;
}

  //fonction pour piquer l'emplacement
  Future<void> pickLocationFromMap(BuildContext context, ) async {
    Position? position = await _getCurrentPosition();
    if (position == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Impossible de récupérer votre position actuelle pour ouvrir la carte.')),
      );
      return null;
    }

    //recuperer la lattitude et longitude
    LatLng initialPosition = LatLng(position.latitude, position.longitude);
    
    final LatLng? selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MapPickerPage(initialPosition: initialPosition),
      ),
    );
    if (selectedLocation != null) {
    print('Position sélectionnée : ${selectedLocation.latitude}, ${selectedLocation.longitude}');
      // Géocodage inverse pour convertir en adresse
      List<Placemark> placemarks = await placemarkFromCoordinates(
        selectedLocation.latitude,
        selectedLocation.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        String fullAddress =
            "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";

        print('Adresse : $fullAddress');
        setState(() {
          clientAddress = fullAddress; // Mettre à jour l'adresse dans le formulaire
        });
        

      } else {
        print('Aucune adresse trouvée pour cette position');
      }
  } else {
    print('Aucune position sélectionnée');
  }
  
}
  
  //Fonction pour soumettre la demande
  void _submitRequest(BuildContext context) async{
    if (clientName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez inscrire votre nom.')),
      );
      return;
    }
    if(problemDescription.isEmpty && _audioPath == null && _imagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez décrire votre problème ou ajouter un audio/image.')),
      );
      return;
    }	

    if(useCurrentLocation){
     await  _getCurrentLocation(context);
    }
    if(clientAddress.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez piquer l\'emplacement désiré  ou utiliser votre position actuelle.')),
      );
      return;
    }

    //Affichage des données
    print('Nom du client: $clientName');
    print('Adresse du client: $clientAddress');
    print('Description du problème: $problemDescription');
    if (_audioPath != null) {
      print('Audio du problème: $_audioPath');
    } else {
      print('Aucun audio ajouté.');
    }
    if (_imagePath != null) {
      print('Image du problème: $_imagePath');
    } else {
      print('Aucune image ajoutée.');
    }
    
    // Logique de soumission de la demande
    setState(() {
      _isLoading = true; // Démarrer le chargement
    });
    // Simuler une soumission de demande
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isLoading = false; // Arrêter le chargement
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Demande soumise avec succès !')),
    );

    // Réinitialiser le formulaire après soumission
    setState(() {
      clientName = '';
      clientAddress = '';
      problemDescription = '';
      _audioPath = null;
      _imagePath = null;
      useCurrentLocation = true; // Réinitialiser la checkbox
    });
    

  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlayPro(
      isLoading: _isLoading,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: AppColors.appColorGray,
          title: const Text(
            'Nouvelle demande', 
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            )
          ),
        ),
        body: Column(
          children: [
            // Header avec design 
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.appColorGray,
                    AppColors.appColorGray.withOpacity(0.8),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.support_agent,
                      size: 48,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Soumettez votre préoccupation',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Décrivez votre problème en quelques clics',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            
            // Formulaire
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Informations personnelles
                      _buildSectionTitle('Informations personnelles', Icons.person),
                      const SizedBox(height: 16),
                      _buildCard(
                        child: AppTextField(
                          hintText: 'Entrez votre nom complet',
                          labelText: '',
                          isLabelBold: true,
                          isObcureText: false,
                          onChanged: (value) => setState(() => clientName = value),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Section Description du problème
                      _buildSectionTitle('Description du problème', Icons.description),
                      const SizedBox(height: 16),
                      _buildCard(
                        child: AppTextField(
                          hintText: 'problème(champs optionnel)',
                          labelText: '',
                          maxLines: 3,
                          isObcureText: false,
                          isLabelBold: true,
                          onChanged: (value) => setState(() => problemDescription = value),
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Section Problèmes spécifiques
                      ProblemsSection(
                        onAudioChanged: (audioPath) {
                          // Gérer le chemin de l'audio
                          setState(() => _audioPath = audioPath);
                        },
                        onImageChanged: (imagePath) {
                          // Gérer le chemin de l'image
                          setState(() => _imagePath = imagePath);
                        },
                      ),
                      const SizedBox(height: 24),
                      
                      // Section Localisation
                      _buildSectionTitle('Localisation', Icons.location_on),
                      const SizedBox(height: 16),
                      _buildCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: useCurrentLocation,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      useCurrentLocation = value ?? true;
                                    });
                                  },
                                  activeColor: AppColors.appColorGray,
                                ),
                                const Expanded(
                                  child: Text(
                                    'Utiliser ma position actuelle',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            // Bouton "Piquer ma position" si checkbox décochée
                            if (!useCurrentLocation) ...[
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: ()async {
                                    pickLocationFromMap(context);
                                  },
                                  icon: const Icon(Icons.my_location, size: 20),
                                  label: const Text('Piquer ma position'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.appColorGray,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Bouton de soumission
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async{
                            _submitRequest(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.appColorGray,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          child: const Text(
                            'Soumettre la demande',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
 
 Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}


class ProblemsSection extends StatefulWidget {
  final Function(String?) onAudioChanged;
  final Function(String?) onImageChanged;

  const ProblemsSection({
    Key? key,
    required this.onAudioChanged,
    required this.onImageChanged,
  }) : super(key: key);

  @override
  State<ProblemsSection> createState() => _ProblemsSectionState();
}

class _ProblemsSectionState extends State<ProblemsSection> {
  FlutterSoundRecorder? _recorder;
  FlutterSoundPlayer? _player;
  String? _audioPath;
  String? _imagePath;
  bool _isRecording = false;
  bool _isPlaying = false;
  bool _hasRecording = false; // Nouveau: pour savoir si on a un enregistrement
  int _recordingDuration = 0;
  Timer? _timer;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initializeAudio();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recorder?.closeRecorder();
    _player?.closePlayer();
    super.dispose();
  }

  Future<void> _initializeAudio() async {
    _recorder = FlutterSoundRecorder();
    _player = FlutterSoundPlayer();
    
    await _recorder!.openRecorder();
    await _player!.openPlayer();
  }

   Future<bool> _requestPermissions() async {
    Map<Permission, PermissionStatus> permissions = await [
      Permission.microphone,
      Permission.storage,
    ].request();

    return permissions[Permission.microphone]?.isGranted == true;
  }

  Future<void> _startRecording() async {
    if (!await _requestPermissions()) {
      _showPermissionDialog('microphone');
      return;
    }

    final directory = Directory.systemTemp;
    _audioPath = '${directory.path}/audio_record_${DateTime.now().millisecondsSinceEpoch}.aac';

    await _recorder!.startRecorder(
      toFile: _audioPath,
      codec: Codec.aacADTS,
    );

    setState(() {
      _isRecording = true;
      _hasRecording = false;
      _recordingDuration = 0;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _recordingDuration++;
      });

      // Arrêter automatiquement après 60 secondes
      if (_recordingDuration >= 60) {
        _stopRecording();
      }
    });
  }

  Future<void> _stopRecording() async {
    _timer?.cancel();
    await _recorder!.stopRecorder();
    
    setState(() {
      _isRecording = false;
      _hasRecording = true;
    });

    widget.onAudioChanged(_audioPath);
  }

  Future<void> _playAudio() async {
    if (_audioPath == null) return;

    if (_isPlaying) {
      await _player!.stopPlayer();
      setState(() => _isPlaying = false);
    } else {
      await _player!.startPlayer(
        fromURI: _audioPath,
        whenFinished: () => setState(() => _isPlaying = false),
      );
      setState(() => _isPlaying = true);
    }
  }

  void _cancelRecording() {
    setState(() {
      _audioPath = null;
      _recordingDuration = 0;
      _hasRecording = false;
      _isPlaying = false;
    });
    widget.onAudioChanged(null);
  }

  Future<void> _pickImage() async {
    final PermissionStatus permission = await Permission.storage.request();
    
    if (!permission.isGranted) {
      _showPermissionDialog('photos');
      return;
    }

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _imagePath = image.path;
        });
        widget.onImageChanged(image.path);
      }
    } catch (e) {
      _showErrorDialog('Erreur lors de la sélection de l\'image');
    }
  }

  Future<void> _takePhoto() async {
    final PermissionStatus permission = await Permission.camera.request();
    
    if (!permission.isGranted) {
      _showPermissionDialog('camera');
      return;
    }

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _imagePath = image.path;
        });
        widget.onImageChanged(image.path);
      }
    } catch (e) {
      _showErrorDialog('Erreur lors de la prise de photo');
    }
  }

  void _removeImage() {
    setState(() {
      _imagePath = null;
    });
    widget.onImageChanged(null);
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sélectionner une image'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galerie'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Appareil photo'),
                onTap: () {
                  Navigator.pop(context);
                  _takePhoto();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPermissionDialog(String permission) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission requise'),
          content: Text('L\'accès au $permission est nécessaire pour cette fonctionnalité.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                openAppSettings();
              },
              child: const Text('Paramètres'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erreur'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }

  Widget _buildAudioSection() {
    if (_isRecording) {
      // État: En cours d'enregistrement
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          border: Border.all(color: Colors.red.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(
              Icons.mic,
              size: 48,
              color: Colors.red.shade700,
            ),
            const SizedBox(height: 8),
            const Text(
              'Enregistrement en cours...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _formatDuration(_recordingDuration),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: _recordingDuration / 60,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(
                _recordingDuration < 50 ? Colors.red.shade600 : Colors.red.shade800,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _stopRecording,
              icon: const Icon(Icons.stop),
              label: const Text('Arrêter'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      );
    } else if (_hasRecording && _audioPath != null) {
      // État: Enregistrement terminé
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          border: Border.all(color: Colors.green.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.audiotrack, color: Colors.green.shade700, size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Audio enregistré',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Durée: ${_formatDuration(_recordingDuration)}',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: _cancelRecording,
                  icon: const Icon(Icons.close),
                  color: Colors.red,
                  tooltip: 'Supprimer et recommencer',
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _playAudio,
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              label: Text(_isPlaying ? 'Pause' : 'Écouter'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      );
    } else {
      // État: Pas d'enregistrement
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(
              Icons.mic,
              size: 48,
              color: Colors.grey.shade600,
            ),
            const SizedBox(height: 8),
            Text(
              'Enregistrer un audio (max 1 min)',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _startRecording,
              icon: const Icon(Icons.mic),
              label: const Text('Enregistrer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Problèmes spécifiques', Icons.bug_report),
        const SizedBox(height: 16),
        _buildCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Audio
              Text(
                'Problème audio',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              
              _buildAudioSection(),

              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 16),

              // Section Image
              Text(
                'Problème image',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),

              if (_imagePath == null) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.image,
                        size: 48,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Ajouter une image du problème',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: _showImageSourceDialog,
                        icon: const Icon(Icons.add_photo_alternate),
                        label: const Text('Ajouter une image'),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    border: Border.all(color: Colors.blue.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                            child: Image.file(
                              File(_imagePath!),
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: _removeImage,
                                icon: const Icon(Icons.close, color: Colors.white),
                                iconSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.blue.shade700),
                            const SizedBox(width: 8),
                            const Text('Image ajoutée avec succès'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}