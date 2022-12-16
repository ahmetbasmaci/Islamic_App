import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zad_almumin/services/audio_background_service.dart';
import 'package:zad_almumin/classes/zikr_data.dart';
import 'package:zad_almumin/database/sqldb.dart';
import '../constents/icons.dart';

class ZikrBlockButtons extends StatefulWidget {
  const ZikrBlockButtons({Key? key, required this.zikrData, this.onDeleteFromFavorite}) : super(key: key);
  final ZikrData zikrData;
  final Function? onDeleteFromFavorite;
  @override
  State<ZikrBlockButtons> createState() => _ZikrBlockButtonsState();
}

class _ZikrBlockButtonsState extends State<ZikrBlockButtons> {
  @override
  void initState() {
    super.initState();
    checkIfIsFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [copyButton(), shareButton(), favoriteButton()],
    );
  }

  favoriteButton() {
    return StatefulBuilder(builder: ((context, favoriteSetState) {
      return IconButton(
        onPressed: () {
          SqlDb sqlDb = SqlDb();
          String toastText = '';
          if (widget.zikrData.isFavorite) {
            sqlDb.deleteData(SqlDb.dbName, 'content="${widget.zikrData.content}"');
            toastText = 'تم حذف النص من المفضلة';
            Get.find<AudioBacgroundService>().stopAudio();
          } else {
            sqlDb.insertData('favorite', {
              'zikrType': widget.zikrData.zikrType.index,
              'title': widget.zikrData.title,
              'content': widget.zikrData.content,
              'description': widget.zikrData.description,
              'numberInQuran': widget.zikrData.ayahNumber,
              'surahNumber': widget.zikrData.surahNumber,
              'count': -1,
            });
            toastText = 'تم إضافة النص إلى المفضلة';
          }
          Fluttertoast.showToast(msg: toastText, backgroundColor: Colors.black);
          if (widget.zikrData.isFavorite) widget.onDeleteFromFavorite?.call();

          widget.zikrData.isFavorite = !widget.zikrData.isFavorite;
          favoriteSetState(() {});
        },
        icon: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: widget.zikrData.isFavorite ? MyIcons.favoriteFilled() : Container(child: MyIcons.favorite()),
        ),
      );
    }));
  }

  copyButton() {
    bool isCopyed = false;
    return StatefulBuilder(builder: ((context, copySetState) {
      return IconButton(
        onPressed: () {
          Clipboard.setData(ClipboardData(text: widget.zikrData.content));

          copySetState(() {
            isCopyed = true;
          });
          Future.delayed(Duration(seconds: 2)).then((_) {
            copySetState(() {
              isCopyed = false;
            });
          });

          Fluttertoast.showToast(
            msg: 'تم نسخ النص بنجاح',
          );

          Clipboard.getData(Clipboard.kTextPlain).then((value) {});
        },
        icon: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: isCopyed ? MyIcons.copyFilled : Container(child: MyIcons.copy)),
      );
    }));
  }

  shareButton() {
    return StatefulBuilder(
      builder: ((context, copySetState) {
        return IconButton(
          onPressed: () => Share.share(widget.zikrData.content, subject: widget.zikrData.title),
          icon: AnimatedSwitcher(duration: Duration(milliseconds: 300), child: MyIcons.share),
        );
      }),
    );
  }

  void checkIfIsFavorite() async {
    SqlDb sqlDb = SqlDb();
    List<Map> data = await sqlDb.readData(SqlDb.dbName);
    for (var i = 0; i < data.length; i++) {
      if (data[i]['content'] == widget.zikrData.content) {
        if (mounted) {
          setState(() {
            widget.zikrData.isFavorite = true;
          });
        }
        break;
      }
    }
  }
}
