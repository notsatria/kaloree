import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/theme/fonts.dart';
import 'package:kaloree/features/catatan/presentation/widgets/catatan_item_card.dart';

class CatatanView extends StatefulWidget {
  const CatatanView({super.key});

  @override
  State<CatatanView> createState() => _CatatanViewState();
}

class _CatatanViewState extends State<CatatanView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: lightColorScheme.background,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_month),
              Gap(4),
              Text('Catatan Bulan Mei'),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xffF0F1ED),
                ),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    initiallyExpanded: true,
                    title: _buildHeaderText(title: 'Rabu, 6 Mei 2024'),
                    children: const [
                      CatatanItemCard(),
                      CatatanItemCard(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text _buildHeaderText({required String title}) {
    return Text(
      title,
      style: interSemiBold.copyWith(fontSize: 15),
    );
  }
}
