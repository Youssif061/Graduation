import 'package:flutter/material.dart';

void pushScreen(BuildContext context, Widget screen) {
  Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => screen));
}

class AppCard extends StatelessWidget {
  final Widget child;

  final EdgeInsetsGeometry? padding;
  const AppCard({required this.child, this.padding, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.card,
      ),
      child: child,
    );
  }
}

class AppColors {
  static const Color background = Color(0xfff8f9fa);

  static const Color ink = Color(0xff03192e);
  static const Color navy = Color(0xff1a2e44);
  static const Color body = Color(0xff565c66);
  static const Color muted = Color(0xff74777d);
  static const Color softText = Color(0xff8296b0);
  static const Color border = Color(0xfff1f5f9);
  static const Color line = Color(0xff008a45);
  static const Color green = Color(0xff2ecc71);
  static const Color badgeGreen = Color(0xff6bfe9c);
  static const Color successDark = Color(0xff00743a);
  static const Color red = Color(0xffdc2626);
  const AppColors._();
}

class AppHeader extends StatelessWidget {
  final Widget child;

  const AppHeader({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;

    return Container(
      height: topPadding + 64,
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(bottom: BorderSide(color: Color(0xffe2e8f0))),
        boxShadow: [
          BoxShadow(
            color: Color(0x0d000000),
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(top: topPadding, left: 16, right: 16),
        child: SizedBox(height: 64, child: child),
      ),
    );
  }
}

class AppShadows {
  static const List<BoxShadow> card = [
    BoxShadow(color: Color(0x1a1a2e44), blurRadius: 16, offset: Offset(0, 6)),
  ];

  const AppShadows._();
}

class AssetAvatar extends StatelessWidget {
  final double size;

  final String imagePath;
  const AssetAvatar({required this.size, required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        imagePath,
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
}

class AssetSquareImage extends StatelessWidget {
  final double size;

  final String imagePath;
  final double radius;
  const AssetSquareImage({
    required this.size,
    required this.imagePath,
    this.radius = 8,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.asset(
        imagePath,
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  final double size;

  final String initials;
  final bool dark;
  const Avatar({
    required this.size,
    required this.initials,
    this.dark = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: dark
              ? const [Color(0xff0f2337), Color(0xff31546c)]
              : const [Color(0xffd7e7ee), Color(0xff7297a6)],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1a03192e),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          color: dark ? Colors.white : AppColors.navy,
          fontSize: size < 40 ? 12 : 16,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class BookingBottomNav extends StatelessWidget {
  const BookingBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavItem(icon: Icons.home_outlined, label: 'Home'),
          NavItem(icon: Icons.work, label: 'Pros', active: true),
          NavItem(icon: Icons.shopping_bag_outlined, label: 'Products'),
          NavItem(icon: Icons.add_circle_outline, label: 'Request'),
          NavItem(icon: Icons.chat_bubble_outline, label: 'Chats'),
        ],
      ),
    );
  }
}

class BrandTopBar extends StatelessWidget {
  const BrandTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppHeader(
      child: Row(
        children: [
          const AssetAvatar(
            size: 32,
            imagePath: 'assets/images/UserProfile.png',
          ),
          const SizedBox(width: 44),
          const Expanded(
            child: Text(
              'ExpertiseMarket',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.navy,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: AppColors.navy,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}

class CompletedServiceDetailsCard extends StatelessWidget {
  const CompletedServiceDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xffeaf4ff),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: const Text(
              'SERVICE DETAILS',
              style: TextStyle(
                color: AppColors.navy,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: const [
                Row(
                  children: [
                    Expanded(
                      child: DetailColumn(
                        label: 'Service Type',
                        value: 'Emergency Wiring Repair',
                      ),
                    ),
                    DetailColumn(
                      label: 'Booking ID',
                      value: '#EM-82944',
                      align: CrossAxisAlignment.end,
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                InfoTile(
                  icon: Icons.schedule,
                  title: 'Schedule',
                  value: 'Oct 24, 2023 • 1:30 PM - 2:45 PM',
                ),
                SizedBox(height: 16),
                InfoTile(
                  icon: Icons.location_on_outlined,
                  title: 'Address',
                  value: '482 Oakwood Ave, Suite 300,\nMetropolis',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CompletedStep extends StatelessWidget {
  final String label;

  const CompletedStep({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 16,
          backgroundColor: AppColors.successDark,
          child: Icon(Icons.check, size: 16, color: Colors.white),
        ),
        const SizedBox(height: 6),
        FittedBox(
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.successDark,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class CompletedStepper extends StatelessWidget {
  const CompletedStepper({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: CompletedStep(label: 'Confirmed')),
        Expanded(child: StepLine()),
        Expanded(child: CompletedStep(label: 'In Transit')),
        Expanded(child: StepLine()),
        Expanded(child: CompletedStep(label: 'Completed')),
      ],
    );
  }
}

class CompletedSuccessCard extends StatelessWidget {
  const CompletedSuccessCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.green),
        boxShadow: AppShadows.card,
      ),
      child: const Column(
        children: [
          SuccessCircle(size: 64, iconSize: 28),
          SizedBox(height: 22),
          Text(
            'Job Successfully Finished',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.ink,
              fontSize: 23,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Your emergency wiring repair was\n'
            'completed at 2:45 PM. The workspace\n'
            'was left clean and the system is fully\n'
            'operational.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.body, fontSize: 16, height: 1.45),
          ),
          SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.verified, color: AppColors.successDark),
              SizedBox(width: 6),
              Flexible(
                child: Text(
                  'Expert Guarantee Applied',
                  style: TextStyle(
                    color: AppColors.successDark,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DetailColumn extends StatelessWidget {
  final String label;

  final String value;
  final CrossAxisAlignment align;
  final TextAlign textAlign;
  const DetailColumn({
    required this.label,
    required this.value,
    this.align = CrossAxisAlignment.start,
    this.textAlign = TextAlign.left,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: align,
      children: [
        Text(
          label,
          textAlign: textAlign,
          style: const TextStyle(
            color: AppColors.body,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          value,
          textAlign: textAlign,
          style: const TextStyle(
            color: AppColors.navy,
            fontSize: 16,
            height: 1.25,
          ),
        ),
      ],
    );
  }
}

class ExpertCompletedCard extends StatelessWidget {
  const ExpertCompletedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: const Row(
        children: [
          AssetSquareImage(size: 80, imagePath: 'assets/images/1.png'),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Marcus Sterling',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.ink,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    GreenBadge(label: 'EXPERT'),
                  ],
                ),
                Text(
                  'Master Electrician • 12 years exp.',
                  style: TextStyle(color: AppColors.body, fontSize: 14),
                ),
                SizedBox(height: 4),
                Wrap(
                  spacing: 12,
                  children: [
                    IconText(
                      icon: Icons.star,
                      text: '4.9 (428)',
                      color: Color(0xffd6a84d),
                    ),
                    IconText(
                      icon: Icons.verified_user_outlined,
                      text: 'Verified',
                      color: AppColors.successDark,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GreenBadge extends StatelessWidget {
  final String label;

  final bool large;
  const GreenBadge({required this.label, this.large = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: large ? 8 : 7,
        vertical: large ? 5 : 3,
      ),
      decoration: BoxDecoration(
        color: large ? const Color(0x4d6bfe9c) : AppColors.badgeGreen,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.successDark,
          fontSize: large ? 14 : 10,
          fontWeight: FontWeight.w800,
          letterSpacing: large ? 0 : .5,
        ),
      ),
    );
  }
}

class IconText extends StatelessWidget {
  final IconData icon;

  final String text;
  final Color color;
  const IconText({
    required this.icon,
    required this.text,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 15),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            color: AppColors.body,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class InfoTile extends StatelessWidget {
  final IconData icon;

  final String title;
  final String value;
  const InfoTile({
    required this.icon,
    required this.title,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xffe4eef8),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.navy, size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.navy,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.body,
                    fontSize: 14,
                    height: 1.25,
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

class MobilePage extends StatelessWidget {
  final Widget child;

  final Widget? header;
  final Widget? bottomNavigationBar;
  const MobilePage({
    required this.child,
    this.header,
    this.bottomNavigationBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 395),
          child: Column(
            children: [
              ?header,
              Expanded(child: SingleChildScrollView(child: child)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar == null
          ? null
          : Center(
              heightFactor: 1,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 395),
                child: bottomNavigationBar,
              ),
            ),
    );
  }
}

class NavItem extends StatelessWidget {
  final IconData icon;

  final String label;
  final bool active;
  const NavItem({
    required this.icon,
    required this.label,
    this.active = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.green : const Color(0xff9aacbf);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class OrderInfoCard extends StatelessWidget {
  const OrderInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffeaf4ff),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'ORDER ID',
                  style: TextStyle(color: AppColors.body, fontSize: 16),
                ),
              ),
              SizedBox(width: 12),
              Text(
                '#EXP-8829410',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.navy,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AssetSquareImage(size: 64, imagePath: 'assets/images/3.png'),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Strategic Financial\nPlanning',
                      style: TextStyle(
                        color: AppColors.navy,
                        fontSize: 17,
                        height: 1.25,
                      ),
                    ),
                    Text(
                      'Lead Consultant: Sarah\nJenkins',
                      style: TextStyle(
                        color: AppColors.body,
                        fontSize: 16,
                        height: 1.25,
                      ),
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.verified,
                          color: AppColors.successDark,
                          size: 15,
                        ),
                        SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            'TOP RATED EXPERT',
                            style: TextStyle(
                              color: AppColors.successDark,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(color: Color(0xffcbd5e1)),
          const SizedBox(height: 16),
          Row(
            children: [
              const Expanded(
                child: DetailColumn(
                  label: 'DATE & TIME',
                  value: 'Oct 24, 2023 •\n10:00 AM',
                ),
              ),
              Expanded(
                child: DetailColumn(
                  label: 'TOTAL\nAMOUNT',
                  value: '\$265.00',
                  align: CrossAxisAlignment.end,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OutlineActionButton extends StatelessWidget {
  final String label;

  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const OutlineActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18),
        label: Text(label, overflow: TextOverflow.ellipsis),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: color,
          elevation: 3,
          shadowColor: AppColors.navy.withValues(alpha: .16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: AppColors.border),
          ),
          textStyle: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class PriceRow extends StatelessWidget {
  final String label;

  final String value;
  const PriceRow({required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: Color(0xff141d23), fontSize: 16),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xff141d23),
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String label;

  final VoidCallback onTap;
  final IconData? icon;
  final Color color;
  final double height;
  const PrimaryButton({
    required this.label,
    required this.onTap,
    this.icon,
    this.color = AppColors.ink,
    this.height = 48,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 8,
          shadowColor: color.withValues(alpha: .28),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: 10),
              Icon(icon, size: 20),
            ],
          ],
        ),
      ),
    );
  }
}

class ProfessionalStatusCard extends StatelessWidget {
  const ProfessionalStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(17),
      child: Row(
        children: [
          const Stack(
            clipBehavior: Clip.none,
            children: [
              AssetSquareImage(size: 56, imagePath: 'assets/images/1.png'),
              Positioned(right: -4, bottom: -4, child: ShieldIcon(small: true)),
            ],
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Marcus Sterling',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.ink,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Color(0xffe7b85d), size: 14),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '4.9  •  Senior\nElectrician',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xff64748b),
                          fontSize: 14,
                          height: 1.25,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xffd8f8e4),
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Text(
              'TOP\nRATED',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.successDark,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                height: 1.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProTipCard extends StatelessWidget {
  const ProTipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffd8f8e4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xffb8f0cd)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb, color: AppColors.successDark),
          SizedBox(width: 16),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Pro Tip\n',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        'You can now start a chat with Sarah\n'
                        'to share any preliminary documents\n'
                        'or meeting agendas.',
                  ),
                ],
              ),
              style: TextStyle(
                color: Color(0xff2e9b63),
                fontSize: 16,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RatingProfessionalCard extends StatelessWidget {
  const RatingProfessionalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: const Row(
        children: [
          AssetAvatar(size: 64, imagePath: 'assets/images/4.png'),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Marcus Sterling',
                  style: TextStyle(
                    color: Color(0xff252a31),
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.verified, color: Color(0xff303846), size: 15),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Strategic Business Consultant',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.body,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceProtectionCard extends StatelessWidget {
  const ServiceProtectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        color: AppColors.navy,
        child: Stack(
          children: [
            Positioned(
              right: -40,
              bottom: -50,
              child: Icon(
                Icons.shield,
                size: 128,
                color: Colors.white.withValues(alpha: .09),
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Service Protection',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'Your payment is held securely in escrow and\n'
                  'only released when you confirm the service is\n'
                  'completed to your satisfaction.',
                  style: TextStyle(
                    color: AppColors.softText,
                    fontSize: 14,
                    height: 1.62,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceSummaryRow extends StatelessWidget {
  final String service;
  final String expert;

  const ServiceSummaryRow({
    super.key,
    required this.service,
    required this.expert,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AssetSquareImage(
          size: 80,
          imagePath: 'assets/images/2.png',
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GreenBadge(label: 'TOP RATED'),
              const SizedBox(height: 4),
              Text(
                service,
                style: const TextStyle(
                  color: AppColors.ink,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              Text(
                'Consultant: $expert',
                style: const TextStyle(
                  color: AppColors.muted,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ShieldIcon extends StatelessWidget {
  final bool small;

  const ShieldIcon({this.small = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.shield,
      color: AppColors.successDark,
      size: small ? 22 : 24,
    );
  }
}

class SimpleTopBar extends StatelessWidget {
  final String title;

  final Widget? trailing;
  const SimpleTopBar({required this.title, this.trailing, super.key});

  @override
  Widget build(BuildContext context) {
    return AppHeader(
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.arrow_back, color: AppColors.navy),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.navy,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

class StatusServiceDetailsCard extends StatelessWidget {
  const StatusServiceDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xffeaf4ff),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SERVICE DETAILS',
            style: TextStyle(
              color: AppColors.softText,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: .8,
            ),
          ),
          SizedBox(height: 18),
          Row(
            children: [
              Icon(Icons.calendar_month, color: AppColors.navy, size: 22),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Emergency Wiring Repair',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.navy,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'Order #EM-92841',
                      style: TextStyle(color: AppColors.muted, fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              Text(
                '\$185.00',
                style: TextStyle(
                  color: AppColors.ink,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StatusTimelineCard extends StatelessWidget {
  const StatusTimelineCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.fromLTRB(17, 17, 17, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Booking Status',
            style: TextStyle(
              color: AppColors.ink,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 28),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 16,
                left: 0,
                right: 0,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(height: 2, color: AppColors.line),
                    ),
                    Expanded(
                      child: Container(height: 2, color: AppColors.line),
                    ),
                    Expanded(
                      child: Container(
                        height: 2,
                        color: const Color(0xffdbe4ef),
                      ),
                    ),
                  ],
                ),
              ),
              const Row(
                children: [
                  Expanded(child: TimelineStep(label: 'Pending', done: true)),
                  Expanded(child: TimelineStep(label: 'Accepted', done: true)),
                  Expanded(
                    child: TimelineStep(
                      label: 'In Progress',
                      icon: Icons.sync,
                      done: true,
                    ),
                  ),
                  Expanded(
                    child: TimelineStep(label: 'Completed', done: false),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StepLine extends StatelessWidget {
  const StepLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      margin: const EdgeInsets.only(bottom: 22),
      color: AppColors.green,
    );
  }
}

class SuccessCircle extends StatelessWidget {
  final double size;

  final double iconSize;
  const SuccessCircle({required this.size, required this.iconSize, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xff66f394),
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xff48df7c), width: 4),
      ),
      child: Icon(
        Icons.check_circle,
        color: AppColors.successDark,
        size: iconSize,
      ),
    );
  }
}

class TimelineStep extends StatelessWidget {
  final String label;

  final bool done;
  final IconData icon;
  const TimelineStep({
    required this.label,
    required this.done,
    this.icon = Icons.check,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: done ? AppColors.successDark : Colors.white,
          foregroundColor: done ? Colors.white : const Color(0xffcbd5e1),
          child: Icon(icon, size: 14),
        ),
        const SizedBox(height: 8),
        FittedBox(
          child: Text(
            label,
            style: TextStyle(
              color: done ? AppColors.successDark : const Color(0xffaeb9c8),
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
