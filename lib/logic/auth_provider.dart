import 'package:flutter/material.dart';
import '../data/models/user_model.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;

  // Demo login allowing immediate testing of all 4 roles
  void loginAsRole(UserRole role) {
    switch (role) {
      case UserRole.teacher:
        _currentUser = UserModel(
          id: 'T-101',
          name: 'Anjali Menon',
          email: 'anjali.teacher@mot.com',
          role: UserRole.teacher,
        );
        break;
      case UserRole.parent:
        _currentUser = UserModel(
          id: 'P-201',
          name: 'Rajesh Sharma',
          email: 'rajesh.parent@mot.com',
          role: UserRole.parent,
          linkedChildIds: ['S-01', 'S-02'], // Two siblings linked
        );
        break;
      case UserRole.admin:
        _currentUser = UserModel(
          id: 'A-301',
          name: 'Meera Nair (Admin)',
          email: 'admin@mot.com',
          role: UserRole.admin,
        );
        break;
      case UserRole.superAdmin:
        _currentUser = UserModel(
          id: 'SA-001',
          name: 'Super Admin MOT',
          email: 'superadmin@mot.com',
          role: UserRole.superAdmin,
        );
        break;
    }
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
