import 'package:flutter/material.dart';
import 'package:kaloree/core/theme/fonts.dart';
import 'package:kaloree/features/catatan/presentation/widgets/catatan_item_card.dart';

class CatatanView extends StatefulWidget {
  const CatatanView({super.key});

  @override
  State<CatatanView> createState() => _CatatanViewState();
}

class _CatatanViewState extends State<CatatanView> {
  final List<bool> _isOpen = [true, true];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              ExpansionPanelList(
                elevation: 0,
                expansionCallback: (i, isOpen) {
                  setState(() {
                    _isOpen[i] = isOpen;
                  });
                },
                children: [
                  ExpansionPanel(
                    backgroundColor: const Color(0xffF0F1ED),
                    headerBuilder: (context, isOpen) =>
                        _buildHeaderText(title: 'Rabu, 16 Mei 2024'),
                    isExpanded: _isOpen[0],
                    body: const Column(
                      children: [
                        CatatanItemCard(),
                        CatatanItemCard(),
                        CatatanItemCard(),
                      ],
                    ),
                  ),
                  ExpansionPanel(
                    backgroundColor: const Color(0xffF0F1ED),
                    headerBuilder: (context, isOpen) =>
                        _buildHeaderText(title: 'Kamis, 7 Mei 2024'),
                    isExpanded: _isOpen[1],
                    body: const Column(
                      children: [
                        CatatanItemCard(),
                        CatatanItemCard(),
                        CatatanItemCard(),
                      ],
                    ),
                  ),
                ],
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
