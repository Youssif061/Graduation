import 'package:expertisemarket/features/products/models/product_model.dart';

abstract class DummyData {
  // ─── Categories ────────────────────────────────────────────────
  static const List<String> categories = [
    'All Gear',
    'Tools',
    'Electrical',
    'Plumbing',
    'Flooring',
  ];

  // ─── Recent Searches ───────────────────────────────────────────
  static const List<String> recentSearches = [
    '18V Hammer Drill',
    'Piping Kit',
    'Voltage Tester',
  ];

  // ─── Trending Categories ───────────────────────────────────────
  static const List<String> trendingCategories = [
    'Power Tools',
    'Hand Tools',
    'Electrical',
    'Plumbing',
    'Safety Gear',
    'Measuring',
  ];

  // ─── Featured Products (Pros / Home tab) ───────────────────────
  static final List<ProductModel> featuredProducts = [
    ProductModel(
      id: 'p1',
      providerId: 'expert_dummy',
      name: 'Elite Force 18V Hammer Drill',
      category: 'Tools',
      description:
          'High-torque brushless motor with advanced ergonomics for extended professional use.',
      imageAsset: 'assets/images/drill.png',
      price: 249.00,
      originalPrice: 299.00,
      rating: 4.7,
      reviewCount: 312,
      isNew: true,
      inStock: true,
      storeName: 'Mastercraft Solutions Ltd',
      storeRating: 4.8,
      storeProducts: '850+',
      bulletPoints: [
        'Lifetime warranty on all metal components',
        'Impact-resistant dual-locking carrying case',
        'Meets or exceeds ANSI and DIN standards',
      ],
      specs: {
        'Material': 'Aircraft-Grade Aluminum',
        'Voltage': '18V',
        'Weight': '2.1 kg / 4.6 lbs',
        'Certifications': 'CE, UL, CSA',
      },
      thumbnails: ['assets/images/drill.png'],
      createdAt: DateTime(2026, 1, 1),
    ),
    ProductModel(
      id: 'p2',
      providerId: 'expert_dummy',
      name: 'MasterFix Pro Plumbing Kit',
      category: 'Plumbing',
      description:
          'Complete specialized set for professional installations including laser-cut wrenches.',
      imageAsset: 'assets/images/plumbing.png',
      price: 185.50,
      originalPrice: 210.00,
      rating: 4.5,
      reviewCount: 198,
      isNew: false,
      inStock: true,
      storeName: 'ProFix Supplies',
      storeRating: 4.6,
      storeProducts: '420+',
      bulletPoints: [
        'Complete set for all pipe sizes',
        'Corrosion-resistant fittings',
        'Professional-grade seal materials',
      ],
      specs: {
        'Material': 'Brass & Copper',
        'Pieces': '48 Total',
        'Weight': '3.2 kg / 7 lbs',
        'Certifications': 'NSF, ASTM',
      },
      thumbnails: ['assets/images/plumbing.png'],
      createdAt: DateTime(2026, 1, 1),
    ),
    ProductModel(
      id: 'p3',
      providerId: 'expert_dummy',
      name: 'VoltGuard 9000 Tester',
      category: 'Electrical',
      description:
          'Premium digital multimeter with wireless logging and ultra-high safety rating.',
      imageAsset: 'assets/images/tester.png',
      price: 120.00,
      originalPrice: 149.99,
      rating: 4.6,
      reviewCount: 267,
      isNew: false,
      inStock: true,
      storeName: 'ElectroMax Tools',
      storeRating: 4.7,
      storeProducts: '300+',
      bulletPoints: [
        'CAT IV safety rating',
        'Bluetooth wireless data logging',
        'True RMS measurements',
      ],
      specs: {
        'Display': '6000-Count LCD',
        'Input Impedance': '10 MΩ',
        'Weight': '0.45 kg / 1 lbs',
        'Certifications': 'CE, UL, CAT IV',
      },
      thumbnails: ['assets/images/tester.png'],
      createdAt: DateTime(2026, 1, 1),
    ),
    ProductModel(
      id: 'p4',
      providerId: 'expert_dummy',
      name: 'OmniLevel 360 Laser',
      category: 'Tools',
      description:
          'Self-leveling 360-degree laser with outdoor pulse mode for bright environments.',
      imageAsset: 'assets/images/laser.png',
      price: 310.00,
      originalPrice: 380.00,
      rating: 4.8,
      reviewCount: 445,
      isNew: false,
      inStock: true,
      storeName: 'LevelPro Equipment',
      storeRating: 4.9,
      storeProducts: '150+',
      bulletPoints: [
        'Self-leveling within ±4°',
        '50m working range (200m with detector)',
        'IP54 dust and splash protection',
      ],
      specs: {
        'Accuracy': '±1mm at 10m',
        'Range': '50m / 200m (detector)',
        'Weight': '1.1 kg / 2.4 lbs',
        'Certifications': 'CE, FCC, RoHS',
      },
      thumbnails: ['assets/images/laser.png'],
      createdAt: DateTime(2026, 1, 1),
    ),
  ];

