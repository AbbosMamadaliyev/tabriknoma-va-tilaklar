import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';
import 'package:tabriklar/assets/themes/theme.dart';
import 'package:tabriklar/core/ui/app_ui.dart';
import 'package:tabriklar/core/ui/category_visuals.dart';
import 'package:tabriklar/features/home_page/widgets/ramadan_time_widget.dart';
import 'package:tabriklar/generated/locale_keys.g.dart';
import 'package:tabriklar/main_navigation.dart';
import 'package:tabriklar/view_models/categor_model_provider/categor_model_provider.dart';
import 'package:tabriklar/view_models/database/db_service_provider.dart';
import 'package:tabriklar/view_models/db_table_model_provider/db_table_model_provider.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({Key? key}) : super(key: key);

  void _openCategory(BuildContext context, int categoryIndex) {
    // dbTabel bu yerda categoryalar, adashma!!!
    final table = context.read<DbTableModelProvider>().dbTables[categoryIndex];
    context.read<DbServiceProver>().getData(where: table.rowName, tableName: table.tableName);

    Navigator.of(context).pushNamed(MainNavigationNames.congratulations, arguments: {
      'where': table.rowName,
      'tableName': table.tableName,
      'categoryIndex': categoryIndex,
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageCode = context.locale.languageCode;
    final categories = context.watch<CategoryModelProvider>().categories(languageCode);
    final dbTables = context.watch<DbTableModelProvider>().dbTables;
    final now = DateTime.now();
    final suggestion = CategoryVisuals.suggestionFor(now);

    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpace.xxl),
      children: [
        ScreenHeader(
          leading: const BrandMark(size: 44),
          title: LocaleKeys.app_name.tr(),
          subtitle: _formatToday(now, languageCode),
        ),

        if (suggestion != null && suggestion < dbTables.length) ...[
          _TodayCard(
            title: categories[suggestion].category,
            icon: CategoryVisuals.icon(suggestion),
            onTap: () => _openCategory(context, suggestion),
          ),
          const SizedBox(height: AppSpace.m),
        ],

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.l),
          child: Row(
            children: [
              Expanded(
                child: _QuickAction(
                  icon: Icons.bookmark_rounded,
                  label: LocaleKeys.saved.tr(),
                  onTap: () => Navigator.of(context).pushNamed(MainNavigationNames.favourites),
                ),
              ),
              const SizedBox(width: AppSpace.m),
              Expanded(
                child: _QuickAction(
                  icon: Icons.edit_rounded,
                  label: LocaleKeys.i_write.tr(),
                  onTap: () => Navigator.of(context).pushNamed(MainNavigationNames.writing),
                ),
              ),
            ],
          ),
        ),

        const RamadanTimeWidget(),

        const SizedBox(height: AppSpace.xxl + 4),
        SectionLabel(LocaleKeys.categories.tr()),
        AppGroup(
          dividerIndent: 74,
          children: [
            for (var categoryIndex = 0; categoryIndex < dbTables.length; categoryIndex++)
              AppRow(
                minHeight: 68,
                leading: IconTile(icon: CategoryVisuals.icon(categoryIndex)),
                title: categories[categoryIndex].category,
                onTap: () => _openCategory(context, categoryIndex),
              ),
          ],
        ),
      ],
    );
  }

  static String _formatToday(DateTime now, String languageCode) {
    final pattern = switch (languageCode) {
      'uz' => 'EEEE, d-MMMM',
      'ru' => 'EEEE, d MMMM',
      _ => 'EEEE, MMMM d',
    };
    try {
      final text = DateFormat(pattern, languageCode).format(now);
      return text.isEmpty ? text : text[0].toUpperCase() + text.substring(1);
    } catch (_) {
      return DateFormat('dd.MM.yyyy').format(now);
    }
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.fill,
      borderRadius: BorderRadius.circular(AppRadius.card),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpace.m),
          child: Row(
            children: [
              IconTile(icon: icon, size: 40, iconSize: 20),
              const SizedBox(width: AppSpace.m),
              Expanded(
                child: Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.bodyStrong.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TodayCard extends StatelessWidget {
  const _TodayCard({required this.title, required this.icon, required this.onTap});

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.l),
      child: Material(
        color: AppColors.accentSoft,
        borderRadius: BorderRadius.circular(AppRadius.card),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpace.l),
            child: Row(
              children: [
                IconTile(icon: icon, filled: true, size: 48, iconSize: 24),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.for_today.tr(),
                        style: AppText.caption.copyWith(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(title, style: AppText.headline),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpace.s),
                const Icon(Icons.arrow_forward_rounded, color: AppColors.accent, size: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
