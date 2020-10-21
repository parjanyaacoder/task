import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
class ImageInput extends StatefulWidget {
  @required final Function onSelectImage;

  const ImageInput({Key key, this.onSelectImage}) : super(key: key);


  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  
 File _storedImage;

 Future<void>  _takePicture() async {
   final imageFile =  await ImagePicker.pickImage(source:ImageSource.camera,
   maxHeight: 600,
   );
   if(imageFile == null )
     return ;
   setState(() {
     _storedImage = imageFile;
   });
   final appDirectory = await syspaths.getApplicationDocumentsDirectory();
  final fileName =  path.basename(imageFile.path);
   final savedImage = await imageFile.copy('${appDirectory.path}/$fileName');
   widget.onSelectImage(savedImage,context);
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1,color: Colors.grey)
          ),
          child: _storedImage != null ? Image.file(_storedImage,fit: BoxFit.cover,width:double.infinity,) : Text('No Image Taken',textAlign: TextAlign.center,),
        ),
        SizedBox(width: 10,),
        Expanded(child: FlatButton.icon(icon: Icon(Icons.camera),label: Text('Take Picture'),onPressed: _takePicture)),
      ],
    );
  }
}
