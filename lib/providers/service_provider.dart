import 'package:flutter/material.dart';
import '../models/service.dart';

class ServiceProvider extends ChangeNotifier {
  List<Service> _services = [];
  String _searchQuery = '';
  String _selectedCategory = 'All';

  List<Service> get services {
    return _searchQuery.isEmpty
        ? _services
            .where((service) =>
                _selectedCategory == 'All' ||
                service.category == _selectedCategory)
            .toList()
        : _services
            .where((service) =>
                (service.title
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase()) ||
                    service.provider
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase())) &&
                (_selectedCategory == 'All' ||
                    service.category == _selectedCategory))
            .toList();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void toggleFavorite(String serviceId) {
    final serviceIndex = _services.indexWhere((s) => s.id == serviceId);
    if (serviceIndex >= 0) {
      _services[serviceIndex] = _services[serviceIndex].copyWith(
        isFavorite: !_services[serviceIndex].isFavorite,
      );
      notifyListeners();
    }
  }

  // Add more methods for CRUD operations
}
