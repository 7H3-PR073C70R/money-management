import 'package:money_management/constants/app_string.dart';
import 'package:money_management/constants/enums.dart';
import 'package:stacked/stacked.dart';

class ThemeViewModel extends BaseViewModel {
  int _selectedIndex = 0;
  Themes _selectedTheme = Themes.light;
  final List<Themes> _themes = [Themes.light, Themes.dark];
  final List<String> _themeText = [lightText, darkText];
  
  int get selectedIndex => _selectedIndex;
  Themes get selectedThem => _selectedTheme;
  List<Themes> get themes => _themes;
  List<String> get themeText => _themeText;

  void setSelectedIndex(int index){
    _selectedIndex = index;
    notifyListeners();
  }

  void setSelectedTheme(Themes value) {
    _selectedTheme = value;
    _selectedIndex = _themes.indexOf(value);
    notifyListeners();
  }
}