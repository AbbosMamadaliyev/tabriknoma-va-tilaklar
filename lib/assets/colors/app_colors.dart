import 'dart:ui';

/// Design tokens.
///
/// Rules (keep them — they are what makes the app look like one product):
/// * One accent: [accent] (brand green from the launcher icon). It is spent on
///   the primary action, the active state and nothing else.
/// * One grey family: warm greys ([ink] → [line] → [fill]).
/// * Surfaces are white; grouped content sits on [fill].
class AppColors {
  AppColors._();

  // ── Brand ────────────────────────────────────────────────────────────────
  /// Brand green, slightly deepened from the icon (#378842) for AA contrast.
  static const accent = Color(0xff2F7F3C);
  static const accentPressed = Color(0xff256A31);
  static const accentSoft = Color(0xffEAF4EC);

  /// Saffron of the logo mark. Logo only — never a UI accent.
  static const brandSaffron = Color(0xffF4A11A);

  // ── Warm neutrals ────────────────────────────────────────────────────────
  static const ink = Color(0xff1C1B18);
  static const inkSecondary = Color(0xff6B6862);
  static const inkTertiary = Color(0xff9E9B93);
  static const line = Color(0xffE9E7E1);
  static const fill = Color(0xffF5F4F0);
  static const fillPressed = Color(0xffECEAE4);
  static const surface = Color(0xffFFFFFF);

  // ── Semantic ─────────────────────────────────────────────────────────────
  static const danger = Color(0xffC4362B);

  // ── Legacy names (still referenced by older shared widgets) ──────────────
  static const white = surface;
  static const black = Color(0xff000000);
  static const orange = Color(0xffFF831B);
  static const orange50 = Color(0x80FF831B);
  static const red = danger;
  static const blue = accent;
  static const green = accent;
  static const yellow = Color(0xffFFE81B);
  static const grey1 = inkTertiary;
  static const grey2 = Color(0xffB5B2AA);
  static const grey3 = line;
  static const grey4 = fill;
  static const grey5 = Color(0xffF9F8F5);
  static const navBarColor = accentSoft;
}
