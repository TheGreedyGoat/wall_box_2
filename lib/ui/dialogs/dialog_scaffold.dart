import 'package:flutter/material.dart';

class DialogScaffold extends StatelessWidget {
  final String title;
  final void Function()? onClose;
  final Widget child;
  final List<Widget>? footer;
  final barColor = Colors.blue;
  const DialogScaffold({
    super.key,
    required this.title,
    this.onClose,
    required this.child,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
          toolbarHeight: 35,
          elevation: 2,
          shadowColor: Colors.grey,
          backgroundColor: barColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          automaticallyImplyLeading: false,
          // leading: Text('heeeey'),
          title: Text(
            title,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                onClose?.call();
              },
              icon: Icon(Icons.close),
            ),
          ],
        ),
        // Row(
        //   mainAxisSize: MainAxisSize.max,
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(title),
        //     IconButton(onPressed: onClose, icon: Icon(Icons.close)),
        //   ],
        // ),
        Expanded(child: child),
        if (footer != null)
          SizedBox(
            height: 30,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: barColor,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: footer!,
                // children: [Text('hello')],
              ),
            ),
          ),
      ],
    );
  }
}
