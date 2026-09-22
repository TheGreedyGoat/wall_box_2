// import 'package:dotted_border/dotted_border.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:my_utils/widgets/dialogs/process_indicator_dialog.dart';
// import 'package:wall_box_2/logic/services/parser/wall_box_parser.dart';
// import 'package:wallbox_logs/mid_layer/data/log_file_data.dart';

// /// A Page used to load new WalboxLog files into the app
// class FileUpload extends StatefulWidget {
//   /// A Page used to load new WalboxLog files into the app
//   const FileUpload({super.key});

//   @override
//   State<FileUpload> createState() => _FileUploadState();
// }

// class _FileUploadState extends State<FileUpload> {
//   static final borderRadius = Radius.circular(10.0);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             height: 300,
//             child: GestureDetector(
//               onTap: () async {
//                 final filePickerResultFuture = WallBoxParser.instance
//                     .processFilePickerResult(
//                       await FilePicker.pickFiles(
//                         dialogTitle: 'Logdatei wählen',
//                         type: FileType.custom,
//                         allowMultiple: true,
//                         allowedExtensions: ['csv'],
//                         lockParentWindow: true,
//                       ),
//                       (fileName) async {
//                         await _changeExistingFileNameDialog(
//                           context,
//                           fileName,
//                         );
//                       },
//                       (content, fileName) async {
//                         return await _lineErrorDialog(content, fileName);
//                       },
//                     );
//                 if (context.mounted) {
//                   await showProcessIndicatorDialaog(
//                     context,
//                     50.0,
//                     filePickerResultFuture,
//                   );
//                 }
//                 int numSuccessful = await filePickerResultFuture;
//                 if (!context.mounted) return;
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text(
//                       numSuccessful == 0
//                           ? 'Datei(en) wurden nicht eingelesen'
//                           : '$numSuccessful Datei${numSuccessful > 1 ? 'en' : ''} erfolgreich eingelesen',
//                     ),
//                   ),
//                 );
//                 setState(
//                   () {},
//                 );
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).colorScheme.secondaryContainer,
//                   borderRadius: BorderRadius.all(borderRadius),
//                 ),
//                 child: DottedBorder(
//                   options: RoundedRectDottedBorderOptions(
//                     radius: borderRadius,
//                     dashPattern: const [8, 8],
//                     strokeWidth: 5,
//                   ),
//                   child: Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.upload_file_sharp,
//                           size: 50,
//                         ),

//                         Text(
//                           'Hier klicken, um Logdateien hochzuladen',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           OutlinedButton(
//             onPressed: () async => await LogFileData.openDirectory(),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(Icons.folder_open_sharp),
//                 Text(' zuvor geladene Dateien'),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<bool> _lineErrorDialog(String line, String fileName) async {
//     return await showDialog<bool>(
//           barrierDismissible: false,
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: Text('Problem beim Lesen von Datei $fileName'),
//               content: Column(
//                 children: [
//                   Text('Die Zeile'),
//                   Text(line),
//                   Text('kann nicht gelesen werden.'),
//                 ],
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context, true),
//                   child: Text('Datei überspringen'),
//                 ),
//                 TextButton(
//                   onPressed: () => Navigator.pop(context, false),
//                   child: Text('zugeh. Transaktion ignorieren'),
//                 ),
//               ],
//             );
//           },
//         ) ??
//         true;
//   }

//   Future<void> _changeExistingFileNameDialog(
//     BuildContext context,
//     String fileName,
//   ) async => await showDialog<String>(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Text('Datei $fileName wurde nicht eingelesen.'),
//         content: ConstrainedBox(
//           constraints: BoxConstraints(minWidth: 200, maxWidth: 200),
//           child: Text(
//             softWrap: true,
//             'Es existiert bereits eine Deti mit derselben Säulen-ID und demselben Generierungsdatum',
//             style: TextStyle(color: Colors.red),
//           ),
//         ),

//         actions: [
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text('okay'),
//           ),
//         ],
//       );
//     },
//   );
// }
