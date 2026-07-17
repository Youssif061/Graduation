import 'package:flutter/material.dart';

class CategoryModel {
  final String title;
  final IconData icon;

  CategoryModel({
    required this.title,
    required this.icon,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      title: map['name'] ?? '',
      icon: _getIcon(map['icon'] ?? ''),
    );
  }

  static IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'plumbing':
        return Icons.plumbing;

      case 'electrical':
        return Icons.electrical_services;

      case 'hvac':
        return Icons.ac_unit;

      case 'cleaning':
        return Icons.cleaning_services;

      default:
        return Icons.home_repair_service;
    }
  }
}