import 'package:color_dart/color_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_luckin_coffee/components/button/index.dart';
import 'package:flutter_luckin_coffee/ok/ProjectColor.dart';
import 'package:flutter_luckin_coffee/utils/commonUI.dart';

class CustomDialog {
  final BuildContext context;
  final String title;
  final String content;

  static Widget _title;
  static Widget _content;
  static Widget _bottom;


  /// 提示弹窗
  /// 
  /// ```
  /// @param {BuildContext} context
  /// @param {String} title - 标题（标题为null，表示不显示标题）
  /// @param {String} content - 内容
  /// @param {Function} confirmButtonPress - 点击确认回调
  /// @param {Text} confirmButtonText - 确认的文字
  /// ```
  CustomDialog.alert(this.context, {
    this.title,
    @required this.content,
    Function confirmButtonPress,
    Text confirmButtonText,
  }) {
    _title = _initTitle();
    _content = _initContent();
    _bottom = _initBottom(
      confirmButtonPress: confirmButtonPress,
      confirmButtonText: confirmButtonText == null ? Text('确认') : confirmButtonText
    );


    _initDialog();
  }

  /// 确认弹窗
  /// 
  /// ```
  /// @param {BuildContext} context
  /// @param {String} title - 标题 （标题为null，表示不显示标题）
  /// @param {String} content - 内容
  /// @param {Function} confirmButtonPress - 点击确认回调
  /// @param {Text} confirmButtonText - 确认的文字
  /// @param {Function} cancelButtonPress - 点击取消回调
  /// @param {Text} cancelButtonText - 取消的文字
  /// ```
  CustomDialog.confirm(this.context, {
    this.title,
    @required this.content,
    Function confirmButtonPress,
    Text confirmButtonText,
    Function cancelButtonPress,
    Text cancelButtonText,
  }) {
     _title = _initTitle();
    _content = _initContent();

     _bottom = _initBottom(
      confirmButtonPress: confirmButtonPress,
      confirmButtonText: confirmButtonText == null ? Text('确认') : confirmButtonText,
      cancelButtonText: cancelButtonText == null ? Text('取消') : cancelButtonText,
      cancelButtonPress: cancelButtonPress
    );

    _initDialog();
  }

  // 标题部分
  Widget _initTitle() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 12),        
      child: title == null ? null : Text(title, style: TextStyle(
        color: ProjectColor.blackDarker,
        fontSize: 16,
        fontWeight: FontWeight.bold
      )),
    );
  }

  // 内容部分
  Widget _initContent() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12,horizontal: 15),
      child: Text(content,
        style: TextStyle(
          color: ProjectColor.grayLight,
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      ),
      decoration: BoxDecoration(
        border: ui.borderBottom(),
      ),
    );
  }

  // 底部按钮
  // 如果 confirmButtonText || cancelButtonText 为null 代表不显示改按钮
  Widget _initBottom({
    Text confirmButtonText,
    Text cancelButtonText,
    Function confirmButtonPress,
    Function cancelButtonPress,
  }) {
    return Row(
      children: <Widget>[
        // 取消按钮
        Container(
          child: cancelButtonText == null ? null : Expanded(child: 
            Container(
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: rgba(242, 242, 242,1)))
              ),
              child: Button.normal(
                child: cancelButtonText,
                color: ProjectColor.blackDarker,
                borderRadius: BorderRadius.circular(0),
                onPressed: (){
                  if(cancelButtonPress == null) {
                    Navigator.pop(context);
                  } else {
                    cancelButtonPress();
                  }
                }
              ),
            )
          ),
        ),
        // 确认按钮
        Container(
          child: confirmButtonText == null ? null : Expanded(
            child: Button.normal(
              child: confirmButtonText,
              borderRadius: BorderRadius.circular(0),
              color: ProjectColor.blueLight,
              onPressed: (){
                if(confirmButtonPress == null) {
                  Navigator.pop(context);
                } else {
                  confirmButtonPress();
                }
              }
            ),
          ),
        )
      ],
    );
  }

  // 初始化dialog
  _initDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return Dialog(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _title,
                    _content,
                    _bottom
                  ],
                )
              ),
            );
          }
        );
      }
    );
  }
}
