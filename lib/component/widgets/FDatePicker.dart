

import 'package:flutter/cupertino.dart';
import 'package:handheld_calculator/Component/widgets/button_size.dart';

import '../../config/theme/skins/color_skin.dart';
import '../../config/theme/styles/typo_skin.dart';
import '../../config/theme/widgets/filled_button.dart';
import '../../config/theme/widgets/icon.dart';
import '../../config/theme/widgets/icon_data.dart';
import 'app_bar.dart';
import 'date_time_picker.dart';

class FDatePicker extends StatefulWidget {
  final String title;
  final DateTime ?minimumDate;
  final DateTime ?maximumDate;
  int ?minimumYear;
  int ?maximumYear;
  final TextEditingController controller;
  final String ?cancelTitle;
  final String ?buttonTitle;
  final bool dayVisible;
  final bool useLeading;
  final FCupertinoDatePickerMode mode;
  Function ?onClean;
  bool onlyYear;
  final Function(String) ?onChangeYear;

  FDatePicker(
    this.title, {
    Key? key,
    required this.initDateTime,
    this.minimumDate,
    int ?minimumYear,
    this.maximumDate,
    int ?maximumYear,
    required this.controller,
    this.dayVisible = true,
    this.cancelTitle,
    this.buttonTitle,
    this.onClean,
    this.mode = FCupertinoDatePickerMode.date,
    this.useLeading = true,
    this.onlyYear = false,
    this.onChangeYear,
  })  : minimumYear = minimumYear ?? DateTime.now().year - 100,
        maximumYear = maximumYear ?? DateTime.now().year + 100,
        super(key: key);

  final DateTime initDateTime;

  @override
  _FDatePickerState createState() => _FDatePickerState();
}

class _FDatePickerState extends State<FDatePicker> {
  DateTime ?_selectedDateTime;
  int _selectedYear = DateTime.now().year;
  final List<int> _yearList = [];
  FixedExtentScrollController ?_yearController;

