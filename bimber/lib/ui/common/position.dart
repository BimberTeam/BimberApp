class Position {
  double top;
  double bottom;
  double left;
  double right;

  Position({this.top, this.right, this.left, this.bottom});

  Position copy() {
    return Position(top: top, bottom: bottom, left: left, right: right);
  }
}