  // ─── Mechanic Toolkit (Product Details screen) ─────────────────
  static final ProductModel mechanicToolkit = ProductModel(
    id: 'pd1',
    providerId: 'expert_dummy',
    name: 'Professional Master Mechanic Toolkit (152-Piece)',
    category: 'Tools',
    description:
        'Engineered for high-stakes automotive and industrial repairs, the Professional Master Mechanic Toolkit offers a comprehensive selection of 152 precision-machined tools. Each component is forged from high-density chrome vanadium steel and features an ergonomic grip designed for all-day comfort.',
    imageAsset: 'assets/images/toolkit.png',
    price: 120.00,
    originalPrice: 199.99,
    rating: 4.8,
    reviewCount: 245,
    isNew: true,
    inStock: true,
    storeName: 'Mastercraft Solutions Ltd',
    storeRating: 4.8,
    storeProducts: '850+',
    bulletPoints: [
      'Lifetime warranty on all metal components',
      'Impact-resistant dual-locking carrying case',
      'Meets or exceeds ANSI and DIN standards',
    ],
    specs: {
      'Material': 'Chrome Vanadium',
      'Pieces Included': '152 Total',
      'Weight': '14.5 kg / 32 lbs',
      'Certifications': 'ANSI/ASME, DIN',
    },
    thumbnails: [
      'assets/images/toolkit.png',
      'assets/images/toolkit.png',
      'assets/images/toolkit.png',
      'assets/images/toolkit.png',
    ],
    createdAt: DateTime(2026, 1, 1),
  );

  // ─── Search Recommended ────────────────────────────────────────
  static final List<ProductModel> searchRecommended = [
    ProductModel(
      id: 'sr1',
      providerId: 'expert_dummy',
      name: 'Titan 4500 Laser Level',
      category: 'Tools',
      description: 'Professional laser level with 4500 lumen output.',
      imageAsset: 'assets/images/laser.png',
      price: 299.00,
      originalPrice: 350.00,
      rating: 4.7,
      reviewCount: 189,
      isNew: true,
      inStock: true,
      storeName: 'LevelPro Equipment',
      storeRating: 4.9,
      storeProducts: '150+',
      specs: {'Range': '60m', 'Weight': '1.2 kg'},
      createdAt: DateTime(2026, 1, 1),
    ),
    ProductModel(
      id: 'sr2',
      providerId: 'expert_dummy',
      name: 'Precision Multimeter',
      category: 'Electrical',
      description: 'High-accuracy digital multimeter for professionals.',
      imageAsset: 'assets/images/tester.png',
      price: 185.50,
      originalPrice: 220.00,
      rating: 4.6,
      reviewCount: 134,
      isNew: false,
      inStock: true,
      storeName: 'ElectroMax Tools',
      storeRating: 4.7,
      storeProducts: '300+',
      specs: {'Display': '6000-Count', 'Weight': '0.4 kg'},
      createdAt: DateTime(2026, 1, 1),
    ),
  ];

  // ─── Wishlist Items ────────────────────────────────────────────
  static final List<WishlistItemModel> wishlistItems = [
    WishlistItemModel(
      id: 'w1',
      name: 'Titan 4500 Laser Level',
      description:
          'Self-leveling 360-degree cross line laser with magnetic pivoting base and green beam.',
      imageAsset: 'assets/images/laser.png',
      price: 289.00,
    ),
    WishlistItemModel(
      id: 'w2',
      name: 'Industrial Series 8" Bench Grinder',
      description:
          'Precision balanced motor for smooth operation and long life. Includes adjustable tool rests and magnifying eye shields for high-precision workshop tasks.',
      imageAsset: 'assets/images/grinder.png',
      price: 412.50,
    ),
  ];

  // ─── Cart Items ────────────────────────────────────────────────
  static final List<CartItemModel> cartItems = [
    CartItemModel(
      id: 'c1',
      name: 'Precision Pro X1 Laptop',
      variant: 'Silver / 1TB SSD / 32GB RAM',
      imageAsset: 'assets/images/laptop.png',
      price: 1899.00,
      quantity: 1,
    ),
    CartItemModel(
      id: 'c2',
      name: 'ErgoPro Graphite Series',
      variant: 'Charcoal / Premium Mesh',
      imageAsset: 'assets/images/chair.png',
      price: 649.00,
      quantity: 1,
    ),
    CartItemModel(
      id: 'c3',
      name: 'Aura Studio Headphones',
      variant: 'Matte Black / ANC Enabled',
      imageAsset: 'assets/images/headphones.png',
      price: 299.00,
      quantity: 1,
    ),
  ];

  // ─── Checkout Order Items ──────────────────────────────────────
  static final List<CartItemModel> checkoutItems = [
    CartItemModel(
      id: 'ch1',
      name: 'EliteBook Pro 16"',
      variant: 'Space Grey / 1TB',
      imageAsset: 'assets/images/laptop.png',
      price: 1499.00,
      quantity: 1,
    ),
    CartItemModel(
      id: 'ch2',
      name: 'Precision Audio ANC',
      variant: 'Matte Black',
      imageAsset: 'assets/images/headphones.png',
      price: 299.00,
      quantity: 1,
    ),
  ];
}
