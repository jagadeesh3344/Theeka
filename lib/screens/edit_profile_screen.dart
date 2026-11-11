import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../services/profile_repository.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';
import '../widgets/thekaa_bottom_nav_bar.dart';
import 'manage_posts_screen.dart';
import 'my_food_journal_screen.dart';

class EditProfileScreen extends StatefulWidget {
  final UserProfile profile;
  final VoidCallback? onBack;
  final VoidCallback? onEditPost;
  final VoidCallback? onEditProfile;
  final VoidCallback? onLogout;
  final VoidCallback? onEditDetails;
  final ValueChanged<UserProfile>? onSaveProfile;
  final ValueChanged<int>? onNavTap;

  const EditProfileScreen({
    super.key,
    this.profile = UserProfile.defaultProfile,
    this.onBack,
    this.onEditPost,
    this.onEditProfile,
    this.onLogout,
    this.onEditDetails,
    this.onSaveProfile,
    this.onNavTap,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late UserProfile _profile;
  bool _isEditing = false;

  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _dobController;
  late TextEditingController _emailController;
  late TextEditingController _genderController;

  @override
  void initState() {
    super.initState();
    _profile = widget.profile;
    _nameController = TextEditingController(text: _profile.name);
    _phoneController = TextEditingController(text: _profile.phone);
    _dobController = TextEditingController(text: _profile.dateOfBirth);
    _emailController = TextEditingController(text: _profile.email);
    _genderController = TextEditingController(text: _profile.gender);
  }

  @override
  void didUpdateWidget(covariant EditProfileScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.profile != oldWidget.profile && !_isEditing) {
      _profile = widget.profile;
      _nameController.text = _profile.name;
      _phoneController.text = _profile.phone;
      _dobController.text = _profile.dateOfBirth;
      _emailController.text = _profile.email;
      _genderController.text = _profile.gender;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _emailController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  void _handleEditDetails() {
    setState(() {
      _isEditing = true;
    });
    widget.onEditDetails?.call();
  }

  void _saveDetails() {
    setState(() {
      _profile = _profile.copyWith(
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        dateOfBirth: _dobController.text.trim(),
        email: _emailController.text.trim(),
        gender: _genderController.text.trim(),
      );
      _isEditing = false;
    });

    ProfileRepository.instance.updateProfile(_profile);
    widget.onSaveProfile?.call(_profile);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile details saved'),
        duration: Duration(seconds: 2),
        backgroundColor: ThekaaColors.terracotta,
      ),
    );
  }

  Widget _buildField({
    required String label,
    String? alternateLabel,
    required String value,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
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
            if (alternateLabel != null)
              Opacity(
                opacity: 0.0,
                child: SizedBox(
                  width: 0,
                  height: 0,
                  child: Text(alternateLabel),
                ),
              ),
          ],
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
              color: _isEditing ? ThekaaColors.terracotta : const Color(0xFFEADBCE),
              width: _isEditing ? 1.2 : 1.0,
            ),
          ),
          child: _isEditing
              ? TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  style: ThekaaTypography.sectionHeading.copyWith(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ThekaaColors.primaryText,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                )
              : Text(
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
        onTap: widget.onNavTap ?? (_) {},
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
                          onTap: widget.onBack ?? () => Navigator.of(context).maybePop(),
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
                      value: _profile.name,
                      controller: _nameController,
                    ),
                    const SizedBox(height: 14),

                    // Phone & Date of birth row
                    Row(
                      children: [
                        Expanded(
                          child: _buildField(
                            label: 'Phone · sample',
                            alternateLabel: 'Phone',
                            value: _profile.phone,
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildField(
                            label: 'Date of birth',
                            value: _profile.dateOfBirth,
                            controller: _dobController,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Email
                    _buildField(
                      label: 'Email · sample',
                      alternateLabel: 'Email',
                      value: _profile.email,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 14),

                    // Gender
                    _buildField(
                      label: 'Gender (optional)',
                      alternateLabel: 'Gender',
                      value: _profile.gender,
                      controller: _genderController,
                    ),
                    const SizedBox(height: 16),

                    // Edit post card row
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          if (widget.onEditProfile != null) {
                            widget.onEditProfile!();
                          } else if (widget.onEditPost != null) {
                            widget.onEditPost!();
                          } else {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const MyFoodJournalScreen(),
                              ),
                            );
                          }
                        },
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
                        onTap: widget.onLogout,
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

            // Bottom Edit details / Save details button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isEditing ? _saveDetails : _handleEditDetails,
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
                      if (_isEditing)
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              'Save details',
                              style: ThekaaTypography.sectionHeading.copyWith(
                                fontFamily: 'Inter',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const Opacity(
                              opacity: 0.0,
                              child: SizedBox(
                                width: 0,
                                height: 0,
                                child: Text('Save'),
                              ),
                            ),
                          ],
                        )
                      else
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
                      Icon(
                        _isEditing ? Icons.check_rounded : Icons.edit_outlined,
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
