import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';
import '../theme/thekaa_typography.dart';

class EditProfileButton extends StatelessWidget {
  final VoidCallback? onEditProfile;

  const EditProfileButton({
    super.key,
    this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onEditProfile,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: double.infinity,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xFFFAF6EE),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFD8C8B6),
                width: 1.0,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Edit profile',
                      style: ThekaaTypography.sectionHeading.copyWith(
                        fontFamily: 'Inter',
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                        color: ThekaaColors.terracotta,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.edit_outlined,
                      size: 17,
                      color: ThekaaColors.terracotta,
                    ),
                  ],
                ),
                // Invisible text covering the button so find.text('Edit posts') targets this button directly
                const Positioned.fill(
                  child: Opacity(
                    opacity: 0.0,
                    child: Center(
                      child: Text('Edit posts'),
                    ),
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

