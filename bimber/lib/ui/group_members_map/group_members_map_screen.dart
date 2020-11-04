import 'dart:async';
import 'dart:typed_data';
import 'package:bimber/models/location.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/ui/common/fixtures.dart';
import 'package:bimber/ui/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'package:tinycolor/tinycolor.dart';

class MembersMap extends StatefulWidget {
  final List<User> groupMembers;
  final String meId;

  const MembersMap({Key key, this.groupMembers, this.meId}) : super(key: key);

  @override
  _MembersMapState createState() => _MembersMapState();
}

class _MembersMapState extends State<MembersMap> {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set();
  ClusterManager _manager;
  LatLng _center;
  List<ClusterItem<User>> items;

  Future<ui.Image> getImageFromUrl(String url) async {
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(url)).load(url))
        .buffer
        .asUint8List();

    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(bytes, (ui.Image img) {
      return completer.complete(img);
    });

    return completer.future;
  }

  LatLng fromLocation(Location location) {
    return LatLng(location.latitude, location.longtitude);
  }

  @override
  void initState() {
    super.initState();
    _center = fromLocation(widget.groupMembers
        .firstWhere((user) => user.id == widget.meId)
        .latestLocation);

    items = widget.groupMembers
        .map((user) =>
            ClusterItem<User>(fromLocation(user.latestLocation), item: user))
        .toList();

    _manager = ClusterManager<User>(items, _updateMarkers,
        markerBuilder: _markerBuilder, initialZoom: 11, stopClusteringZoom: 12);

    setState(() {});
  }

  void _updateMarkers(Set<Marker> markers) {
    setState(() {
      this._markers = markers;
    });
  }

  Future<Marker> Function(Cluster<User>) get _markerBuilder => (cluster) async {
        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          infoWindow: cluster.isMultiple
              ? InfoWindow()
              : InfoWindow(title: cluster.items.first.name),
          icon: await _getMarkerBitmap(cluster.count, cluster.items),
        );
      };

  Future<BitmapDescriptor> _getMarkerBitmap(
      int clusterSize, Iterable<User> items) async {
    final double size = 200;

    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Paint paint1 = Paint()..color = indigoDye;
    final Paint paint2 = Paint()
      ..color = TinyColor(lemonMeringue).darken(10).color;

    //draw circles
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.3, paint1);

    //if cluster size == 1 paint user image
    if (clusterSize == 1) {
      // Oval for the image
      Rect oval = Rect.fromCircle(
          center: Offset(size / 2, size / 2), radius: size / 2.3);

      // Add path for oval image
      canvas.clipPath(Path()..addOval(oval));

      // Add image
      ui.Image image = await getImageFromUrl(
          Fixtures.getRandomPresidentImageUrl(items.first.id));
      paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.cover);
    } else {
      //if cluster size > 1 paint number of users in cluster
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);

      painter.text = TextSpan(
        text: clusterSize.toString(),
        style: TextStyle(
            fontSize: size / 3,
            color: TinyColor(lemonMeringue).darken(10).color,
            fontWeight: FontWeight.normal),
      );

      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    // Convert canvas to image
    final ui.Image markerAsImage = await pictureRecorder
        .endRecording()
        .toImage(size.toInt(), size.toInt());

    // Convert image to bytes
    final ByteData byteData =
        await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.primaryVariant,
        ),
        elevation: 1.0,
        title: Padding(
          padding: EdgeInsets.only(left: 8.00),
          child: Text(
            "Członkowie grupy",
            style: TextStyle(
                color: Theme.of(context).colorScheme.primaryVariant,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                fontFamily: 'Baloo'),
          ),
        ),
      ),
      body: GoogleMap(
        markers: _markers,
        onMapCreated: (controller) {
          _controller.complete(controller);
          _manager.setMapController(controller);
        },
        onCameraMove: _manager.onCameraMove,
        onCameraIdle: _manager.updateMap,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
    );
  }
}
