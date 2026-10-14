import 'package:flutter/material.dart';

import '../../features/drama/data/drama_repository.dart';

enum HarnessScreen {
  smallPhone,
  largePhone,
  tablet,
}

enum HarnessOrientation {
  portrait,
  landscape,
}

enum HarnessData {
  normal,
  longName,
  zeroItems,
  manyItems,
}

class DeviceHarness extends StatefulWidget {
  const DeviceHarness({
    super.key,
    required this.childBuilder,
  });

  final Widget Function(DramaRepository repository) childBuilder;

  @override
  State<DeviceHarness> createState() => _DeviceHarnessState();
}

class _DeviceHarnessState extends State<DeviceHarness> {
  HarnessScreen screen = HarnessScreen.smallPhone;
  HarnessOrientation orientation = HarnessOrientation.portrait;
  HarnessData data = HarnessData.normal;

  bool keyboardOpen = false;
  bool darkMode = false;
  bool notch = false;

  DramaRepository get _repository {
    switch (data) {
      case HarnessData.normal:
        return DramaRepository(
          mode: DramaDataMode.normal,
        );

      case HarnessData.longName:
        return DramaRepository(
          mode: DramaDataMode.longName,
        );

      case HarnessData.zeroItems:
        return DramaRepository(
          mode: DramaDataMode.zeroItems,
        );

      case HarnessData.manyItems:
        return DramaRepository(
          mode: DramaDataMode.manyItems,
        );
    }
  }

  double get portraitWidth {
    switch (screen) {
      case HarnessScreen.smallPhone:
        return 320;

      case HarnessScreen.largePhone:
        return 430;

      case HarnessScreen.tablet:
        return 768;
    }
  }

  double get portraitHeight {
    switch (screen) {
      case HarnessScreen.smallPhone:
        return 568;

      case HarnessScreen.largePhone:
        return 932;

      case HarnessScreen.tablet:
        return 1024;
    }
  }

  double get deviceWidth {
    return orientation == HarnessOrientation.portrait
        ? portraitWidth
        : portraitHeight;
  }

  double get deviceHeight {
    return orientation == HarnessOrientation.portrait
        ? portraitHeight
        : portraitWidth;
  }

