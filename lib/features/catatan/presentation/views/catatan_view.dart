import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:kaloree/core/theme/color_schemes.g.dart';
import 'package:kaloree/core/theme/fonts.dart';
import 'package:kaloree/core/widgets/loading.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_error_view.dart';
import 'package:kaloree/features/catatan/presentation/bloc/catatan_bloc.dart';
import 'package:kaloree/features/catatan/presentation/widgets/catatan_item_card.dart';

class CatatanView extends StatefulWidget {
  const CatatanView({super.key});

  @override
  State<CatatanView> createState() => _CatatanViewState();
}

class _CatatanViewState extends State<CatatanView> {
  final thisMonth = DateFormat('MMMM').format(DateTime.now());
  @override
  void initState() {
    super.initState();
    context.read<CatatanBloc>().add(GetCatatanListByMonth());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatatanBloc, CatatanState>(builder: (context, state) {
      if (state is CatatanSuccess) {
        final catatanListByMonth = state.catatanListByMonth;

        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildCatatanAppBar(),
            body: SingleChildScrollView(
              child: Column(
                children: catatanListByMonth.catatanByMonthAndDay.entries
                    .map((monthEntry) {
                  return Column(
                    children: monthEntry.value.entries.map((dayEntry) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
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
                              title: _buildHeaderText(
                                  title: DateFormat('EEEE, d MMMM yyyy')
                                      .format(DateTime.parse(dayEntry.key))),
                              children:
                                  dayEntry.value.map((classificationResult) {
                                return CatatanItemCard(
                                    classificationResult: classificationResult);
                              }).toList(),
                            )),
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      } else if (state is CatatanLoading) {
        return SafeArea(
            child: Scaffold(
          appBar: _buildCatatanAppBar(),
          body: const Loading(),
        ));
      } else if (state is CatatanFailure) {
        return SafeArea(
            child: Scaffold(
          appBar: _buildCatatanAppBar(),
          body: const ErrorView(message: 'Catatan masih kosong!'),
        ));
      } else {
        return SafeArea(
            child: Scaffold(
          appBar: _buildCatatanAppBar(),
          body: const ErrorView(message: 'Catatan masih kosong!'),
        ));
      }
    });
  }

  AppBar _buildCatatanAppBar() {
    return AppBar(
      backgroundColor: lightColorScheme.background,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.calendar_month),
          const Gap(4),
          Text('Catatan Bulan $thisMonth'),
        ],
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
