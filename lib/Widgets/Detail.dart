import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';
import 'package:upflutter/Model/ListItem.dart';

class Detail extends StatelessWidget {
  final Color primary = Color(0xff456990);
  final Color primaryTwo = Color(0xff434755);
  final Color green = Color(0xff49BEAA);

  Detail({@required this.item});

  ListItem item;

  String get _name {
    if (item.fileName == null) return "";
    if (item.fileName.length < 30) return item.fileName;
    return item.fileName.substring(0, 29) + "...";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          decoration: BoxDecoration(
            color: primary,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: primaryTwo.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Icon(
                          Icons.insert_drive_file,
                          color: primaryTwo,
                          size: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text(
                          _name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: primaryTwo,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
                child: InkWell(
                  focusColor: primary,
                  onTap: () => {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Container(
                            decoration: BoxDecoration(
                                color: primary,
                                borderRadius:
                                    new BorderRadius.all(Radius.circular(10))),
                            height: 350,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: QrImage(
                                      data: item.link,
                                      gapless: true,
                                      version: QrVersions.auto,
                                      size: 250.0,
                                      foregroundColor: green,
                                    ),
                                  ),
                                  Divider(
                                    color: primaryTwo,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    child: Center(
                                      child: InkWell(
                                        focusColor: primaryTwo,
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Icon(
                          Icons.crop_original,
                          color: primaryTwo,
                          size: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text(
                          "Generate qr code",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                focusColor: primary,
                onTap: () => {Share.share(item.link)},
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Icon(
                          Icons.share,
                          color: primaryTwo,
                          size: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text(
                          "Share link",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                focusColor: primary,
                onTap: () => {
                  Clipboard.setData(ClipboardData(text: item.link)),
                  Fluttertoast.showToast(
                      msg: "Link coppied",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                      fontSize: 16.0)
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Icon(
                          Icons.content_copy,
                          color: primaryTwo,
                          size: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text(
                          "Copy to clipboard",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  /// Share link to other apps
  void showQr(BuildContext context) {}
}
