import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  final String selectedGovernorate;
  final String selectedCategory;
  final String selectedParty;

  const FilterPage({
    Key? key,
    required this.selectedGovernorate,
    required this.selectedCategory,
    required this.selectedParty,
  }) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String? governorate;
  String? category;
  String? party;

  @override
  void initState() {
    super.initState();
    governorate = widget.selectedGovernorate;
    category = widget.selectedCategory;
    party = widget.selectedParty;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('اختر الفلاتر'),
      children: [
        ListTile(
          title: const Text('المحافظة'),
          subtitle: Text(governorate ?? 'اختيار غير محدد'),
          onTap: () async {
            governorate = await _showGovernorateDialog(context);
            setState(() {});
          },
        ),
        ListTile(
          title: const Text('الفئة'),
          subtitle: Text(category ?? 'اختيار غير محدد'),
          onTap: () async {
            category = await _showCategoryDialog(context);
            setState(() {});
          },
        ),
        ListTile(
          title: const Text('الحزب'),
          subtitle: Text(party ?? 'اختيار غير محدد'),
          onTap: () async {
            party = await _showPartyDialog(context);
            setState(() {});
          },
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  "governorate": governorate,
                  "category": category,
                  "party": party,
                });
              },
              child: const Text('تطبيق الفلاتر'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, null);
              },
              child: const Text('إلغاء'),
            ),
          ],
        ),
      ],
    );
  }

  Future<String?> _showGovernorateDialog(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('اختر المحافظة'),
        children: [
          _buildOption(context, 'دمشق'),
          _buildOption(context, 'حلب'),
          _buildOption(context, 'اللاذقية'),
        ],
      ),
    );
  }

  Future<String?> _showCategoryDialog(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('اختر الفئة'),
        children: [
          _buildOption(context, 'أ'),
          _buildOption(context, 'ب'),
        ],
      ),
    );
  }

  Future<String?> _showPartyDialog(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('اختر الحزب'),
        children: [
          _buildOption(context, 'حزب العمال الديمقراطي'),
          _buildOption(context, 'حزب الاستقلال الوطني'),
        ],
      ),
    );
  }

  ListTile _buildOption(BuildContext context, String value) {
    return ListTile(
      title: Text(value),
      onTap: () {
        Navigator.pop(context, value);
      },
    );
  }
}
