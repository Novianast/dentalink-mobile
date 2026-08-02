import 'package:flutter/material.dart';
import '../constants/colors.dart';

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
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(26),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SizedBox(
            height: kBottomNavigationBarHeight + 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(items.length, (index) {
                final item = items[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: NavItem(
                    icon: item.icon,
                    label: item.label,
                    isSelected: index == currentIndex,
                    onTap: () => onTap(index),
                    customIcon: item.customIcon,
                  ),
                );
              }),
            ),
          ),
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
    final Color iconColor = isSelected ? Colors.white : Colors.black;

    final Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        (customIcon != null)
            ? SizedBox(
                width: 18,
                height: 18,
                child: Center(
                  child: ImageIcon(
                    customIcon!.image,
                    color: iconColor,
                    size: 18,
                  ),
                ),
              )
            : Icon(icon, color: iconColor, size: 22),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 11,
            height: 1.1,
          ),
          maxLines: 1,
          overflow: TextOverflow.clip,
          textAlign: TextAlign.center,
        ),
      ],
    );

    return GestureDetector(
      onTap: onTap,
      child: isSelected
          ? Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  colors: [AppColors.darkBlue, AppColors.lightBlue],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    (customIcon != null)
                        ? ImageIcon(
                            customIcon!.image,
                            color: Colors.white,
                            size: 16,
                          )
                        : Icon(icon, color: Colors.white, size: 20),
                    const SizedBox(height: 2),
                    Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        height: 1.1,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 6.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.transparent,
              ),
              child: content,
            ),
    );
  }
}
