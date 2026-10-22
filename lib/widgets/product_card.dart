import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final bool initiallyFavorite;
  final ValueChanged<bool>? onFavoriteChanged;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.initiallyFavorite = false,
    this.onFavoriteChanged,
    this.onTap,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  late bool isFavorite;
  bool isPressed = false;

  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    isFavorite = widget.initiallyFavorite;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant ProductCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initiallyFavorite != widget.initiallyFavorite) {
      isFavorite = widget.initiallyFavorite;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    widget.onFavoriteChanged?.call(isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.product.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) async {
        _toggleFavorite();
        return false;
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: Colors.pink.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(
          Icons.favorite,
          color: Colors.pink,
          size: 30,
        ),
      ),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            onTap: widget.onTap,
            onTapDown: (_) => _controller.forward(),
            onTapUp: (_) => _controller.reverse(),
            onTapCancel: () => _controller.reverse(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 10,
                      child: Image.network(
                        widget.product.imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;

                          return Container(
                            color: Colors.grey.shade200,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade200,
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.image_not_supported_outlined,
                              size: 42,
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Material(
                        color: Colors.white.withAlpha(230),
                        shape: const CircleBorder(),
                        child: IconButton(
                          tooltip: isFavorite
                              ? 'Убрать из избранного'
                              : 'Добавить в избранное',
                          onPressed: _toggleFavorite,
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isFavorite
                                ? Colors.pink
                                : Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.product.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '${widget.product.price.toStringAsFixed(2)} грн',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
