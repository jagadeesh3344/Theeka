import 'package:flutter/material.dart';
import '../models/rider.dart';
import '../theme/thekaa_colors.dart';

class RiderProfileCard extends StatelessWidget {
  final Rider rider;
  final VoidCallback? onCall;
  final VoidCallback? onChat;

  const RiderProfileCard({
    super.key,
    required this.rider,
    this.onCall,
    this.onChat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: ThekaaColors.cardBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: ThekaaColors.border,
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          // Top Row: Avatar + Info + Shield
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFF4E8D8),
                ),
                child: ClipOval(
                  child: Image.asset(
                    rider.imagePath,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(
                        Icons.person_rounded,
                        size: 30,
                        color: ThekaaColors.terracotta,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Name + Rating + Role
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rider.name,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                        color: ThekaaColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 16,
                          color: Color(0xFFD49B45),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          rider.formattedRating,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: ThekaaColors.primaryText,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            rider.role,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF8F7D6D),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Security Shield Icon
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFE5EDE2),
                  border: Border.all(
                    color: const Color(0xFF4A6B53).withValues(alpha: 0.25),
                    width: 1.0,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.shield_outlined,
                    size: 17,
                    color: Color(0xFF4A6B53),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Bottom Row: Call and Chat Action Buttons
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  context: context,
                  label: 'Call',
                  icon: Icons.phone_outlined,
                  onTap: onCall ??
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Calling ${rider.name}... (${rider.phoneNumber})'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  context: context,
                  label: 'Chat',
                  icon: Icons.chat_bubble_outline_rounded,
                  onTap: onChat ??
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Opening chat with ${rider.name}...'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 42,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFFFAF3EA),
          foregroundColor: ThekaaColors.terracotta,
          side: const BorderSide(
            color: Color(0xFFDFC8B4),
            width: 1.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.zero,
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: ThekaaColors.terracotta,
              ),
            ),
            const SizedBox(width: 7),
            Icon(
              icon,
              size: 17,
              color: ThekaaColors.terracotta,
            ),
          ],
        ),
      ),
    );
  }
}

