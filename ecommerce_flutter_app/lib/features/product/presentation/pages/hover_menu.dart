import 'package:flutter/material.dart';

class HoverMenu extends StatefulWidget {
  final List<String> menuItems;
  final Function(String)? onItemTap;
  final double? width;
  final Color? backgroundColor;
  final Color? hoverColor;
  final Color? textColor;
  final Color? hoverTextColor;
  final double? fontSize;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;

  const HoverMenu({
    super.key,
    required this.menuItems,
    this.onItemTap,
    this.width = 250,
    this.backgroundColor,
    this.hoverColor,
    this.textColor = Colors.black,
    this.hoverTextColor = Colors.blue,
    this.fontSize = 18,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.borderRadius,
  });

  @override
  State<HoverMenu> createState() => _HoverMenuState();
}

class _HoverMenuState extends State<HoverMenu> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: widget.width,
      padding: widget.padding,
      margin: widget.margin,
      decoration: BoxDecoration(
        color:
            widget.backgroundColor ?? const Color.fromARGB(255, 141, 136, 136),
        borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(widget.menuItems.length, (index) {
          return MouseRegion(
            onEnter: (_) {
              setState(() {
                hoveredIndex = index;
              });
            },
            onExit: (_) {
              setState(() {
                hoveredIndex = null;
              });
            },
            child: InkWell(
              onTap: () {
                if (widget.onItemTap != null) {
                  widget.onItemTap!(widget.menuItems[index]);
                }
              },
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                  color: hoveredIndex == index
                      ? (widget.hoverColor ?? Colors.blue.withOpacity(0.1))
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.menuItems[index],
                  style: TextStyle(
                    fontSize: widget.fontSize,
                    color: hoveredIndex == index
                        ? widget.hoverTextColor
                        : widget.textColor,
                    fontWeight: hoveredIndex == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
