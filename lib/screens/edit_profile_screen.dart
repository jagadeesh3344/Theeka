import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';

class EditProfileScreen extends StatelessWidget {
  final UserProfile profile;
  final VoidCallback? onBack;
  final VoidCallback? onEditPost;
  final VoidCallback? onLogout;
  final VoidCallback? onEditDetails;
  final ValueChanged<int>? onNavTap;

  const EditProfileScreen({
    super.key,
    this.profile = UserProfile.defaultProfile,
    this.onBack,
    this.onEditPost,
    this.onLogout,
    this.onEditDetails,
    this.onNavTap,
  });

  Widget _buildField({
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: ThekaaTypography.deliveryInfo.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF6B4E38),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: const Color(0xFFFFFDF8),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFFEADBCE),
              width: 1.0,
            ),
          ),
          child: Text(
            value,
            style: ThekaaTypography.sectionHeading.copyWith(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ThekaaColors.primaryText,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThekaaColors.mainBackground,
      bottomNavigationBar: ThekaaBottomNavBar(
        currentIndex: 4,
        onTap: onNavTap ?? (_) {},
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // Top navigation row with back arrow and title
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: onBack ?? () => Navigator.of(context).maybePop(),
                          borderRadius: BorderRadius.circular(20),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 18,
                              color: ThekaaColors.terracotta,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'The person behind the plate',
                            style: ThekaaTypography.sectionHeading.copyWith(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: ThekaaColors.primaryText,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Description
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Text(
                        'Keep your personal details up to date.',
                        style: ThekaaTypography.deliveryInfo.copyWith(
                          fontSize: 12,
                          color: ThekaaColors.secondaryText,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Full name
                    _buildField(
                      label: 'Full name',
                      value: profile.name,
                    ),
                    const SizedBox(height: 14),

                    // Phone & Date of birth row
                    Row(
                      children: [
                        Expanded(
                          child: _buildField(
                            label: 'Phone · sample',
                            value: profile.phone,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildField(
                            label: 'Date of birth',
                            value: profile.dateOfBirth,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Email
                    _buildField(
                      label: 'Email · sample',
                      value: profile.email,
                    ),
                    const SizedBox(height: 14),

                    // Gender
                    _buildField(
                      label: 'Gender (optional)',
                      value: profile.gender,
                    ),
                    const SizedBox(height: 16),

                    // Edit post card row
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onEditPost,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFAF6EE),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFFEADBCE),
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF3ECE0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.edit_outlined,
                                    size: 18,
                                    color: ThekaaColors.terracotta,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  'Edit post',
                                  style: ThekaaTypography.sectionHeading.copyWith(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: ThekaaColors.primaryText,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right,
                                size: 18,
                                color: Color(0xFFB8A99B),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Log out card row
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onLogout,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFAF6EE),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFFEADBCE),
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF3ECE0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.logout_rounded,
                                    size: 18,
                                    color: ThekaaColors.terracotta,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Log out',
                                      style: ThekaaTypography.sectionHeading.copyWith(
                                        fontFamily: 'Inter',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: ThekaaColors.primaryText,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'You can sign back in anytime',
                                      style: ThekaaTypography.deliveryInfo.copyWith(
                                        fontSize: 11.5,
                                        color: ThekaaColors.secondaryText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right,
                                size: 18,
                                color: Color(0xFFB8A99B),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Privacy note
                    Center(
                      child: Text(
                        'Your contact information is private, not part of your public food journal.',
                        textAlign: TextAlign.center,
                        style: ThekaaTypography.deliveryInfo.copyWith(
                          fontSize: 11,
                          color: ThekaaColors.secondaryText,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Bottom Edit details button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: onEditDetails,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThekaaColors.terracotta,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Edit details',
                        style: ThekaaTypography.sectionHeading.copyWith(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.edit_outlined,
                        size: 18,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
