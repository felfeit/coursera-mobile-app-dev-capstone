import 'package:coursera_mobile_app_dev_capstone/features/auth/domain/model/country_model.dart';
import 'package:flutter/material.dart';

import '../data/country_service.dart';

class CountryProvider extends ChangeNotifier {
  final CountryService _service = CountryService();

  List<CountryModel> _countries = [];
  bool _isLoading = false;
  String? _error;

  List<CountryModel> get countries => _countries;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchCountries() async {
    if (_countries.isNotEmpty) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _countries = await _service.fetchCountries();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
