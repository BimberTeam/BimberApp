import 'dart:io';
import 'dart:typed_data' show Uint8List;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';

class CustomFormBuilderImagePicker extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final List initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueTransformer valueTransformer;
  final ValueChanged onChanged;
  final FormFieldSetter onSaved;

  final BoxDecoration imageDecoration;

  final double imageWidth;
  final double imageHeight;
  final EdgeInsets imageMargin;
  final Color iconColor;

  /// Optional maximum height of image; see [ImagePicker].
  final double maxHeight;

  /// Optional maximum width of image; see [ImagePicker].
  final double maxWidth;

  /// The imageQuality argument modifies the quality of the image, ranging from
  /// 0-100 where 100 is the original/max quality. If imageQuality is null, the
  /// image with the original quality will be returned. See [ImagePicker].
  final int imageQuality;

  /// Use preferredCameraDevice to specify the camera to use when the source is
  /// `ImageSource.camera`. The preferredCameraDevice is ignored when source is
  /// `ImageSource.gallery`. It is also ignored if the chosen camera is not
  /// supported on the device. Defaults to `CameraDevice.rear`. See [ImagePicker].
  final CameraDevice preferredCameraDevice;

  final int maxImages;

  final Widget cameraIcon;
  final Widget galleryIcon;
  final Widget cameraLabel;
  final Widget galleryLabel;
  final EdgeInsets bottomSheetPadding;

  const CustomFormBuilderImagePicker({
    Key key,
    @required this.attribute,
    this.initialValue,
    this.validators = const [],
    this.valueTransformer,
    this.imageDecoration,
    this.onChanged,
    this.imageWidth = 130,
    this.imageHeight = 130,
    this.imageMargin,
    this.readOnly = false,
    this.onSaved,
    this.decoration = const InputDecoration(),
    this.iconColor,
    this.maxHeight,
    this.maxWidth,
    this.imageQuality,
    this.preferredCameraDevice = CameraDevice.rear,
    this.maxImages,
    this.cameraIcon = const Icon(Icons.camera_enhance),
    this.galleryIcon = const Icon(Icons.image),
    this.cameraLabel = const Text('Camera'),
    this.galleryLabel = const Text('Gallery'),
    this.bottomSheetPadding = const EdgeInsets.all(0),
  }) : super(key: key);

  @override
  _CustomFormBuilderImagePickerState createState() =>
      _CustomFormBuilderImagePickerState();
}

