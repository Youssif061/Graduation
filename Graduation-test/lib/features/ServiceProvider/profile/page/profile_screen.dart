import 'dart:io';
import 'package:flutter/material.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:expertisemarket/core/routes/routers.dart';
import 'package:expertisemarket/features/auth/change_password_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _darkMode = false;
  late Future<String> _collectionFuture;
  final _fullNameCtrl = TextEditingController();
  bool _isSaving = false;
  String? _currentNameInDb;

  @override
  void initState() {
    super.initState();
    _collectionFuture = _determineCollection();
  }

  Future<String> _determineCollection() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception("Not logged in");
    
    // Check users collection first
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userDoc.exists) return 'users';
    
    // Fallback to workers
    return 'workers';
  }

  Future<int> _fetchTotalJobs(String uid) async {
    final completedRequests = await FirebaseFirestore.instance
        .collection('requests')
        .where('workerId', isEqualTo: uid)
        .where('status', isEqualTo: 'completed')
        .get();

    final completedOrders = await FirebaseFirestore.instance
        .collection('orders')
        .where('providerId', isEqualTo: uid)
        .where('status', isEqualTo: 'completed')
        .get();

    return completedRequests.docs.length + completedOrders.docs.length;
  }

  Future<void> _changePhoto(String collection, String uid) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (pickedFile == null) return;

    setState(() => _isSaving = true);
    try {
      final file = File(pickedFile.path);
      final ref = FirebaseStorage.instance
          .ref()
          .child('profile_pictures/$uid.jpg');
      await ref.putFile(file);
      final url = await ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection(collection)
          .doc(uid)
          .update({'image': url});

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile photo updated successfully")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to upload image: $e")),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<void> _deletePhoto(String collection, String uid) async {
    setState(() => _isSaving = true);
    try {
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(uid)
          .update({'image': ''});
      
      try {
        await FirebaseStorage.instance.ref().child('profile_pictures/$uid.jpg').delete();
      } catch (_) {}
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile photo removed")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to delete photo: $e")),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<void> _saveName(String collection, String uid) async {
    final newName = _fullNameCtrl.text.trim();
    if (newName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Name cannot be empty")),
      );
      return;
    }

    setState(() => _isSaving = true);
    try {
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(uid)
          .update({'name': newName});
      
      setState(() {
        _currentNameInDb = newName;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Name updated successfully")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update name: $e")),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  void dispose() {
    _fullNameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return const Scaffold(
        body: Center(child: Text("User not logged in")),
      );
    }

    return FutureBuilder<String>(
      future: _collectionFuture,
      builder: (context, colSnapshot) {
        if (colSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (colSnapshot.hasError || !colSnapshot.hasData) {
          return Scaffold(
            body: Center(child: Text("Error: ${colSnapshot.error ?? 'Could not load profile type'}")),
          );
        }

        final collection = colSnapshot.data!;

        return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection(collection).doc(uid).snapshots(),
          builder: (context, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (!streamSnapshot.hasData || !streamSnapshot.data!.exists) {
              return const Scaffold(
                body: Center(child: Text("Profile data not found")),
              );
            }

            final data = streamSnapshot.data!.data()!;
            final name = data['name'] ?? '';
            final image = data['image'] ?? '';

            if (_currentNameInDb == null) {
              _fullNameCtrl.text = name;
              _currentNameInDb = name;
            }

            return Scaffold(
              backgroundColor: AppColors.marketBg,
              appBar: AppBar(
                title: const Text("Profile Settings"),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
              ),
              body: Stack(
                children: [
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      // Avatar Card
                      _SettingsCard(
                        child: Column(
                          children: [
                            const SizedBox(height: 8),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: AppColors.marketCardLight,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.marketBorder,
                                      width: 2,
                                    ),
                                  ),
                                  child: image.isNotEmpty
                                      ? ClipOval(
                                          child: Image.network(
                                            image,
                                            width: 86,
                                            height: 86,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return const Icon(
                                                Icons.person,
                                                color: AppColors.marketTextSub,
                                                size: 48,
                                              );
                                            },
                                          ),
                                        )
                                      : const Icon(
                                          Icons.person,
                                          color: AppColors.marketTextSub,
                                          size: 48,
                                        ),
                                ),
                                Positioned(
                                  bottom: 2,
                                  right: 2,
                                  child: GestureDetector(
                                    onTap: () => _changePhoto(collection, uid),
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: const BoxDecoration(
                                        color: AppColors.marketGreen,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => _changePhoto(collection, uid),
                                  child: Text(
                                    'Change Photo',
                                    style: MarketTextStyles.bodySmall.copyWith(
                                      color: AppColors.marketText,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                if (image.isNotEmpty) ...[
                                  const SizedBox(width: 20),
                                  GestureDetector(
                                    onTap: () => _deletePhoto(collection, uid),
                                    child: Text(
                                      '🗑 Delete',
                                      style: MarketTextStyles.bodySmall.copyWith(
                                        color: AppColors.marketRed,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Account Settings section
                      Text(
                        'ACCOUNT SETTINGS',
                        style: MarketTextStyles.sectionLabel.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 11,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _SettingsCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _FieldLabel('FULL NAME'),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(child: _InputField(controller: _fullNameCtrl)),
                                const SizedBox(width: 10),
                                TextButton(
                                  onPressed: () => _saveName(collection, uid),
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors.marketGreen,
                                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  child: const Text("SAVE"),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ChangePasswordScreen(),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Change Password',
                                    style: MarketTextStyles.productTitle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.marketText,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.chevron_right,
                                    color: AppColors.marketTextSub,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Statistics section (Workers only)
                      if (collection == 'workers') ...[
                        Text(
                          'STATISTICS',
                          style: MarketTextStyles.sectionLabel.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 11,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 10),
                        FutureBuilder<int>(
                          future: _fetchTotalJobs(uid),
                          builder: (context, statsSnapshot) {
                            final totalJobs = statsSnapshot.data ?? 0;
                            final rating = data['rating'] ?? 0.0;
                            final reviews = data['reviews'] ?? 0;
                            return Row(
                              children: [
                                Expanded(
                                  child: _SettingsCard(
                                    child: Column(
                                      children: [
                                        const Text(
                                          "TOTAL JOBS",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.marketTextMuted,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "$totalJobs",
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.marketText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _SettingsCard(
                                    child: Column(
                                      children: [
                                        const Text(
                                          "RATING",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.marketTextMuted,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "${(rating as num).toStringAsFixed(1)}",
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.marketText,
                                          ),
                                        ),
                                        Text(
                                          "($reviews Reviews)",
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: AppColors.marketTextMuted,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Preferences section
                      Text(
                        'PREFERENCES',
                        style: MarketTextStyles.sectionLabel.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 11,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _SettingsCard(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Dark Mode',
                              style: MarketTextStyles.productTitle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.marketText,
                              ),
                            ),
                            Switch(
                              value: _darkMode,
                              onChanged: (val) {
                                setState(() => _darkMode = val);
                              },
                              activeThumbColor: AppColors.marketGreen,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Logout Settings Card
                      _SettingsCard(
                        child: GestureDetector(
                          onTap: () async {
                            await FirebaseAuth.instance.signOut();
                            if (context.mounted) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                Routers.welcomeScreen,
                                (route) => false,
                              );
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Logout',
                                style: MarketTextStyles.productTitle.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.marketRed,
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right,
                                color: AppColors.marketRed,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                  if (_isSaving)
                    Container(
                      color: Colors.black26,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final Widget child;

  const _SettingsCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.marketCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.marketBorder),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.01), blurRadius: 8),
        ],
      ),
      child: child,
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;

  const _FieldLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: AppColors.marketTextMuted,
        letterSpacing: 1.0,
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;

  const _InputField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.marketInputBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        style: MarketTextStyles.bodyMedium.copyWith(
          color: AppColors.marketText,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        ),
      ),
    );
  }
}