// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:expertisemarket/core/constants/app_images.dart';
// import 'package:expertisemarket/core/styles/colors.dart';

// import 'package:expertisemarket/features/ServiceProvider/chat/page/chat_screen.dart';
// import 'package:expertisemarket/features/ServiceProvider/home/cubit/home_cubit.dart';
// import 'package:expertisemarket/features/ServiceProvider/home/page/home_screen.dart';
// import 'package:expertisemarket/features/ServiceProvider/home/repository/home_repository.dart';

// import 'package:expertisemarket/features/ServiceProvider/inventory/cubit/inventory_cubit.dart';
// import 'package:expertisemarket/features/ServiceProvider/inventory/page/inventory_screen.dart';

// import 'package:expertisemarket/features/ServiceProvider/notification/page/notification_screen.dart';

// import 'package:expertisemarket/features/ServiceProvider/request/cubit/request_cubit.dart';
// import 'package:expertisemarket/features/ServiceProvider/request/page/requests_screen.dart';
// import 'package:expertisemarket/features/ServiceProvider/request/repository/request_repository.dart';

// import 'package:expertisemarket/features/products/presentation/pages/profile_screen.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class MainAppScreen extends StatefulWidget {
//   const MainAppScreen({super.key});

//   @override
//   State<MainAppScreen> createState() => _MainAppScreenState();
// }

// class _MainAppScreenState extends State<MainAppScreen> {
//   late final HomeCubit _homeCubit;
//   late final InventoryCubit _inventoryCubit;
//   late final RequestCubit _requestCubit;

//   late final HomeRepository _homeRepository;
//   late final RequestRepository _requestRepository;

//   int currentIndex = 0;
//   late final List<Widget> _screens;

//   @override
//   void initState() {
//     super.initState();

//     _homeRepository = HomeRepository();
//     _requestRepository = RequestRepository();

//     _homeCubit = HomeCubit(_homeRepository);
//     _inventoryCubit = InventoryCubit();
//     _requestCubit = RequestCubit(repository: _requestRepository);

//     _screens = const [
//       HomeScreen(),
//       RequestsScreen(),
//       InventoryScreen(),
//       ChatScreen(),
//       ProfileScreen(),
//     ];
//   }

//   @override
//   void dispose() {
//     _homeCubit.close();
//     _inventoryCubit.close();
//     _requestCubit.close();
//     super.dispose();
//   }

//   Future<DocumentSnapshot<Map<String, dynamic>>> _loadWorkerData() async {
//     final uid = FirebaseAuth.instance.currentUser!.uid;
//     return FirebaseFirestore.instance.collection('workers').doc(uid).get();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<HomeCubit>.value(value: _homeCubit),
//         BlocProvider<InventoryCubit>.value(value: _inventoryCubit),
//         BlocProvider<RequestCubit>.value(value: _requestCubit),
//       ],
//       child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//         future: _loadWorkerData(),
//         builder: (context, snapshot) {
//           String workerName = "CraftMarket";
//           String imageUrl = "";

//           if (snapshot.hasData && snapshot.data!.exists) {
//             final data = snapshot.data!.data();
//             workerName = data?["name"] ?? "CraftMarket";
//             imageUrl = data?["image"] ?? "";
//           }

