import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zad_almumin/classes/zikr_data.dart';
import 'package:zad_almumin/database/sqldb.dart';
import 'package:zad_almumin/services/audio_service.dart';
import '../constents/icons.dart';

class ZikrBlockButtons extends StatefulWidget {
  const ZikrBlockButtons({Key? key, required this.zikrData, this.onDeleteFromFavorite}) : super(key: key);
  final ZikrData zikrData;
  final Function? onDeleteFromFavorite;
  @override
  State<ZikrBlockButtons> createState() => _ZikrBlockButtonsState();
}

class _ZikrBlockButtonsState extends State<ZikrBlockButtons> {
  bool isCopyed = false;
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
      children: [
        IconButton(
          onPressed: () => copy(),
          icon: isCopyed ? MyIcons.copyFilled : MyIcons.copy,
        ),
        IconButton(
          onPressed: () => share(),
          icon: MyIcons.share,
        ),
        IconButton(
          onPressed: () => favorite(),
          icon: widget.zikrData.isFavorite ? MyIcons.favoriteFilled : MyIcons.favorite,
        ),
      ],
    );
  }

  copy() {
    Clipboard.setData(ClipboardData(text: widget.zikrData.content));

    setState(() {
      isCopyed = true;
    });
    Future.delayed(Duration(seconds: 2)).then((_) {
      setState(() {
        isCopyed = false;
      });
    });

    Fluttertoast.showToast(
      msg: 'تم نسخ النص بنجاح',
    );

    Clipboard.getData(Clipboard.kTextPlain).then((value) {});
  }

  share() {
    Share.share(widget.zikrData.content, subject: widget.zikrData.title);
  }

  favorite() async {
    SqlDb sqlDb = SqlDb();
    String toastText = '';
    if (widget.zikrData.isFavorite) {
      sqlDb.deleteData(SqlDb.dbName, 'content="${widget.zikrData.content}"');
      toastText = 'تم حذف النص من المفضلة';
      Get.find<AudioServiceCtr>().stopAudioById(widget.zikrData.numberInQuran);
    } else {
      sqlDb.insertData('favorite', {
        'zikrType': widget.zikrData.zikrType.index,
        'title': widget.zikrData.title,
        'content': widget.zikrData.content,
        'description': widget.zikrData.description,
        'numberInQuran': widget.zikrData.numberInQuran,
        'count': -1,
      });
      toastText = 'تم إضافة النص إلى المفضلة';
    }
    Fluttertoast.showToast(msg: toastText, backgroundColor: Colors.black);
    if (widget.zikrData.isFavorite) widget.onDeleteFromFavorite?.call();

    setState(() {
      widget.zikrData.isFavorite = !widget.zikrData.isFavorite;
    });
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
