import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_cache_builder.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FullScreenLoading extends StatefulWidget {
  final String animationUrl;
  final String animationName;
  final bool loading;
  final String message;
  final Widget child;
  FullScreenLoading(
    this.animationUrl, {
    @required this.animationName,
    @required this.child,
    @required this.loading,
    this.message,
  });
  @override
  _FullScreenLoadingState createState() => _FullScreenLoadingState();
}

class _FullScreenLoadingState extends State<FullScreenLoading> {
//  final FlareControls _controls = FlareControls();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Material(
      child: Stack(
        children: <Widget>[
          widget.child,
          widget.loading
              ? Container(
                  height: size.height,
                  width: size.width,
                  color: Colors.white.withOpacity(.75),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: size.height * .25,
                          child: FlareCacheBuilder(
                            [
                              AssetFlare(
                                  bundle: rootBundle, name: widget.animationUrl)
                            ],
                            builder: (context, loaded) {
                              return !loaded
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        CircularProgressIndicator()
                                      ],
                                    )
                                  : FlareActor(
                                      widget.animationUrl,
                                      animation: widget.animationName,
                                      fit: BoxFit.contain,
                                      alignment: Alignment.center,
                                    );
                            },
                          ),
                        ),
                        SizedBox(height: size.height * .05),
                        Text(
                          widget.message ?? "Loading...",
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 22,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
