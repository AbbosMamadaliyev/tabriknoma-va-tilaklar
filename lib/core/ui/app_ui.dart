import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';
import 'package:tabriklar/assets/themes/theme.dart';
import 'package:tabriklar/features/components/google_ads_widget.dart';

/// Shared building blocks of the redesigned UI.
/// Every screen is assembled from these so spacing, radii and color stay locked.

// ─────────────────────────────────────────────────────────────────────────────
// Brand
// ─────────────────────────────────────────────────────────────────────────────

class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.size = 40});

  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size * 0.3),
      child: Image.asset(
        'assets/images/brand_mark.png',
        width: size,
        height: size,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.medium,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Headers & labels
// ─────────────────────────────────────────────────────────────────────────────

/// Large title used at the top of each tab root.
class ScreenHeader extends StatelessWidget {
  const ScreenHeader({super.key, required this.title, this.subtitle, this.leading});

  final String title;
  final String? subtitle;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpace.gutter, AppSpace.l, AppSpace.gutter, AppSpace.xl),
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: AppSpace.m),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppText.display),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(subtitle!, style: AppText.caption),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpace.gutter + 4, 0, AppSpace.gutter, AppSpace.s),
      child: Text(text, style: AppText.section),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Icon tile
// ─────────────────────────────────────────────────────────────────────────────

class IconTile extends StatelessWidget {
  const IconTile({
    super.key,
    required this.icon,
    this.size = 44,
    this.iconSize = 22,
    this.filled = false,
  });

  final IconData icon;
  final double size;
  final double iconSize;

  /// Filled = accent background with white glyph (used once per screen at most).
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: filled ? AppColors.accent : AppColors.accentSoft,
        borderRadius: BorderRadius.circular(AppRadius.tile),
      ),
      child: Icon(icon, size: iconSize, color: filled ? Colors.white : AppColors.accent),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Grouped list
// ─────────────────────────────────────────────────────────────────────────────

/// Rounded group on [AppColors.fill] with hairline dividers between rows.
class AppGroup extends StatelessWidget {
  const AppGroup({super.key, required this.children, this.dividerIndent = 16});

  final List<Widget> children;
  final double dividerIndent;

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      items.add(children[i]);
      if (i != children.length - 1) {
        items.add(Divider(height: 1, indent: dividerIndent, endIndent: 0, color: AppColors.line));
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.l),
      child: Material(
        color: AppColors.fill,
        borderRadius: BorderRadius.circular(AppRadius.card),
        clipBehavior: Clip.antiAlias,
        child: Column(mainAxisSize: MainAxisSize.min, children: items),
      ),
    );
  }
}

class AppRow extends StatelessWidget {
  const AppRow({
    super.key,
    required this.title,
    this.leading,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.showChevron = true,
    this.titleStyle,
    this.minHeight = 56,
  });

  final String title;
  final Widget? leading;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showChevron;
  final TextStyle? titleStyle;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.l, vertical: AppSpace.m),
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: 14),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title, style: titleStyle ?? AppText.bodyStrong),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(subtitle!, style: AppText.caption),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: AppSpace.s),
                trailing!,
              ],
              if (showChevron) ...[
                const SizedBox(width: AppSpace.xs),
                const Icon(Icons.chevron_right_rounded, color: AppColors.inkTertiary, size: 22),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Plain leading icon for settings-type rows (chrome, not content).
class RowIcon extends StatelessWidget {
  const RowIcon(this.icon, {super.key});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      child: Icon(icon, size: 24, color: AppColors.inkSecondary),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Buttons
// ─────────────────────────────────────────────────────────────────────────────

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.height = 52,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool loading;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: FilledButton(
        onPressed: loading ? null : onPressed,
        style: FilledButton.styleFrom(
          minimumSize: Size(64, height),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          disabledBackgroundColor: AppColors.accent.withValues(alpha: 0.7),
          disabledForegroundColor: Colors.white,
        ),
        child: loading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20),
                    const SizedBox(width: AppSpace.s),
                  ],
                  Flexible(child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis)),
                ],
              ),
      ),
    );
  }
}

/// Neutral pill (fill background) — secondary action next to a [PrimaryButton].
class TonalButton extends StatelessWidget {
  const TonalButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.height = 52,
    this.dense = false,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final double height;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: AppColors.fill,
          foregroundColor: AppColors.ink,
          minimumSize: Size(48, height),
          padding: EdgeInsets.symmetric(horizontal: dense ? 14 : 20),
          textStyle: AppText.button.copyWith(fontSize: dense ? 14 : 16),
          shape: const StadiumBorder(),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: dense ? 18 : 20),
              const SizedBox(width: 6),
            ],
            Flexible(child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis)),
          ],
        ),
      ),
    );
  }
}

