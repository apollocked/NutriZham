import 'package:flutter/material.dart';
import 'package:nutrizham/presentation/widgets/common/nav_item.dart';

class AnimatedBottomNav extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<AnimatedNavItem> items;

  const AnimatedBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.items,
  });

  @override
  State<AnimatedBottomNav> createState() => _AnimatedBottomNavState();
}

class _AnimatedBottomNavState extends State<AnimatedBottomNav>
    with TickerProviderStateMixin {
  late AnimationController _pillController;
  late Animation<double> _pillAnimation;
  int _previousIndex = 0;

  @override
  void initState() {
    super.initState();
    _pillController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _pillAnimation = CurvedAnimation(
      parent: _pillController,
      curve: Curves.easeOutBack,
    );
    _previousIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(AnimatedBottomNav oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _previousIndex = oldWidget.selectedIndex;
      _pillController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _pillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = widget.items.length;

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      height: 64,
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? const Color(0xFF1E293B)
            : Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = constraints.maxWidth / count;
          return Stack(
            children: [
              AnimatedBuilder(
                animation: _pillAnimation,
                builder: (context, _) {
                  final lerp = _pillAnimation.value;
                  final from = _previousIndex * itemWidth + itemWidth * 0.15;
                  final to =
                      widget.selectedIndex * itemWidth + itemWidth * 0.15;
                  final pillOffset = from + (to - from) * lerp;
                  final pillWidth = itemWidth * 0.7;
                  final isRtl = Directionality.of(context) == TextDirection.rtl;
                  return Positioned(
                    left: isRtl ? null : pillOffset,
                    right: isRtl ? pillOffset : null,
                    top: 8,
                    bottom: 8,
                    width: pillWidth,
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  );
                },
              ),
              Row(
                children: List.generate(count, (i) {
                  final isSelected = widget.selectedIndex == i;
                  return Expanded(
                    child: NavItem(
                      item: widget.items[i],
                      isSelected: isSelected,
                      onTap: () => widget.onDestinationSelected(i),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