  @override
  void initState() {
    _selectedDateTime = widget.initDateTime;

    if (widget.maximumDate != null) {
      widget.maximumYear = widget.maximumDate!.year;
    }
    if (widget.minimumDate != null) {
      widget.minimumYear = widget.minimumDate!.year;
    }
    super.initState();

    _selectedYear = widget.initDateTime.year;
    for (var i = widget.minimumYear; i !<= widget.maximumYear!; i++) {
      _yearList.add(i!);
    }
    _yearController = FixedExtentScrollController(initialItem: _yearList.indexOf(widget.initDateTime.year));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MediaQuery.of(context).padding,
      decoration: BoxDecoration(
        color: FColorSkin.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Wrap(
        children: [
          Center(
            child: Container(
              width: 32,
              height: 4,
              margin: EdgeInsets.only(top: 8, bottom: 4),
              decoration: BoxDecoration(
                color: FColorSkin.grey3,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          FAppBar(
            centerTitle: true,
            leading: widget.useLeading
                ? FFilledButton.icon(
                    backgroundColor: FColorSkin.transparent,
                    onPressed: () => Navigator.pop(context),
                    child: FIcon(
                      icon: FOutlined.left_arrow,
                      color: FColorSkin.subtitle,
                    ),
                  )
                : SizedBox(),
            title: Text(
              widget.title,
              style: FTypoSkin.title4.copyWith(color: FColorSkin.title, height: 1),
            ),
            actions: [
              if (!widget.useLeading)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FFilledButton.icon(
                    backgroundColor: FColorSkin.transparent,
                    onPressed: () => Navigator.pop(context),
                    child: FIcon(icon: FOutlined.e_remove, color: FColorSkin.subtitle),
                  ),
                ),
            ],
          ),
          Container(
            height: 186,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: widget.onlyYear
                ? Column(
                    children: [
                      Expanded(
                        child: CupertinoPicker(
                          itemExtent: 36,
                          onSelectedItemChanged: (int index) {
                            _selectedYear = _yearList[index];
                            widget.onChangeYear;
                            setState(() {});
                          },
                          useMagnifier: true,
                          magnification: 1.2,
                          squeeze: 1.10,
                          selectionOverlay:
                              CupertinoPickerDefaultSelectionOverlay(background: Color.fromARGB(30, 161, 161, 170)),
                          scrollController: _yearController,
                          children: _yearList
                              .map(
                                (item) => Center(
                                  child: Text(
                                    item.toString(),
                                    style: FTypoSkin.title4.copyWith(color: FColorSkin.title),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  )
                : FCupertinoDatePicker(
                    use24hFormat: true,
                    mode: widget.mode,
                    dayVisible: widget.dayVisible,
                    maximumYear: widget.maximumYear,
                    maximumDate: widget.maximumDate,
                    minimumDate: widget.minimumDate,
                    minimumYear: widget.minimumYear!,
                    initialDateTime: _selectedDateTime,
                    onDateTimeChanged: (value) async {
                      setState(() {
                        _selectedDateTime = value;
                      });
                    },
                  ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: FFilledButton(
              onPressed: () => Navigator.pop(context, widget.onlyYear ? _selectedYear : _selectedDateTime),
              backgroundColor: FColorSkin.primary,
              size: FButtonSize.size40,
              child: Center(child: Text(widget.buttonTitle ?? 'Chọn')),
            ),
          ),
        ],
      ),
    );
  }
}
class FMonthPicker extends StatefulWidget {
  final String title;
  final DateTime initialDate;
  final TextEditingController controller;
  final String ?cancelTitle;
  final String ?buttonTitle;
  final Function ?onClean;
  final bool useLeading;
  final Function(int) ?onSelectedMonth;

  FMonthPicker({
    Key ?key,
    required this.title,
    required this.initialDate,
    required this.controller,
    this.cancelTitle,
    this.buttonTitle,
    this.onClean,
    this.useLeading = true,
    this.onSelectedMonth,
  }) : super(key: key);

  @override
  _FMonthPickerState createState() => _FMonthPickerState();
}

class _FMonthPickerState extends State<FMonthPicker> {
  int ?_selectedMonth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MediaQuery.of(context).padding,
      decoration: BoxDecoration(
        color: FColorSkin.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Wrap(
        children: [
          Center(
            child: Container(
              width: 32,
              height: 4,
              margin: EdgeInsets.only(top: 8, bottom: 4),
              decoration: BoxDecoration(
                color: FColorSkin.grey3,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          FAppBar(
            centerTitle: true,
            leading: widget.useLeading
                ? FFilledButton.icon(
              backgroundColor: FColorSkin.transparent,
              onPressed: () => Navigator.pop(context),
              child: FIcon(
                icon: FOutlined.left_arrow,
                color: FColorSkin.subtitle,
              ),
            )
                : SizedBox(),
            title: Text(
              widget.title,
              style: FTypoSkin.title4.copyWith(color: FColorSkin.title, height: 1),
            ),
            actions: [
              if (!widget.useLeading)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FFilledButton.icon(
                    backgroundColor: FColorSkin.transparent,
                    onPressed: () => Navigator.pop(context),
                    child: FIcon(icon: FOutlined.e_remove, color: FColorSkin.subtitle),
                  ),
                ),
            ],
          ),
          Container(
            height: 186,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: CupertinoPicker(
              itemExtent: 36,
              onSelectedItemChanged: (int index) {
                setState(() {
                  _selectedMonth = index + 1; // Month starts from 1 in DateTime class
                });
              },
              children: List.generate(12, (index) {
                return Center(
                  child: Text(
                    '${index + 1}', // Month starts from 1 in DateTime class
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: FFilledButton(
              onPressed: () {
                widget.onSelectedMonth?.call(_selectedMonth!);
                Navigator.pop(context, _selectedMonth);
              },
              backgroundColor: FColorSkin.primary,
              size: FButtonSize.size48,
              child: Center(child: Text(widget.buttonTitle ?? 'Chọn')),
            ),
          ),
        ],
      ),
    );
  }
}
class FYearPicker extends StatefulWidget {
  final String title;
  final DateTime initialDate;
  final TextEditingController controller;
  final String ?cancelTitle;
  final String ?buttonTitle;
  final Function ?onClean;
  final bool useLeading;
  final Function(int) ?onSelectedYear;

  FYearPicker({
    Key ?key,
    required this.title,
    required this.initialDate,
    required this.controller,
    this.cancelTitle,
    this.buttonTitle,
    this.onClean,
    this.useLeading = true,
    this.onSelectedYear,
  }) : super(key: key);

  @override
  _FYearPickerState createState() => _FYearPickerState();
}

class _FYearPickerState extends State<FYearPicker> {
  int ?_selectedYear;

  @override
  void initState() {
    super.initState();
    _selectedYear = DateTime.now().year; // Set it to the current year
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MediaQuery.of(context).padding,
      decoration: BoxDecoration(
        color: FColorSkin.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Wrap(
        children: [
          Center(
            child: Container(
              width: 32,
              height: 4,
              margin: EdgeInsets.only(top: 8, bottom: 4),
              decoration: BoxDecoration(
                color: FColorSkin.grey3,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          FAppBar(
            centerTitle: true,
            leading: widget.useLeading
                ? FFilledButton.icon(
              backgroundColor: FColorSkin.transparent,
              onPressed: () => Navigator.pop(context),
              child: FIcon(
                icon: FOutlined.left_arrow,
                color: FColorSkin.subtitle,
              ),
            )
                : SizedBox(),
            title: Text(
              widget.title,
              style: FTypoSkin.title4.copyWith(color: FColorSkin.title, height: 1),
            ),
            actions: [
              if (!widget.useLeading)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FFilledButton.icon(
                    backgroundColor: FColorSkin.transparent,
                    onPressed: () => Navigator.pop(context),
                    child: FIcon(icon: FOutlined.e_remove, color: FColorSkin.subtitle),
                  ),
                ),
            ],
          ),
          Container(
            height: 186,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: CupertinoPicker(
              itemExtent: 36,
              scrollController: FixedExtentScrollController(initialItem: 100),
              onSelectedItemChanged: (int index) {
                setState(() {
                  _selectedYear = DateTime.now().year - 100 + index;
                });
              },
              children: List.generate(201, (index) {
                return Center(
                  child: Text(
                    '${DateTime.now().year - 100 + index}',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: FFilledButton(
              onPressed: () {
                widget.onSelectedYear?.call(_selectedYear!);
                Navigator.pop(context, _selectedYear);
              },
              backgroundColor: FColorSkin.primary,
              size: FButtonSize.size48,
              child: Center(child: Text(widget.buttonTitle ?? 'Chọn')),
            ),
          ),
        ],
      ),
    );
  }
}
class FQuarterPicker extends StatefulWidget {
  final String title;
  final DateTime initialDate;
  final TextEditingController controller;
  final String ?cancelTitle;
  final String ?buttonTitle;
  final Function ?onClean;
  final bool useLeading;
  final Function(int) ?onSelectedQuarter;

  FQuarterPicker({
    Key ?key,
    required this.title,
    required this.initialDate,
    required this.controller,
    this.cancelTitle,
    this.buttonTitle,
    this.onClean,
    this.useLeading = true,
    this.onSelectedQuarter,
  }) : super(key: key);

  @override
  _FQuarterPickerState createState() => _FQuarterPickerState();
}

class _FQuarterPickerState extends State<FQuarterPicker> {
  int ?_selectedQuarter;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MediaQuery.of(context).padding,
      decoration: BoxDecoration(
        color: FColorSkin.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Wrap(
        children: [
          Center(
            child: Container(
              width: 32,
              height: 4,
              margin: EdgeInsets.only(top: 8, bottom: 4),
              decoration: BoxDecoration(
                color: FColorSkin.grey3,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          FAppBar(
            centerTitle: true,
            leading: widget.useLeading
                ? FFilledButton.icon(
              backgroundColor: FColorSkin.transparent,
              onPressed: () => Navigator.pop(context),
              child: FIcon(
                icon: FOutlined.left_arrow,
                color: FColorSkin.subtitle,
              ),
            )
                : SizedBox(),
            title: Text(
              widget.title,
              style: FTypoSkin.title4.copyWith(color: FColorSkin.title, height: 1),
            ),
            actions: [
              if (!widget.useLeading)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FFilledButton.icon(
                    backgroundColor: FColorSkin.transparent,
                    onPressed: () => Navigator.pop(context),
                    child: FIcon(icon: FOutlined.e_remove, color: FColorSkin.subtitle),
                  ),
                ),
            ],
          ),
          Container(
            height: 150, // Adjust the height according to your needs
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: CupertinoPicker(
              itemExtent: 36,
              onSelectedItemChanged: (int index) {
                setState(() {
                  _selectedQuarter = index + 1; // Quarters start from 1
                });
              },
              children: List.generate(4, (index) {
                return Center(
                  child: Text(
                    'Quý ${index + 1}',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: FFilledButton(
              onPressed: () {
                widget.onSelectedQuarter?.call(_selectedQuarter!);
                Navigator.pop(context, _selectedQuarter);
              },
              backgroundColor: FColorSkin.primary,
              size: FButtonSize.size48,
              child: Center(child: Text(widget.buttonTitle ?? 'Chọn')),
            ),
          ),
        ],
      ),
    );
  }
}
class FHourPicker extends StatefulWidget {
  final String title;
  final DateTime initialTime;
  final TextEditingController controller;
  final String ?cancelTitle;
  final String ?buttonTitle;
  final Function ?onClean;
  final Function(int) ?onChangeHour;

  FHourPicker(
      this.title, {
        Key ?key,
        required this.initialTime,
        required this.controller,
        this.cancelTitle,
        this.buttonTitle,
        this.onClean,
        this.onChangeHour,
      }) : super(key: key);

  @override
  _FHourPickerState createState() => _FHourPickerState();
}

class _FHourPickerState extends State<FHourPicker> {
  int ?_selectedHour;

  @override
  void initState() {
    _selectedHour = widget.initialTime.hour;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MediaQuery
          .of(context)
          .padding,
      decoration: BoxDecoration(
        color: FColorSkin.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Wrap(
        children: [
          // ... Similar AppBar code as in FDatePicker

          Container(
            height: 186,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: CupertinoPicker(
              itemExtent: 36,
              onSelectedItemChanged: (int index) {
                _selectedHour = index;
                widget.onChangeHour!(_selectedHour!);
              },
              useMagnifier: true,
              magnification: 1.2,
              squeeze: 1.10,
              selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                  background: Color.fromARGB(30, 161, 161, 170)),
              children: List.generate(24, (index) {
                return Center(
                  child: Text(
                    index.toString(),
                    style: FTypoSkin.title4.copyWith(color: FColorSkin.title),
                  ),
                );
              }),
              scrollController: FixedExtentScrollController(
                  initialItem: _selectedHour!),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: FFilledButton(
              onPressed: () => Navigator.pop(context, _selectedHour),
              backgroundColor: FColorSkin.primary,
              size: FButtonSize.size48,
              child: Center(child: Text(widget.buttonTitle ??'')),
            ),
          ),
        ],
      ),
    );
  }
}
class FTimePicker extends StatefulWidget {
  final String title;
  final DateTime initialDateTime;
  TextEditingController ?fromDateC;
  TextEditingController ?toDateC;
  int ?maxHour;
  int ?minHour;
  int ?maxMinute;
  int ?minMinute;
  DateTime ?max;
  DateTime ?min;
  final TextEditingController controller;
  final String ?cancelTitle;
  final String ?buttonTitle;
  final bool useLeading;
  final Function ?onClean;
  final Function(String) ?onChangeTime;

  FTimePicker({
    Key ?key,
    required this.title,
    required this.initialDateTime,
    required this.controller,
    this.maxHour,
    this.minHour,
    this.maxMinute, // Thêm dòng này
    this.minMinute, // Thêm dòng này
    this.fromDateC,
    this.toDateC,
    this.min,
    this.max,
    this.cancelTitle,
    this.buttonTitle,
    this.useLeading = true,
    this.onClean,
    this.onChangeTime,
  }) : super(key: key);

  @override
  _FTimePickerState createState() => _FTimePickerState();
}

class _FTimePickerState extends State<FTimePicker> {
  DateTime ?_selectedTime;

  @override
  void initState() {
    _selectedTime = widget.initialDateTime;
    super.initState();
  }


  String _formatTime(DateTime time) {
    String period = time.hour < 12 ? 'AM' : 'PM';
    int hour = time.hour % 12;
    hour = hour == 0 ? 12 : hour; // Convert 0 to 12 for AM
    String minute = time.minute.toString().padLeft(2, '0');

    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MediaQuery.of(context).padding,
      decoration: BoxDecoration(
        color: FColorSkin.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Wrap(
        children: [
          Center(
            child: Container(
              width: 32,
              height: 4,
              margin: EdgeInsets.only(top: 8, bottom: 4),
              decoration: BoxDecoration(
                color: FColorSkin.grey3,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          FAppBar(
            centerTitle: true,
            leading: widget.useLeading
                ? FFilledButton.icon(
              backgroundColor: FColorSkin.transparent,
              onPressed: () => Navigator.pop(context),
              child: FIcon(
                icon: FOutlined.left_arrow,
                color: FColorSkin.subtitle,
              ),
            )
                : SizedBox(),
            title: Text(
              widget.title,
              style: FTypoSkin.title4.copyWith(color: FColorSkin.title, height: 1),
            ),
            actions: [
              if (!widget.useLeading)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FFilledButton.icon(
                    backgroundColor: FColorSkin.transparent,
                    onPressed: () => Navigator.pop(context),
                    child: FIcon(icon: FOutlined.e_remove, color: FColorSkin.subtitle),
                  ),
                ),
            ],
          ),
          Container(
            height: 186,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDateTime: _selectedTime,
              onDateTimeChanged: (value) {
                setState(() {
                  _selectedTime = value;
                });
                if (widget.onChangeTime != null) {
                  widget.onChangeTime!(_formatTime(_selectedTime!));
                }
              },
              use24hFormat: true,
              maximumDate: widget.max,
              minimumDate: widget.min,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: FFilledButton(
              onPressed: () => Navigator.pop(context, _formatTime(_selectedTime!)),
              backgroundColor: FColorSkin.primary,
              size: FButtonSize.size48,
              child: Center(child: Text(widget.buttonTitle ?? 'Chọn')),
            ),
          ),
        ],
      ),
    );
  }
}
class FActivityTypePicker extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final String ?cancelTitle;
  final String ?buttonTitle;
  final Function ?onClean;
  final bool ?useLeading;
  final Function(String) ?onSelectedActivityType;

  FActivityTypePicker({
    Key ?key,
    required this.title,
    required this.controller,
    this.cancelTitle,
    this.buttonTitle,
    this.onClean,
    this.useLeading = true,
    this.onSelectedActivityType,
  }) : super(key: key);

  @override
  _FActivityTypePickerState createState() => _FActivityTypePickerState();
}

class _FActivityTypePickerState extends State<FActivityTypePicker> {
  String? _selectedActivityType='Kinh doanh nhà hàng, khách sạn';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MediaQuery.of(context).padding,
      decoration: BoxDecoration(
        color: FColorSkin.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Wrap(
        children: [
          Center(
            child: Container(
              width: 32,
              height: 4,
              margin: EdgeInsets.only(top: 8, bottom: 4),
              decoration: BoxDecoration(
                color: FColorSkin.grey3,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          FAppBar(
            centerTitle: true,
            leading: widget.useLeading!
                ? FFilledButton.icon(
              backgroundColor: FColorSkin.transparent,
              onPressed: () => Navigator.pop(context),
              child: FIcon(
                icon: FOutlined.left_arrow,
                color: FColorSkin.subtitle,
              ),
            )
                : SizedBox(),
            title: Text(
              widget.title,
              style: FTypoSkin.title4.copyWith(color: FColorSkin.title, height: 1),
            ),
            actions: [
              if (!widget.useLeading!)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FFilledButton.icon(
                    backgroundColor: FColorSkin.transparent,
                    onPressed: () => Navigator.pop(context),
                    child: FIcon(icon: FOutlined.e_remove, color: FColorSkin.subtitle),
                  ),
                ),
            ],
          ),
          Container(
            height: 150, // Adjust the height according to your needs
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: CupertinoPicker(
              itemExtent: 36,
              onSelectedItemChanged: (int index) {
                setState(() {
                  _selectedActivityType = _getActivityType(index);
                });
              },
              children: List.generate(5, (index) {
                return Center(
                  child: Text(
                    _getActivityType(index),
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: FFilledButton(
              onPressed: () {
                widget.onSelectedActivityType?.call(_selectedActivityType ?? '');
                Navigator.pop(context, _selectedActivityType);
              },
              backgroundColor: FColorSkin.primaryPressed,
              size: FButtonSize.size48,
              child: Center(child: Text(widget.buttonTitle ?? 'Chọn')),
            ),
          ),
        ],
      ),
    );
  }

  String _getActivityType(int index) {
    switch (index) {
      case 0:
        return 'Kinh doanh nhà hàng, khách sạn';
      case 1:
        return 'Kinh doanh lưu trú du lịch';
      case 2:
        return 'Kinh doanh vận chuyển khách du lịch';
      case 3:
        return 'Kinh doanh phát triển khu du lịch, điểm du lịch';
      case 4:
        return 'Kinh doanh dịch vụ du lịch khác';
      default:
        return '';
    }
  }
}
