import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';
import 'package:tabriklar/assets/themes/theme.dart';
import 'package:tabriklar/features/common/presentation/bloc/version/version_bloc.dart';
import 'package:tabriklar/features/home_page/widgets/ramadan_time_screen.dart';
import 'package:tabriklar/utils/my_functions.dart';

/// Today's suhoor / iftar times. Visible only while remote config says it is
/// Ramadan (`is_ramadan_month`).
class RamadanTimeWidget extends StatelessWidget {
  const RamadanTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isRamadan = context.watch<VersionBloc>().state.isRamadanMonth;
    if (!isRamadan) return const SizedBox.shrink();

    final date = MyFunctions.formatDateFromApi(
      DateTime.now().toString(),
      format: 'd MMMM',
      locale: context.locale.languageCode,
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpace.l, AppSpace.m, AppSpace.l, 0),
      child: Material(
        color: AppColors.fill,
        borderRadius: BorderRadius.circular(AppRadius.card),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const RamadanTimeScreen()));
          },
          child: Padding(
            padding: const EdgeInsets.all(AppSpace.l),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.nightlight_round, color: AppColors.accent, size: 20),
                    const SizedBox(width: AppSpace.s),
                    const Expanded(
                      child: Text('Ramazon taqvimi', style: AppText.headline),
                    ),
                    Text(date, style: AppText.caption),
                    const SizedBox(width: 2),
                    const Icon(Icons.chevron_right_rounded, color: AppColors.inkTertiary, size: 22),
                  ],
                ),
                const SizedBox(height: AppSpace.m),
                Row(
                  children: [
                    Expanded(
                      child: _TimeTile(
                        icon: Icons.wb_twilight_rounded,
                        label: 'Saharlik',
                        time: MyFunctions.suhoorTime(),
                      ),
                    ),
                    const SizedBox(width: AppSpace.s),
                    Expanded(
                      child: _TimeTile(
                        icon: Icons.nights_stay_rounded,
                        label: 'Iftorlik',
                        time: MyFunctions.iftarTime(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpace.s),
                const Text('Toshkent vaqti bilan', style: AppText.caption),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TimeTile extends StatelessWidget {
  const _TimeTile({required this.icon, required this.label, required this.time});

  final IconData icon;
  final String label;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.m, vertical: AppSpace.m),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.tile),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.accent, size: 22),
          const SizedBox(width: AppSpace.s + 2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppText.caption),
                Text(
                  time,
                  style: AppText.title.copyWith(
                    fontSize: 19,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