//           return Scaffold(
//             appBar: AppBar(
//               backgroundColor: Colors.white,
//               foregroundColor: Colors.black,
//               surfaceTintColor: Colors.white,
//               elevation: 0,
//               scrolledUnderElevation: 0,
//               shadowColor: Colors.transparent,
//               leadingWidth: 60,
//               leading: Padding(
//                 padding: const EdgeInsets.only(left: 16),
//                 child: CircleAvatar(
//                   radius: 22,
//                   backgroundColor: AppColors.backgroundColor,
//                   child: CircleAvatar(
//                     radius: 20,
//                     backgroundColor: Colors.transparent,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(20),
//                       child: imageUrl.isEmpty
//                           ? Image.asset(
//                               AppImages.User,
//                               width: 40,
//                               height: 40,
//                               fit: BoxFit.cover,
//                             )
//                           : Image.network(
//                               imageUrl,
//                               width: 40,
//                               height: 40,
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return Image.asset(
//                                   AppImages.User,
//                                   width: 40,
//                                   height: 40,
//                                   fit: BoxFit.cover,
//                                 );
//                               },
//                             ),
//                     ),
//                   ),
//                 ),
//               ),
//               title: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     workerName,
//                     style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               actions: [
//                 IconButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => const NotificationScreen(),
//                       ),
//                     );
//                   },
//                   icon: SvgPicture.asset(
//                     AppImages.notificationsSvg,
//                     width: 26,
//                     height: 26,
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//               ],
//               bottom: PreferredSize(
//                 preferredSize: const Size.fromHeight(1),
//                 child: Container(height: 1, color: Colors.grey.shade200),
//               ),
//             ),

//             // قمنا بإضافة الـ Body لعرض الشاشات بناءً على الـ Index الحالي
//             body: _screens[currentIndex],

//             // قمنا بإضافة شريط التنقل السفلي الذي كان مفقوداً في الكود القديم
//             bottomNavigationBar: Container(
//               height: 85,
//               decoration: BoxDecoration(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(25),
//                   topRight: Radius.circular(25),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(.06),
//                     blurRadius: 10,
//                     offset: const Offset(0, -2),
//                   ),
//                 ],
//               ),
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(25),
//                   topRight: Radius.circular(25),
//                 ),
//                 child: BottomNavigationBar(
//                   currentIndex: currentIndex,
//                   onTap: (index) {
//                     setState(() {
//                       currentIndex = index;
//                     });
//                   },
//                   type: BottomNavigationBarType.fixed,
//                   selectedItemColor: AppColors.primaryColor,
//                   unselectedItemColor: Colors.grey,
//                   items: [
//                     BottomNavigationBarItem(
//                       label: "Home",
//                       icon: SvgPicture.asset(
//                         AppImages.homeServiceProviderSvg,
//                         width: 24,
//                       ),
//                       activeIcon: SvgPicture.asset(
//                         AppImages.homeServiceProviderSvg,
//                         width: 24,
//                         colorFilter: const ColorFilter.mode(
//                           AppColors.primaryColor,
//                           BlendMode.srcIn,
//                         ),
//                       ),
//                     ),
//                     BottomNavigationBarItem(
//                       label: "Requests",
//                       icon: SvgPicture.asset(
//                         AppImages.requestsServiceProviderSvg,
//                         width: 24,
//                       ),
//                       activeIcon: SvgPicture.asset(
//                         AppImages.requestsServiceProviderSvg,
//                         width: 24,
//                         colorFilter: const ColorFilter.mode(
//                           AppColors.primaryColor,
//                           BlendMode.srcIn,
//                         ),
//                       ),
//                     ),
//                     BottomNavigationBarItem(
//                       label: "Inventory",
//                       icon: SvgPicture.asset(
//                         AppImages.inventoryServiceProviderSvg,
//                         width: 24,
//                       ),
//                       activeIcon: SvgPicture.asset(
//                         AppImages.inventoryServiceProviderSvg,
//                         width: 24,
//                         colorFilter: const ColorFilter.mode(
//                           AppColors.primaryColor,
//                           BlendMode.srcIn,
//                         ),
//                       ),
//                     ),
//                     BottomNavigationBarItem(
//                       label: "Chats",
//                       icon: SvgPicture.asset(
//                         AppImages.chatsServiceProviderSvg,
//                         width: 24,
//                       ),
//                       activeIcon: SvgPicture.asset(
//                         AppImages.chatsServiceProviderSvg,
//                         width: 24,
//                         colorFilter: const ColorFilter.mode(
//                           AppColors.primaryColor,
//                           BlendMode.srcIn,
//                         ),
//                       ),
//                     ),
//                     BottomNavigationBarItem(
//                       label: "Profile",
//                       icon: SvgPicture.asset(AppImages.profileSvg, width: 24),
//                       activeIcon: SvgPicture.asset(
//                         AppImages.profileSvg,
//                         width: 24,
//                         colorFilter: const ColorFilter.mode(
//                           AppColors.primaryColor,
//                           BlendMode.srcIn,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/core/styles/colors.dart';

import 'package:expertisemarket/features/ServiceProvider/chat/page/chat_screen.dart';

import 'package:expertisemarket/features/ServiceProvider/home/cubit/home_cubit.dart';
import 'package:expertisemarket/features/ServiceProvider/home/page/home_screen.dart';
import 'package:expertisemarket/features/ServiceProvider/home/repository/home_repository.dart';

import 'package:expertisemarket/features/ServiceProvider/inventory/cubit/inventory_cubit.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/page/inventory_screen.dart';

import 'package:expertisemarket/features/ServiceProvider/notification/page/notification_screen.dart';

import 'package:expertisemarket/features/ServiceProvider/request/cubit/request_cubit.dart';
import 'package:expertisemarket/features/ServiceProvider/request/page/requests_screen.dart';
import 'package:expertisemarket/features/ServiceProvider/request/repository/request_repository.dart';

import 'package:expertisemarket/features/products/presentation/pages/profile_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  late final HomeCubit _homeCubit;

  late final InventoryCubit _inventoryCubit;

  late final RequestCubit _requestCubit;

  late final HomeRepository _homeRepository;

  late final RequestRepository _requestRepository;

  int currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _homeRepository = HomeRepository();

    _requestRepository = RequestRepository();

    _homeCubit = HomeCubit(_homeRepository);

    _inventoryCubit = InventoryCubit();

    // نفس الـ Cubit الذي سيستخدمه Home و Requests
    _requestCubit = RequestCubit(repository: _requestRepository);

    _screens = const [
      HomeScreen(),

      RequestsScreen(),

      InventoryScreen(),

      ChatScreen(),

      ProfileScreen(),
    ];
  }

  @override
  void dispose() {
    _homeCubit.close();

    _inventoryCubit.close();

    _requestCubit.close();

    super.dispose();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _loadWorkerData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance.collection('workers').doc(uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>.value(value: _homeCubit),

        BlocProvider<InventoryCubit>.value(value: _inventoryCubit),

        BlocProvider<RequestCubit>.value(value: _requestCubit),
      ],

      child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: _loadWorkerData(),

        builder: (context, snapshot) {
          String workerName = "CraftMarket";

          String imageUrl = "";

          if (snapshot.hasData && snapshot.data!.exists) {
            final data = snapshot.data!.data();

            workerName = data?["name"] ?? "CraftMarket";

            imageUrl = data?["image"] ?? "";
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,

              foregroundColor: Colors.black,

              surfaceTintColor: Colors.white,

              elevation: 0,

              scrolledUnderElevation: 0,

              leadingWidth: 60,

              leading: Padding(
                padding: const EdgeInsets.only(left: 16),

                child: CircleAvatar(
                  radius: 22,

                  backgroundColor: AppColors.backgroundColor,

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),

                    child: imageUrl.isEmpty
                        ? Image.asset(
                            AppImages.User,

                            width: 40,

                            height: 40,

                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            imageUrl,

                            width: 40,

                            height: 40,

                            fit: BoxFit.cover,

                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                AppImages.User,

                                width: 40,

                                height: 40,

                                fit: BoxFit.cover,
                              );
                            },
                          ),
                  ),
                ),
              ),

              title: Text(
                workerName,

                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),

              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (_) => const NotificationScreen(),
                      ),
                    );
                  },

                  icon: SvgPicture.asset(
                    AppImages.notificationsSvg,

                    width: 26,

                    height: 26,
                  ),
                ),

                const SizedBox(width: 8),
              ],

              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1),

                child: Container(height: 1, color: Colors.grey.shade200),
              ),
            ),
            body: _screens[currentIndex],

            bottomNavigationBar: Container(
              height: 85,

              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),

                  topRight: Radius.circular(25),
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.06),

                    blurRadius: 10,

                    offset: const Offset(0, -2),
                  ),
                ],
              ),

              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),

                  topRight: Radius.circular(25),
                ),

                child: BottomNavigationBar(
                  currentIndex: currentIndex,

                  onTap: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },

                  type: BottomNavigationBarType.fixed,

                  selectedItemColor: AppColors.primaryColor,

                  unselectedItemColor: Colors.grey,

                  items: [
                    BottomNavigationBarItem(
                      label: "Home",

                      icon: SvgPicture.asset(
                        AppImages.homeServiceProviderSvg,

                        width: 24,
                      ),

                      activeIcon: SvgPicture.asset(
                        AppImages.homeServiceProviderSvg,

                        width: 24,

                        colorFilter: const ColorFilter.mode(
                          AppColors.primaryColor,

                          BlendMode.srcIn,
                        ),
                      ),
                    ),

                    BottomNavigationBarItem(
                      label: "Requests",

                      icon: SvgPicture.asset(
                        AppImages.requestsServiceProviderSvg,

                        width: 24,
                      ),

                      activeIcon: SvgPicture.asset(
                        AppImages.requestsServiceProviderSvg,

                        width: 24,

                        colorFilter: const ColorFilter.mode(
                          AppColors.primaryColor,

                          BlendMode.srcIn,
                        ),
                      ),
                    ),

                    BottomNavigationBarItem(
                      label: "Inventory",

                      icon: SvgPicture.asset(
                        AppImages.inventoryServiceProviderSvg,

                        width: 24,
                      ),

                      activeIcon: SvgPicture.asset(
                        AppImages.inventoryServiceProviderSvg,

                        width: 24,

                        colorFilter: const ColorFilter.mode(
                          AppColors.primaryColor,

                          BlendMode.srcIn,
                        ),
                      ),
                    ),

                    BottomNavigationBarItem(
                      label: "Chats",

                      icon: SvgPicture.asset(
                        AppImages.chatsServiceProviderSvg,

                        width: 24,
                      ),

                      activeIcon: SvgPicture.asset(
                        AppImages.chatsServiceProviderSvg,

                        width: 24,

                        colorFilter: const ColorFilter.mode(
                          AppColors.primaryColor,

                          BlendMode.srcIn,
                        ),
                      ),
                    ),

                    BottomNavigationBarItem(
                      label: "Profile",

                      icon: SvgPicture.asset(AppImages.profileSvg, width: 24),

                      activeIcon: SvgPicture.asset(
                        AppImages.profileSvg,

                        width: 24,

                        colorFilter: const ColorFilter.mode(
                          AppColors.primaryColor,

                          BlendMode.srcIn,
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
    );
  }
}