class _CustomFormBuilderImagePickerState
    extends State<CustomFormBuilderImagePicker> {
  bool _readOnly = false;
  List _initialValue;
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  FormBuilderState _formState;

  bool get _hasMaxImages {
    if (widget.maxImages == null) {
      return false;
    } else {
      return /*_fieldKey.currentState.value != null &&*/ _fieldKey
              .currentState.value.length >=
          widget.maxImages;
    }
  }

  @override
  void initState() {
    _formState = FormBuilder.of(context);
    _formState?.registerFieldKey(widget.attribute, _fieldKey);
    _initialValue = List.of(widget.initialValue ??
        (_formState.initialValue.containsKey(widget.attribute)
            ? _formState.initialValue[widget.attribute]
            : []));
    super.initState();
  }

  @override
  void dispose() {
    _formState?.unregisterFieldKey(widget.attribute);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _readOnly = _formState?.readOnly == true || widget.readOnly;

    return FormField<List>(
      key: _fieldKey,
      enabled: !_readOnly,
      initialValue: _initialValue,
      validator: (val) =>
          FormBuilderValidators.validateValidators(val, widget.validators),
      onSaved: (val) {
        var transformed;
        if (widget.valueTransformer != null) {
          transformed = widget.valueTransformer(val);
          _formState?.setAttributeValue(widget.attribute, transformed);
        } else {
          _formState?.setAttributeValue(widget.attribute, val);
        }
        if (widget.onSaved != null) {
          widget.onSaved(transformed ?? val);
        }
      },
      builder: (field) {
        var theme = Theme.of(context);

        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: !_readOnly,
            errorText: field.errorText,
            // ignore: deprecated_member_use_from_same_package
            labelText: widget.decoration.labelText,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 8),
              Container(
                height: widget.imageHeight,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...(field.value.map<Widget>((item) {
                      return Stack(
                        alignment: Alignment.topRight,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: widget.imageDecoration.borderRadius ??
                                BorderRadius.zero,
                            child: Container(
                              decoration: widget.imageDecoration ??
                                  const BoxDecoration(),
                              width: widget.imageWidth,
                              height: widget.imageHeight,
                              margin: widget.imageMargin,
                              child: kIsWeb
                                  ? Image.memory(item, fit: BoxFit.cover)
                                  : item is String
                                      ? Image.network(item, fit: BoxFit.cover)
                                      : Image.file(item, fit: BoxFit.cover),
                            ),
                          ),
                          if (!_readOnly)
                            InkWell(
                              onTap: () {
                                field.didChange([...field.value]..remove(item));
                                widget.onChanged?.call(field.value);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(.7),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                height: 22,
                                width: 22,
                                child: const Icon(
                                  Icons.close,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      );
                    }).toList()),
                    if (!_readOnly && !_hasMaxImages)
                      GestureDetector(
                        child: ClipRRect(
                          borderRadius: widget.imageDecoration.borderRadius ??
                              BorderRadius.zero,
                          child: Container(
                              width: widget.imageWidth,
                              height: widget.imageHeight,
                              child: Icon(Icons.camera_enhance,
                                  color: _readOnly
                                      ? theme.disabledColor
                                      : widget.iconColor ?? theme.primaryColor),
                              color: (_readOnly
                                      ? theme.disabledColor
                                      : widget.iconColor ?? theme.primaryColor)
                                  .withAlpha(50)),
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) {
                              return ImageSourceBottomSheet(
                                maxHeight: widget.maxHeight,
                                maxWidth: widget.maxWidth,
                                imageQuality: widget.imageQuality,
                                preferredCameraDevice:
                                    widget.preferredCameraDevice,
                                cameraIcon: widget.cameraIcon,
                                galleryIcon: widget.galleryIcon,
                                cameraLabel: widget.cameraLabel,
                                galleryLabel: widget.galleryLabel,
                                onImageSelected: (image) {
                                  field.didChange([...field.value, image]);
                                  widget.onChanged?.call(field.value);
                                  Navigator.of(context).pop();
                                },
                                onImage: (image) {
                                  field.didChange([...field.value, image]);
                                  widget.onChanged?.call(field.value);
                                  Navigator.of(context).pop();
                                },
                                bottomSheetPadding: widget.bottomSheetPadding,
                              );
                            },
                          );
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ImageSourceBottomSheet extends StatelessWidget {
  /// Optional maximum height of image
  final double maxHeight;

  /// Optional maximum width of image
  final double maxWidth;

  /// The imageQuality argument modifies the quality of the image, ranging from
  /// 0-100 where 100 is the original/max quality. If imageQuality is null, the
  /// image with the original quality will be returned.
  final int imageQuality;

  /// Use preferredCameraDevice to specify the camera to use when the source is
  /// `ImageSource.camera`. The preferredCameraDevice is ignored when source is
  /// `ImageSource.gallery`. It is also ignored if the chosen camera is not
  /// supported on the device. Defaults to `CameraDevice.rear`.
  final CameraDevice preferredCameraDevice;

  /// Callback when an image is selected.
  ///
  /// **Note**: This will work on web platform whereas [onImageSelected] will not.
  final Function(Uint8List) onImage;

  /// Callback when an image is selected.
  ///
  /// **Warning**: This will _NOT_ work on web platform because [File] is not
  /// available.
  final Function(File) onImageSelected;

  final Widget cameraIcon;
  final Widget galleryIcon;
  final Widget cameraLabel;
  final Widget galleryLabel;
  final EdgeInsets bottomSheetPadding;

  ImageSourceBottomSheet({
    Key key,
    this.maxHeight,
    this.maxWidth,
    this.imageQuality,
    this.preferredCameraDevice = CameraDevice.rear,
    this.onImage,
    this.onImageSelected,
    this.cameraIcon,
    this.galleryIcon,
    this.cameraLabel,
    this.galleryLabel,
    this.bottomSheetPadding,
  })  : assert(null != onImage || null != onImageSelected),
        super(key: key);

  Future<void> _onPickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(
      source: source,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
      imageQuality: imageQuality,
      preferredCameraDevice: preferredCameraDevice,
    );
    if (null != pickedFile) {
      if (kIsWeb) {
        if (null != onImage) {
          onImage(await pickedFile.readAsBytes());
        }
      } else {
        if (null != onImageSelected) {
          // Warning:  this will not work on the web platform because pickedFile
          // will instead point to a network resource.
          final imageFile = File(pickedFile.path);
          assert(null != imageFile);
          onImageSelected(imageFile);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: bottomSheetPadding,
      child: Wrap(
        children: <Widget>[
          ListTile(
            leading: cameraIcon,
            title: cameraLabel,
            onTap: () => _onPickImage(ImageSource.camera),
          ),
          ListTile(
            leading: galleryIcon,
            title: galleryLabel,
            onTap: () => _onPickImage(ImageSource.gallery),
          )
        ],
      ),
    );
  }
}
