import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/course.dart';
import '../theme/app_theme.dart';
import '../widgets/course_widgets.dart';

class CourseDetailScreen extends StatefulWidget {
  final Course course;
  const CourseDetailScreen({super.key, required this.course});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  bool _isEnrolled = false;
  bool _isSaved = false;
  final ScrollController _scrollController = ScrollController();
  bool _showTitle = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _animController.forward();

    _scrollController.addListener(() {
      if (_scrollController.offset > 220 && !_showTitle) {
        setState(() => _showTitle = true);
      } else if (_scrollController.offset <= 220 && _showTitle) {
        setState(() => _showTitle = false);
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final course = widget.course;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppTheme.background,
        body: FadeTransition(
          opacity: _fadeAnim,
          child: Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  _buildSliverAppBar(context, course),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCategoryAndLevel(course),
                          const SizedBox(height: 12),
                          _buildTitle(context, course),
                          const SizedBox(height: 12),
                          _buildInstructor(context, course),
                          const SizedBox(height: 20),
                          _buildStatsRow(context, course),
                          const SizedBox(height: 20),
                          _buildTags(course),
                          const SizedBox(height: 24),
                          _buildDescription(context, course),
                          const SizedBox(height: 24),
                          _buildInfoCards(context, course),
                          const SizedBox(height: 24),
                          if (course.progress != null)
                            _buildProgressSection(context, course),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // ── Floating bottom bar ──
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _buildBottomBar(context, course),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, Course course) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: AppTheme.primary,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white, size: 16),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () => setState(() => _isSaved = !_isSaved),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                _isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                color: Colors.white,
                size: 20,
                key: ValueKey(_isSaved),
              ),
            ),
          ),
        ),
        const SizedBox(width: 4),
      ],
      title: AnimatedOpacity(
        opacity: _showTitle ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: Text(
          course.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              course.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppTheme.categoryColor(course.category).withOpacity(0.3),
                child: Icon(Icons.school_rounded,
                    size: 80,
                    color: AppTheme.categoryColor(course.category)),
              ),
            ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryAndLevel(Course course) {
    return Row(
      children: [
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppTheme.categoryColor(course.category).withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            course.category,
            style: TextStyle(
              color: AppTheme.categoryColor(course.category),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppTheme.levelColor(course.level).withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            course.level,
            style: TextStyle(
              color: AppTheme.levelColor(course.level),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context, Course course) {
    return Text(
      course.title,
      style: Theme.of(context).textTheme.displayMedium,
    );
  }

  Widget _buildInstructor(BuildContext context, Course course) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: AppTheme.categoryColor(course.category).withOpacity(0.2),
          child: Text(
            course.instructor[0],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.categoryColor(course.category),
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Instructor',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Text(
              course.instructor,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsRow(BuildContext context, Course course) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _DetailStat(
            icon: Icons.star_rounded,
            value: course.rating.toString(),
            label: 'Rating',
            color: AppTheme.starColor,
          ),
          _Divider(),
          _DetailStat(
            icon: Icons.schedule_rounded,
            value: course.formattedDuration,
            label: 'Duration',
            color: AppTheme.primary,
          ),
          _Divider(),
          _DetailStat(
            icon: Icons.people_alt_rounded,
            value: course.formattedEnrollments,
            label: 'Students',
            color: AppTheme.accentGreen,
          ),
          _Divider(),
          _DetailStat(
            icon: Icons.attach_money_rounded,
            value: course.formattedPrice,
            label: 'Price',
            color: AppTheme.accentOrange,
          ),
        ],
      ),
    );
  }

  Widget _buildTags(Course course) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: course.tags
          .map(
            (tag) => Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.primaryLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '# $tag',
                style: const TextStyle(
                  color: AppTheme.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildDescription(BuildContext context, Course course) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About This Course',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 10),
        Text(
          course.description,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.textSecondary,
                height: 1.6,
              ),
        ),
      ],
    );
  }

  Widget _buildInfoCards(BuildContext context, Course course) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Course Includes',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 12),
        _InfoTile(
          icon: Icons.ondemand_video_rounded,
          text: '${course.duration} hours of on-demand video',
        ),
        _InfoTile(
          icon: Icons.all_inclusive_rounded,
          text: 'Full lifetime access',
        ),
        _InfoTile(
          icon: Icons.phone_android_rounded,
          text: 'Access on mobile and desktop',
        ),
        _InfoTile(
          icon: Icons.workspace_premium_rounded,
          text: 'Certificate of completion',
        ),
        _InfoTile(
          icon: Icons.download_rounded,
          text: 'Downloadable resources',
        ),
      ],
    );
  }

  Widget _buildProgressSection(BuildContext context, Course course) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.categoryColor(course.category).withOpacity(0.1),
            AppTheme.categoryColor(course.category).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.categoryColor(course.category).withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Your Progress',
                  style: Theme.of(context).textTheme.titleLarge),
              Text(
                '${(course.progress! * 100).round()}% Complete',
                style: TextStyle(
                  color: AppTheme.categoryColor(course.category),
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: course.progress,
              backgroundColor: AppTheme.divider,
              color: AppTheme.categoryColor(course.category),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, Course course) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          20, 16, 20, MediaQuery.of(context).padding.bottom + 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                course.price == 0 ? 'Free' : course.formattedPrice,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: course.price == 0
                      ? AppTheme.accentGreen
                      : AppTheme.primary,
                ),
              ),
              if (course.price > 0)
                Text(
                  'One-time payment',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => _isEnrolled = !_isEnrolled);
                if (!_isEnrolled) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Successfully enrolled! 🎉'),
                      backgroundColor: AppTheme.accentGreen,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: _isEnrolled
                      ? const LinearGradient(
                          colors: [AppTheme.accentGreen, Color(0xFF00A67E)])
                      : const LinearGradient(
                          colors: [AppTheme.primary, AppTheme.primaryDark],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: (_isEnrolled
                              ? AppTheme.accentGreen
                              : AppTheme.primary)
                          .withOpacity(0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  _isEnrolled
                      ? (course.progress != null
                          ? 'Continue Learning'
                          : '✓ Enrolled')
                      : (course.price == 0 ? 'Enrol for Free' : 'Enrol Now'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  const _DetailStat(
      {required this.icon,
      required this.value,
      required this.label,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        width: 1,
        height: 40,
        color: AppTheme.divider,
      );
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoTile({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppTheme.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: AppTheme.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}
