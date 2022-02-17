import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class DropDownSearch extends StatefulWidget {
  final List<String> listSelect;
  const DropDownSearch({Key? key, required this.listSelect}) : super(key: key);

  @override
  State<DropDownSearch> createState() => _DropDownSearchState();
}

class _DropDownSearchState extends State<DropDownSearch> {
  OverlayEntry? _overlayEntry;
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      onChanged: (value) {},
      onTap: () {
        _overlayEntry = _createOverlay();

        Overlay.of(context)!.insert(_overlayEntry!);
      },
      style: tokenDetailAmount(
        fontSize: 14.0.textScale(),
        color: titleColor,
      ),
      decoration: InputDecoration(
        hintText: "1212",
        hintStyle: textNormal(titleItemEdit.withOpacity(0.5), 14),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        fillColor: Colors.transparent,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
      ),
    );
  }

  OverlayEntry _createOverlay() {
    // ignore: cast_nullable_to_non_nullable
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final offset = renderBox.localToGlobal(Offset.zero);
    return OverlayEntry(
      builder: (context) => SelectCell(
        offset: offset,
        size: size,
        overlayEntry: _overlayEntry,
        listSelect: widget.listSelect,
        textEditingController: textEditingController,
      ),
    );
  }
}

class SelectCell extends StatefulWidget {
  final Offset offset;
  final Size size;
  final OverlayEntry? overlayEntry;
  final List<String> listSelect;
  final TextEditingController textEditingController;
  const SelectCell({
    Key? key,
    required this.offset,
    required this.size,
    required this.overlayEntry,
    required this.listSelect,
    required this.textEditingController,
  }) : super(key: key);

  @override
  _SelectCellState createState() => _SelectCellState();
}

class _SelectCellState extends State<SelectCell> {
  double maxHeight = 0;
  final BehaviorSubject<List<String>> _listSearch = BehaviorSubject();
   List<String> listSearch = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listSearch.sink.add(widget.listSelect);
    widget.textEditingController.addListener(() {
      listSearch = widget.listSelect.where((element) =>
          element.toLowerCase().vietNameseParse() ==
          widget.textEditingController.text.toLowerCase().vietNameseParse()).toList();
      _listSearch.sink.add(listSearch);
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    maxHeight = MediaQuery.of(context).size.height / 2 - 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              widget.overlayEntry?.remove();
            },
            child: SizedBox.expand(
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          Positioned(
            left: widget.offset.dx,
            top: offset(widget.listSelect.length).dy + 3,
            width: widget.size.width,
            child: Material(
              color: Colors.transparent,
              child: _suggestionsBuilder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _suggestionsBuilder() {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height / 2 - 100,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: StreamBuilder<List<String>>(
          stream: _listSearch.stream,
          builder: (context, snapshot) {
            final data = snapshot.data ?? <String>[];
            return Scrollbar(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                reverse: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final result = data[index];
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      width: double.infinity,
                      decoration:
                          BoxDecoration(color: smokeColor.withOpacity(0.1)),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        result,
                        style: textNormal(titleColor, 14),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }

  Offset offset(int countItem) {
    if (countItem * 40 > maxHeight) {
      return Offset(0, widget.offset.dy - maxHeight);
    } else {
      return Offset(0, widget.offset.dy - (countItem * 12));
    }
  }
}
