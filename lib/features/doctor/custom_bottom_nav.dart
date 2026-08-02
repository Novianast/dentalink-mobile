import 'package:flutter/material.dart';

class AppColors {
  static const Color darkBlue = Color(0xFF2158A1);
  static const Color lightBlue = Color(0xFF4DAFFF);
  static const Color accentBlue = Color(0xFF3B82F6);
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<CustomBottomNavigationBarItem> items;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 90.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final item = items[index];
            return NavItem(
              icon: item.icon,
              label: item.label,
              isSelected: index == currentIndex,
              onTap: () => onTap(index),
              customIcon: item.customIcon,
            );
          }),
        ),
      ),
    );
  }
}

class CustomBottomNavigationBarItem {
  final IconData icon;
  final String label;
  final Image? customIcon;

  CustomBottomNavigationBarItem({
    required this.icon,
    required this.label,
    this.customIcon,
  });
}

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Image? customIcon;

  const NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.customIcon,
  });

  @override
  Widget build(BuildContext context) {
    // Jika item terpilih, tampilkan widget dengan latar belakang gradien.
    if (isSelected) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2158A1), Color(0xFF4DAFFF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 10.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  customIcon != null
                      ? customIcon!
                      : Icon(icon, color: Colors.white, size: 24.0),
                  const SizedBox(height: 4),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Jika item tidak terpilih, tampilkan widget biasa.
    // Jika menggunakan customIcon (icon gigi), gunakan outline version untuk inactive
    Widget displayIcon;
    if (customIcon != null) {
      // Untuk icon gigi, gunakan outline version saat inactive
      displayIcon = Image.asset(
        'assets/navbar/tooth_outline.png',
        width: 24.0,
        height: 24.0,
        color: Colors.black,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.error, color: Colors.black, size: 24.0);
        },
      );
    } else {
      displayIcon = Icon(icon, color: Colors.black, size: 28.0);
    }

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            displayIcon,
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: const TextStyle(color: Colors.black, fontSize: 14.0),
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
