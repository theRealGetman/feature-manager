part of 'features_screen.dart';

class _FeatureItem extends StatefulWidget {
  const _FeatureItem(
    this.item, {
    required this.onChanged,
  });

  final Feature item;
  final void Function(Object?) onChanged;

  @override
  _FeatureItemState createState() => _FeatureItemState();
}

class _FeatureItemState extends State<_FeatureItem> {
  final TextEditingController textController = TextEditingController();

  Feature get item => widget.item;

  @override
  Widget build(BuildContext context) {
    Widget typeSpecificWidget;
    if (item.valueType == FeatureValueType.toggle) {
      typeSpecificWidget = Switch(
        value: item.value as bool? ?? (item.defaultValue as bool?)!,
        onChanged: (value) {
          _handleOnTap(context);
        },
      );
    } else if (item.valueType == FeatureValueType.doubleNumber ||
        item.valueType == FeatureValueType.integerNumber) {
      typeSpecificWidget = Text(
        item.value == null ? '${item.defaultValue}' : '${item.value}',
        style: Theme.of(context).textTheme.bodyLarge,
      );
    } else {
      typeSpecificWidget = const SizedBox();
    }

    final isWithDescription = item.description.isNotEmpty;

    return ListTile(
      title: Text(
        item.title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: isWithDescription
          ? Text(
              item.description,
              style: Theme.of(context).textTheme.bodySmall,
            )
          : null,
      trailing: typeSpecificWidget,
      onTap: () {
        _handleOnTap(context);
      },
      onLongPress: () {
        _handleOnLongPress(context);
      },
    );
  }

  void _handleOnTap(BuildContext context) {
    if (item.valueType == FeatureValueType.toggle) {
      if (item.value == null) {
        widget.onChanged(!(item.defaultValue as bool));
      } else {
        widget.onChanged(!(item.value as bool));
      }
    } else {
      _showDialog(context);
    }
  }

  Future<void> _handleOnLongPress(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: '${item.value}'));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${item.title}`s value copied to clipboard',
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    Widget textField;
    if (item.valueType == FeatureValueType.doubleNumber ||
        item.valueType == FeatureValueType.integerNumber) {
      textController.text = item.value == null ? '${item.defaultValue}' : '${item.value}';

      textField = TextField(
        keyboardType: item.valueType == FeatureValueType.integerNumber
            ? TextInputType.number
            : const TextInputType.numberWithOptions(decimal: true),
        controller: textController,
        maxLines: item.valueType == FeatureValueType.integerNumber ? 1 : null,
      );
    } else {
      textController.text = item.value as String? ?? (item.defaultValue as String?)!;

      textField = TextField(
        controller: textController,
        maxLines: null,
      );
    }

    final isWithDescription = item.description.isNotEmpty;

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title, style: Theme.of(context).textTheme.bodyLarge),
              if (isWithDescription)
                Row(
                  children: <Widget>[
                    Text(
                      item.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
            ],
          ),
          content: SingleChildScrollView(
            child: textField,
          ),
          actions: [
            TextButton(
              child: Text(
                'Save',
                style:
                    Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.green),
              ),
              onPressed: () {
                final text = textController.text;
                if (item.valueType == FeatureValueType.doubleNumber) {
                  widget.onChanged(
                    text.isEmpty ? 0.0 : double.tryParse(text),
                  );
                } else if (item.valueType == FeatureValueType.integerNumber) {
                  widget.onChanged(
                    text.isEmpty ? 0 : int.tryParse(text),
                  );
                } else {
                  widget.onChanged(text);
                }
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.red),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
