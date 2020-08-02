import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';

class ExploreView extends StatefulWidget {
  final List<Widget> children;
  final bool canSweep;
  final BuildContext context;

  const ExploreView(this.children, this.context, this.canSweep);

  @override
  _ExploreViewState createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> with TickerProviderStateMixin {
  int initial = 1;
  int activeState = 1;
  int activeRect = 1;
  bool canChange = true;
  int max = 4;

  AnimationController _controller;

  RelativeRectTween _inRect;

  RelativeRectTween _outRect;

  RelativeRectTween _outRect2;

  RelativeRectTween _inRect2;

  RelativeRectTween _activeOutRect;
  RelativeRectTween _activeInRect;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 250), vsync: this);
    _inRect = RelativeRectTween(
      begin: RelativeRect.fromLTRB(getWidth(widget.context)/20, getHeight(widget.context)/13, getWidth(widget.context)/6, getHeight(widget.context)/7),
      end: RelativeRect.fromLTRB(getWidth(widget.context)/12, getHeight(widget.context)/20, getWidth(widget.context)/15, getHeight(widget.context)/10),
    );

    _outRect = RelativeRectTween(
      begin: RelativeRect.fromLTRB(getWidth(widget.context)/12, getHeight(widget.context)/20, getWidth(widget.context)/15, getHeight(widget.context)/10),
      end: RelativeRect.fromLTRB(getWidth(widget.context)/1.1, getHeight(widget.context)/13, -getWidth(widget.context), getHeight(widget.context)/7),
    );

    _outRect2 = RelativeRectTween(
      end: RelativeRect.fromLTRB(getWidth(widget.context)/12, getHeight(widget.context)/20, getWidth(widget.context)/15, getHeight(widget.context)/10),
      begin: RelativeRect.fromLTRB(getWidth(widget.context)/1.1, getHeight(widget.context)/13, -getWidth(widget.context), getHeight(widget.context)/7),
    );

    _inRect2 = RelativeRectTween(
      end: RelativeRect.fromLTRB(getWidth(widget.context)/20, getHeight(widget.context)/13, getWidth(widget.context)/6, getHeight(widget.context)/7),
      begin: RelativeRect.fromLTRB(getWidth(widget.context)/12, getHeight(widget.context)/20, getWidth(widget.context)/15, getHeight(widget.context)/10),
    );
    _activeOutRect = _outRect;
    _activeInRect = _inRect;
    activeState = initial;
    activeRect = initial;
    max = widget.children.length;
  }

  gotoDeal(int id){
    Navigator.of(context).pushNamed("/singleOfferDeal");
  }

  changeCard(val){
    if(!canChange || !widget.canSweep)return;
    int newState = activeState;
    int newRect = activeRect;

    if(val == 0){
//      Fluttertoast.showToast(msg: "Thats the last one");
//
//      if(newState == initial)return;

      newState = newState == initial ? max : newState - 1;
      newRect = newRect == initial ? max : newRect - 1;
      _activeOutRect = _outRect;
      _activeInRect = _inRect;
    }
    else{
//      Fluttertoast.showToast(msg: "Thats the first one");
//      if(newState == max)return;
      newState = newState == max ? initial : newState + 1;
      newRect = newRect == max ? initial : newRect + 1;
      _activeOutRect = _inRect2;
      _activeInRect = _outRect2;
    }

    _controller.forward();

    setState(() {
      activeState = newState;
      canChange = false;
    });

    Future.delayed(Duration(milliseconds: 500), (){
      setState(() {
        canChange = true;
        activeRect = newRect;
        _activeOutRect = _outRect;
        _controller.reset();
      });
    });
  }

  getUsableRect(val){
    if(val == activeRect){
      return _activeOutRect.animate(_controller);
    }
    return _activeInRect.animate(_controller);
  }

  setUpChildren(Widget child, int index){
    return PositionedTransition(
      child: AnimatedOpacity(
        opacity: activeState == index ? 1 : 0,
        duration: Duration(milliseconds: 500),
        child: IgnorePointer(
          ignoring: activeState != index,
          child: child,
        ),
      ),
      rect: getUsableRect(index),
    );
  }

  getDefaultBack(BuildContext context){
    return Container(
      margin: EdgeInsets.only(
        top: getHeight(widget.context)/13,
        bottom: getHeight(widget.context)/7,
        right: getWidth(widget.context)/6,
        left: getWidth(widget.context)/25,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(getSize(context, 30))
          ),
          color: colors.lightBlack,
          boxShadow: [
            BoxShadow(
                offset: Offset(-5,10),
                blurRadius: 20,
                spreadRadius: 2,
                color: Colors.black.withOpacity(0.06)
            )
          ]
      ),
    );
  }

  List<Widget> getChildrenList(BuildContext context, List children){
    List<Widget> returnValue = [];
    returnValue.add(getDefaultBack(context));
    for(int i = 0; i<children.length; i++){
      returnValue.add(setUpChildren(children[i], i+1));
    }
    return returnValue;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: SizedBox.expand(
        child: GestureDetector(
          onHorizontalDragUpdate: (details){
            if(details.delta.dx > 5){
              changeCard(0);
            }
            else if(details.delta.dx < -5){
              changeCard(1);
            }
          },
          child: Stack(
            children: getChildrenList(context, widget.children),
          ),
        ),
      ),
    );
  }
}