  double get keyboardHeight {
    if (!keyboardOpen) {
      return 0;
    }

    if (orientation == HarnessOrientation.landscape) {
      return 190;
    }

    return 280;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE1E5E8),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 320,
            child: Container(
              color: const Color(0xFFF7F9FC),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    32,
                    28,
                    24,
                    28,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Lab 04 · device harness',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Try every combination. Keep the debug '
                            'console open: "A RenderFlex overflowed by '
                            '... pixels" names the widget, the axis '
                            'and the amount.',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 28),
                      _sectionTitle('Screen'),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _optionButton(
                            'Small phone',
                            screen == HarnessScreen.smallPhone,
                                () {
                              setState(() {
                                screen = HarnessScreen.smallPhone;
                              });
                            },
                          ),
                          _optionButton(
                            'Large phone',
                            screen == HarnessScreen.largePhone,
                                () {
                              setState(() {
                                screen = HarnessScreen.largePhone;
                              });
                            },
                          ),
                          _optionButton(
                            'Tablet',
                            screen == HarnessScreen.tablet,
                                () {
                              setState(() {
                                screen = HarnessScreen.tablet;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 26),
                      _sectionTitle('Orientation'),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _optionButton(
                            'Portrait',
                            orientation == HarnessOrientation.portrait,
                                () {
                              setState(() {
                                orientation =
                                    HarnessOrientation.portrait;
                              });
                            },
                          ),
                          _optionButton(
                            'Landscape',
                            orientation == HarnessOrientation.landscape,
                                () {
                              setState(() {
                                orientation =
                                    HarnessOrientation.landscape;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 26),
                      _sectionTitle('Data'),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _optionButton(
                            'Normal',
                            data == HarnessData.normal,
                                () {
                              setState(() {
                                data = HarnessData.normal;
                              });
                            },
                          ),
                          _optionButton(
                            '200-char name',
                            data == HarnessData.longName,
                                () {
                              setState(() {
                                data = HarnessData.longName;
                              });
                            },
                          ),
                          _optionButton(
                            'Zero items',
                            data == HarnessData.zeroItems,
                                () {
                              setState(() {
                                data = HarnessData.zeroItems;
                              });
                            },
                          ),
                          _optionButton(
                            '500 items',
                            data == HarnessData.manyItems,
                                () {
                              setState(() {
                                data = HarnessData.manyItems;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 26),
                      _sectionTitle('Conditions'),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _optionButton(
                            'Keyboard open',
                            keyboardOpen,
                                () {
                              setState(() {
                                keyboardOpen = !keyboardOpen;
                              });
                            },
                          ),
                          _optionButton(
                            'Dark mode',
                            darkMode,
                                () {
                              setState(() {
                                darkMode = !darkMode;
                              });
                            },
                          ),
                          _optionButton(
                            'Notch + gesture bar',
                            notch,
                                () {
                              setState(() {
                                notch = !notch;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 26),
                      Text(
                        'Screen: '
                            '${deviceWidth.toInt()} × '
                            '${deviceHeight.toInt()} dp',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: FittedBox(
                fit: BoxFit.contain,
                child: _buildDevice(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDevice() {
    final bool isTablet = screen == HarnessScreen.tablet;

    return Container(
      width: deviceWidth,
      height: deviceHeight,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(
          isTablet ? 24 : 28,
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 18,
            spreadRadius: 3,
            offset: Offset(0, 7),
            color: Color(0x55000000),
          ),
        ],
      ),
      padding: EdgeInsets.all(
        isTablet ? 8 : 7,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          isTablet ? 18 : 21,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildDeviceScreen(),
            if (notch)
              _buildNotch(
                isTablet: isTablet,
              ),
            if (notch)
              _buildGestureBar(
                isTablet: isTablet,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotch({
    required bool isTablet,
  }) {
    final double width = isTablet ? 110 : 60;
    final double height = isTablet ? 20 : 16;

    return Positioned(
      top: 8,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(
              height,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGestureBar({
    required bool isTablet,
  }) {
    final double width = isTablet ? 120 : 92;

    return Positioned(
      bottom: 7,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: width,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceScreen() {
    return Stack(
      fit: StackFit.expand,
      children: [
        MediaQuery(
          data: MediaQuery.of(context).copyWith(
            viewInsets: keyboardOpen
                ? EdgeInsets.only(
              bottom: keyboardHeight,
            )
                : EdgeInsets.zero,
            padding: notch
                ? EdgeInsets.only(
              top: screen == HarnessScreen.tablet ? 28 : 24,
              bottom: 8,
            )
                : EdgeInsets.zero,
          ),
          child: _buildHomeShell(),
        ),
        if (keyboardOpen)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: keyboardHeight,
            child: _buildKeyboard(),
          ),
      ],
    );
  }

  Widget _buildHomeShell() {
    final Widget child = KeyedSubtree(
      key: ValueKey(data),
      child: widget.childBuilder(_repository),
    );

    return Theme(
      data: darkMode
          ? ThemeData.dark(
        useMaterial3: true,
      )
          : ThemeData.light(
        useMaterial3: true,
      ),
      child: ClipRect(
        child: child,
      ),
    );
  }

  Widget _buildKeyboard() {
    return Container(
      height: keyboardHeight,
      width: double.infinity,
      color: const Color(0xFF30343A),
      padding: const EdgeInsets.fromLTRB(
        5,
        7,
        5,
        5,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 24,
            child: Row(
              children: [
                const SizedBox(width: 6),
                const Icon(
                  Icons.keyboard,
                  color: Color(0xFFBFC4C9),
                  size: 15,
                ),
                const Spacer(),
                const Icon(
                  Icons.mic_none,
                  color: Color(0xFFBFC4C9),
                  size: 17,
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _key('q'),
                _key('w'),
                _key('e'),
                _key('r'),
                _key('t'),
                _key('y'),
                _key('u'),
                _key('i'),
                _key('o'),
                _key('p'),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(width: 14),
                _key('a'),
                _key('s'),
                _key('d'),
                _key('f'),
                _key('g'),
                _key('h'),
                _key('j'),
                _key('k'),
                _key('l'),
                const SizedBox(width: 14),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(width: 28),
                _key('z'),
                _key('x'),
                _key('c'),
                _key('v'),
                _key('b'),
                _key('n'),
                _key('m'),
                const SizedBox(width: 28),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _bottomKey('123', flex: 2),
                _bottomKey('spasi', flex: 6),
                _bottomKey('⌫', flex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _key(String text) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 2,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF4A4F55),
          borderRadius: BorderRadius.circular(3),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _bottomKey(
      String text, {
        required int flex,
      }) {
    return Expanded(
      flex: flex,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 2,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF4A4F55),
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _optionButton(
      String label,
      bool selected,
      VoidCallback onPressed,
      ) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: selected
          ? const Icon(
        Icons.check,
        size: 18,
      )
          : const SizedBox(
        width: 18,
        height: 18,
      ),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        backgroundColor: selected
            ? const Color(0xFFCFE7F5)
            : Colors.transparent,
        foregroundColor: const Color(0xFF37474F),
        side: BorderSide(
          color: selected
              ? const Color(0xFFCFE7F5)
              : const Color(0xFFB7C2CA),
          width: 1.5,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}