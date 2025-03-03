import 'package:flutter/material.dart';

class CustomSearch extends StatefulWidget {
  final Function(String?) onSearch;
  final Color fillColor;
  final TextStyle? textStyle;
  const CustomSearch({
    super.key,
    required this.onSearch,
    this.fillColor = Colors.transparent,
    this.textStyle,
  });

  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  final TextEditingController _searchController = TextEditingController();
  String _lastValue = '';

  @override
  void initState() {
    _searchController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _searchController,
            obscureText: false,
            style: widget.textStyle ?? Theme.of(context).textTheme.titleSmall,
            onFieldSubmitted: (value) {
              _lastValue = value.trim();
              widget.onSearch(_lastValue);
              setState(() {});
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withAlpha(40),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
              hintText: 'Search',
              hintStyle: widget.textStyle ??
                  Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
              suffixIcon: _lastValue.isNotEmpty
                  ? InkWell(
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        _lastValue = '';
                        _searchController.clear();
                        widget.onSearch(null);
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                    )
                  : null,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: InkWell(
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    _lastValue = _searchController.text.trim();
                    widget.onSearch(_lastValue);
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
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
