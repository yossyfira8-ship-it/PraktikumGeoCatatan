import 'dart:convert'; // Untuk JSON
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlong;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'catatan_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<CatatanModel> _savedNotes = [];
  final MapController _mapController = MapController();
  latlong.LatLng? _myLocation;

  @override
  void initState() {
    super.initState();
    _loadNotes(); // Load data saat aplikasi mulai (Tugas 3)
  }

  // --- FITUR SIMPAN & LOAD (Tugas 3) ---
  Future<void> _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(
      _savedNotes.map((note) => note.toJson()).toList(),
    );
    await prefs.setString('saved_notes', encodedData);
  }

  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? notesString = prefs.getString('saved_notes');
    if (notesString != null) {
      final List<dynamic> decodedData = jsonDecode(notesString);
      setState(() {
        _savedNotes = decodedData
            .map((item) => CatatanModel.fromJson(item))
            .toList();
      });
    }
  }

  // --- FITUR LOKASI ---
  Future<void> _findMyLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _myLocation = latlong.LatLng(position.latitude, position.longitude);
    });

    _mapController.move(_myLocation!, 15.0);
  }

  // --- FITUR TAMBAH DENGAN PILIHAN JENIS (Tugas 1) ---
  void _handleLongPress(TapPosition _, latlong.LatLng point) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        point.latitude,
        point.longitude,
      );
      String address = placemarks.first.street ?? "Alamat tidak dikenal";

      // Tampilkan Dialog Pilihan Jenis
      _showTypeSelectionDialog(point, address);

    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  void _showTypeSelectionDialog(latlong.LatLng point, String address) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text("Pilih Jenis Lokasi"),
        children: [
          _buildDialogOption(ctx, point, address, "Rumah", Icons.home, Colors.green),
          _buildDialogOption(ctx, point, address, "Toko", Icons.store, Colors.blue),
          _buildDialogOption(ctx, point, address, "Kantor", Icons.work, Colors.orange),
        ],
      ),
    );
  }

  Widget _buildDialogOption(BuildContext ctx, latlong.LatLng point, String address, String type, IconData icon, Color color) {
    return SimpleDialogOption(
      onPressed: () {
        setState(() {
          _savedNotes.add(CatatanModel(
            position: point,
            note: "Catatan Baru",
            address: address,
            jenis: type, // Simpan jenis yang dipilih
          ));
        });
        _saveNotes(); // Simpan ke memori
        Navigator.pop(ctx);
      },
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Text(type),
        ],
      ),
    );
  }

  // --- FITUR HAPUS (Tugas 2) ---
  void _showDeleteDialog(CatatanModel note) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Hapus ${note.jenis}?"),
        content: Text(note.address),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Batal")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                _savedNotes.remove(note);
              });
              _saveNotes(); // Update penyimpanan
              Navigator.pop(ctx);
            },
            child: const Text("Hapus", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // Helper untuk memilih ikon berdasarkan jenis (Tugas 1)
  IconData _getIconForType(String type) {
    switch (type) {
      case 'Toko': return Icons.store;
      case 'Kantor': return Icons.work;
      case 'Rumah': default: return Icons.home;
    }
  }

  Color _getColorForType(String type) {
    switch (type) {
      case 'Toko': return Colors.blue;
      case 'Kantor': return Colors.orange;
      case 'Rumah': default: return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Geo-Catatan Lengkap")),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: const latlong.LatLng(-6.2, 106.8),
          initialZoom: 13.0,
          onLongPress: _handleLongPress,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.geocatatan',
          ),
          MarkerLayer(
            markers: [
              // Marker Catatan (Tugas 1: Ikon beda-beda)
              ..._savedNotes.map((n) => Marker(
                point: n.position,
                width: 50,
                height: 50,
                child: GestureDetector(
                  onTap: () => _showDeleteDialog(n), // Tugas 2: Klik untuk hapus
                  child: Icon(
                    _getIconForType(n.jenis),
                    color: _getColorForType(n.jenis),
                    size: 40,
                  ),
                ),
              )),

              // Marker Lokasi Saya
              if (_myLocation != null)
                Marker(
                  point: _myLocation!,
                  width: 40,
                  height: 40,
                  child: const Icon(Icons.gps_fixed, color: Colors.red, size: 35),
                ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _findMyLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}