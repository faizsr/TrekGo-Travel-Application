import 'package:flutter/material.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';

class CustomAlertDialog extends StatefulWidget {
  final String? title;
  final String? description;
  final bool? disableActionBtn;
  final String? popBtnText;
  final Function()? onTap;
  final String? actionBtnTxt;
  const CustomAlertDialog({
    super.key,
    this.title,
    this.description,
    this.onTap,
    this.disableActionBtn = false,
    this.popBtnText,
    this.actionBtnTxt,
  });

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    setStatusBarColor(
      const Color(0x73e5e6f6),
    );
    return Dialog(
      elevation: 0,
      backgroundColor: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const SizedBox(height: 15),
        Text(
          widget.title ?? '',
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Text(
            widget.description ?? '',
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 10),
        const Divider(height: 1.2),
        widget.disableActionBtn == false
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 48,
                child: InkWell(
                  highlightColor: Colors.grey[200],
                  onTap: widget.onTap,
                  child: Center(
                    child: Text(
                      widget.actionBtnTxt ?? 'Delete',
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Color(0xFF1285b9),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        Divider(height: widget.disableActionBtn == false ? 1 : 0),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 48,
          child: InkWell(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15),
            ),
            highlightColor: Colors.grey[200],
            onTap: () {
              Navigator.of(context).pop('refresh');
            },
            child: Center(
              child: Text(
                widget.popBtnText != null ? widget.popBtnText ?? '' : 'Cancel',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
    resetStatusBarColor();
  }
}
