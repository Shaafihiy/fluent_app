import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/course.dart';
import '../theme/app_theme.dart';
import '../widgets/course_widgets.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  String _searchQuery = '';
  String _selectedCategory = 'All';
  String _selectedSort = 'Popular';
  String _selectedLevel = 'All';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _sortOptions = [
    'Popular',
    'Highest Rated',
    'Newest',
    'Price: Low to High',
    'Price: High to Low',
  ];

  final List<String> _levels = ['All', 'Beginner', 'Intermediate', 'Advanced'];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Course> get _filteredCourses {
    List<Course> result = MockData.courses;

    // Search filter
    if (_searchQuery.isNotEmpty) {
      result = result
          .where((c) =>
              c.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              c.description
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              c.category.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              c.instructor.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    // Category filter
    if (_selectedCategory != 'All') {
      result = result.where((c) => c.category == _selectedCategory).toList();
    }

    // Level filter
    if (_selectedLevel != 'All') {
      result = result.where((c) => c.level == _selectedLevel).toList();
    }

    // Sort
    switch (_selectedSort) {
      case 'Highest Rated':
        result.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Popular':
        result.sort((a, b) => b.enrollments.compareTo(a.enrollments));
        break;
      case 'Price: Low to High':
        result.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        result.sort((a, b) => b.price.compareTo(a.price));
        break;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredCourses;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: FadeTransition(
        opacity: _fadeAnim,
        child: Column(
          children: [
            _buildHeader(context),
            _buildSearchBar(),
            _buildFilters(),
            _buildSortRow(filtered.length),
            Expanded(
              child: filtered.isEmpty
                  ? _buildEmpty()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 80),
                      itemCount: filtered.length,
                      itemBuilder: (_, i) => CourseCard(course: filtered[i]),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          20, MediaQuery.of(context).padding.top + 16, 20, 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  size: 16, color: AppTheme.textPrimary),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Explore Courses',
                    style: Theme.of(context).textTheme.headlineMedium),
                Text('${MockData.courses.length} courses available',
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          GestureDetector(
            onTap: _showFilterSheet,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withOpacity(0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(Icons.tune_rounded,
                  color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: TextField(
        controller: _searchController,
        onChanged: (v) => setState(() => _searchQuery = v),
        decoration: InputDecoration(
          hintText: 'Search courses, instructors...',
          prefixIcon: const Icon(Icons.search_rounded,
              color: AppTheme.textHint, size: 20),
          suffixIcon: _searchQuery.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                  child: const Icon(Icons.close_rounded,
                      color: AppTheme.textHint, size: 18),
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 38,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: MockData.categories.length,
        itemBuilder: (context, index) {
          final cat = MockData.categories[index];
          final selected = cat == _selectedCategory;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 10),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: selected ? AppTheme.primary : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: AppTheme.primary.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        )
                      ]
                    : [],
              ),
              child: Text(
                cat,
                style: TextStyle(
                  color: selected ? Colors.white : AppTheme.textSecondary,
                  fontSize: 12,
                  fontWeight:
                      selected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSortRow(int count) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: Row(
        children: [
          Text(
            '$count result${count != 1 ? 's' : ''}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: _showSortSheet,
            child: Row(
              children: [
                const Icon(Icons.sort_rounded,
                    size: 16, color: AppTheme.primary),
                const SizedBox(width: 4),
                Text(
                  _selectedSort,
                  style: const TextStyle(
                    color: AppTheme.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down_rounded,
                    size: 16, color: AppTheme.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded,
              size: 64, color: AppTheme.textHint.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text(
            'No courses found',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: AppTheme.textHint),
          ),
          const SizedBox(height: 8),
          Text(
            'Try a different search or filter',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () => setState(() {
              _searchQuery = '';
              _searchController.clear();
              _selectedCategory = 'All';
              _selectedLevel = 'All';
            }),
            child: const Text('Clear filters'),
          ),
        ],
      ),
    );
  }

  void _showSortSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Sort by', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 12),
            ..._sortOptions.map(
              (opt) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(opt,
                    style: TextStyle(
                      fontWeight: opt == _selectedSort
                          ? FontWeight.w700
                          : FontWeight.w400,
                      color: opt == _selectedSort
                          ? AppTheme.primary
                          : AppTheme.textPrimary,
                    )),
                trailing: opt == _selectedSort
                    ? const Icon(Icons.check_circle_rounded,
                        color: AppTheme.primary)
                    : null,
                onTap: () {
                  setState(() => _selectedSort = opt);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.divider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('Filter by Level',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _levels.map((lvl) {
                  final selected = lvl == _selectedLevel;
                  return GestureDetector(
                    onTap: () {
                      setModalState(() => _selectedLevel = lvl);
                      setState(() => _selectedLevel = lvl);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: selected ? AppTheme.primary : AppTheme.divider,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        lvl,
                        style: TextStyle(
                          color:
                              selected ? Colors.white : AppTheme.textSecondary,
                          fontWeight: selected
                              ? FontWeight.w700
                              : FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Apply Filters',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 4),
            ],
          ),
        ),
      ),
    );
  }
}
