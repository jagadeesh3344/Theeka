import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'thekaa_colors.dart';

/// Typography definitions for THEKAA editorial styling
class ThekaaTypography {
  ThekaaTypography._();

  /// Eyebrow text: "01 / FOOD DISCOVERY & ORDERING"
  static TextStyle get eyebrow => GoogleFonts.inter(
        fontSize: 10.5,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
        color: ThekaaColors.terracotta,
      );

  /// Brand Title: "THEKAA"
  static TextStyle get brandTitle => GoogleFonts.playfairDisplay(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        letterSpacing: 2.4,
        color: ThekaaColors.primaryText,
      );

  /// Brand Tagline: "KHAANA. SAMJH KE."
  static TextStyle get brandTagline => GoogleFonts.inter(
        fontSize: 10.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
        color: ThekaaColors.terracotta,
      );

  /// Location label: "Gachibowli"
  static TextStyle get locationText => GoogleFonts.inter(
        fontSize: 13.5,
        fontWeight: FontWeight.w600,
        color: ThekaaColors.primaryText,
      );

  /// Search placeholder
  static TextStyle get searchPlaceholder => GoogleFonts.inter(
        fontSize: 13.5,
        fontWeight: FontWeight.w400,
        color: ThekaaColors.secondaryText,
      );

  /// Search input text
  static TextStyle get searchInput => GoogleFonts.inter(
        fontSize: 13.5,
        fontWeight: FontWeight.w500,
        color: ThekaaColors.primaryText,
      );

  /// Hero Heading: "Aaj kya mangoge\nbhaiyya?"
  static TextStyle get heroHeading => GoogleFonts.playfairDisplay(
        fontSize: 27,
        fontWeight: FontWeight.w700,
        height: 1.15,
        color: ThekaaColors.primaryText,
      );

  /// Hero Subtitle: "Hyderabad, one plate at a time."
  static TextStyle get heroSubtitle => GoogleFonts.caveat(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.italic,
        color: ThekaaColors.terracotta,
      );

  /// Section Headings: "Today's Food Map", "Handpicked for you", "Explore Hyderabad", "Nearby hidden gems"
  static TextStyle get sectionHeading => GoogleFonts.playfairDisplay(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: ThekaaColors.primaryText,
      );

  /// Sub-heading / Filter label
  static TextStyle get filterChipText => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: ThekaaColors.primaryText,
      );

  /// Explore small location label: "Around Gachibowli"
  static TextStyle get exploreLocationLabel => GoogleFonts.inter(
        fontSize: 12.5,
        fontWeight: FontWeight.w500,
        color: ThekaaColors.secondaryText,
      );

  /// Section Action: "Explore map ↗", "See all"
  static TextStyle get sectionAction => GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: ThekaaColors.terracotta,
      );

  /// Restaurant Card Name: "Shadab Biryani"
  static TextStyle get restaurantName => GoogleFonts.playfairDisplay(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: ThekaaColors.primaryText,
      );

  /// Restaurant Rating: "4.8"
  static TextStyle get ratingText => GoogleFonts.inter(
        fontSize: 13.5,
        fontWeight: FontWeight.w700,
        color: ThekaaColors.primaryText,
      );

  /// Delivery info: "24–28 min · ₹30 delivery"
  static TextStyle get deliveryInfo => GoogleFonts.inter(
        fontSize: 12.5,
        fontWeight: FontWeight.w400,
        color: ThekaaColors.secondaryText,
      );

  /// Verification badge text: "THEKAA verified"
  static TextStyle get verifiedText => GoogleFonts.inter(
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
        color: ThekaaColors.verifiedGreen,
      );

  /// Navigation item active label
  static TextStyle get navLabelActive => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: ThekaaColors.terracotta,
      );

  /// Navigation item inactive label
  static TextStyle get navLabelInactive => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: ThekaaColors.secondaryText,
      );

  /// Navigation center DABBA label
  static TextStyle get navLabelDabba => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
        color: ThekaaColors.primaryText,
      );
}