/// Icon above a short label — secondary actions in a bottom action bar.
class StackedActionButton extends StatelessWidget {
  const StackedActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.active = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.accent : AppColors.ink;
    return Semantics(
      button: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.tile),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 72, minHeight: 52),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 24, color: color),
                const SizedBox(height: 4),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.label.copyWith(color: color, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Cards
// ─────────────────────────────────────────────────────────────────────────────

/// A greeting preview in a list: first meaningful lines, optional saved mark.
class GreetingPreviewCard extends StatelessWidget {
  const GreetingPreviewCard({
    super.key,
    required this.content,
    required this.onTap,
    this.saved = false,
  });

  final String content;
  final VoidCallback onTap;
  final bool saved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.l),
      child: Material(
        color: AppColors.fill,
        borderRadius: BorderRadius.circular(AppRadius.card),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(AppSpace.l, 14, AppSpace.m, 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    greetingPreview(content),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.preview,
                  ),
                ),
                const SizedBox(width: AppSpace.s),
                Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: saved
                      ? const Icon(Icons.bookmark_rounded, size: 20, color: AppColors.accent)
                      : const Icon(Icons.chevron_right_rounded, size: 22, color: AppColors.inkTertiary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// States
// ─────────────────────────────────────────────────────────────────────────────

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({super.key, required this.icon, required this.title, this.message});

  final IconData icon;
  final String title;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: const BoxDecoration(color: AppColors.fill, shape: BoxShape.circle),
            child: Icon(icon, size: 32, color: AppColors.inkTertiary),
          ),
          const SizedBox(height: AppSpace.l),
          Text(title, style: AppText.headline, textAlign: TextAlign.center),
          if (message != null) ...[
            const SizedBox(height: 6),
            Text(message!, style: AppText.caption.copyWith(fontSize: 14), textAlign: TextAlign.center),
          ],
        ],
      ),
    );
  }
}

/// Shimmering placeholder that matches the final layout's shape.
class SkeletonBox extends StatelessWidget {
  const SkeletonBox({super.key, this.height = 88, this.radius = AppRadius.card, this.width});

  final double height;
  final double? width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.fill,
      highlightColor: const Color(0xffFBFAF8),
      child: Container(
        height: height,
        width: width ?? double.infinity,
        decoration: BoxDecoration(color: AppColors.fill, borderRadius: BorderRadius.circular(radius)),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Ads
// ─────────────────────────────────────────────────────────────────────────────

/// Banner pinned to the bottom of a screen (never overlapping content).
class BottomBannerBar extends StatelessWidget {
  const BottomBannerBar({super.key, required this.adUnitId});

  final String adUnitId;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.surface,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: Center(child: GoogleAdsWidget(adUnitId: adUnitId)),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Feedback
// ─────────────────────────────────────────────────────────────────────────────

void showAppSnack(BuildContext context, String message, {bool error = false, IconData? icon}) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 2200),
      backgroundColor: error ? AppColors.danger : AppColors.ink,
      content: Row(
        children: [
          Icon(icon ?? (error ? Icons.error_outline_rounded : Icons.check_circle_rounded),
              color: Colors.white, size: 20),
          const SizedBox(width: AppSpace.m),
          Expanded(child: Text(message)),
        ],
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Text helpers
// ─────────────────────────────────────────────────────────────────────────────

final _letters = RegExp(r'[0-9A-Za-zА-Яа-яЁёЎўҚқҒғҲҳ]');

/// First lines of a greeting that actually contain words — many greetings start
/// with a decorative row of emoji, which makes a useless preview.
String greetingPreview(String content) {
  final lines = content.split('\n').map((l) => l.trim()).where((l) => l.isNotEmpty).toList();
  final meaningful = lines.where(_letters.hasMatch).toList();
  final source = meaningful.isEmpty ? lines : meaningful;
  return source.take(3).join('\n');
}

/// Lower-cases and unifies the many apostrophes used in Uzbek text so that
/// "tug'ilgan", "tugʻilgan" and "tug‘ilgan" all match each other.
String normalizeForSearch(String s) {
  return s.toLowerCase().replaceAll(RegExp(r"[ʻʼ‘’`´']"), "'");
}
