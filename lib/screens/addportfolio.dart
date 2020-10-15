import 'package:flutter/material.dart';
import 'package:folio/components/primarytextfield.dart';
import 'package:folio/components/roundbutton.dart';
import 'package:folio/components/title.dart';
import 'package:folio/constants/colors.dart';
import 'package:folio/logic/portfolio.dart';
import 'package:folio/logic/provider.dart';
import 'package:folio/logic/utils.dart';
import 'package:folio/screens/portfoliossceen.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';

class Addportoflioscreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> globalKey;

  Addportoflioscreen({this.globalKey});

  @override
  _AddportoflioscreenState createState() => _AddportoflioscreenState();
}

class _AddportoflioscreenState extends State<Addportoflioscreen> {
  final projecttittle = TextEditingController(),
      date = TextEditingController(),
      description = TextEditingController(),
      technology = TextEditingController(),
      confirmdate = TextEditingController();

  bool vprojecttittle = false,
      vdate = false,
      vdescription = false,
      vtechnology = false,
      vconfirmdate = false;
  String eprojecttittle = null,
      edate = null,
      edescription = null,
      etechnology = null;
  String errortext;
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';

  var portfolioid;

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Upload Image",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      print(resultList.length);
      print((await resultList[0].getThumbByteData(122, 100)));
      print((await resultList[0].getByteData()));
      print((await resultList[0].metadata));
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      images = resultList;
      _error = error;
    });
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 2,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        print(asset.getByteData(quality: 100));
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: ThreeDContainer(
            backgroundColor: MultiPickerApp.darker,
            backgroundDarkerColor: MultiPickerApp.darker,
            height: 50,
            width: 50,
            borderDarkerColor: k_backgroundcolor,
            // borderColor: Colors.lightBlue,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: AssetThumb(
                asset: asset,
                width: 100,
                height: 100,
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    String email = Provider.of<Userprovider>(context).email;
    return Container(
      decoration: BoxDecoration(gradient: k_gradientfolio),
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Tiltle(),
            centerTitle: true,
          ),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              width: double.infinity,
              height: double.infinity,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        elevation: 30,
                        child: Container(
                          width: double.infinity,
                          height: 300,
                          child: buildGridView(),
                        ),
                      ),
                    ),
                    Roundbutton(
                      label: 'add photo',
                      func: loadAssets,
                    ),
                    Expanded(
                      child: Container(
                        // height: 410,
                        child: ListView(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Maintextfield(
                              controller: projecttittle,
                              validate: vprojecttittle,
                              hint: "project tittle",
                              error: eprojecttittle,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Maintextfield(
                              controller: date,
                              validate: vdate,
                              hint: "project date",
                              error: edate,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Maintextfield(
                              controller: description,
                              validate: vdescription,
                              hint: "project description",
                              error: edescription,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Maintextfield(
                              controller: technology,
                              validate: vtechnology,
                              hint: "project technology",
                              error: etechnology,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Roundbutton(
                              label: 'add',
                              func: () async {
                                setState(() {
                                  projecttittle.text.isEmpty
                                      ? vprojecttittle = true
                                      : vprojecttittle = false;

                                  date.text.isEmpty
                                      ? vdate = true
                                      : vdate = false;

                                  description.text.isEmpty
                                      ? vdescription = true
                                      : vdescription = false;

                                  technology.text.isEmpty
                                      ? vtechnology = true
                                      : vtechnology = false;
                                });
                                if (!projecttittle.text.isEmpty &&
                                    !date.text.isEmpty &&
                                    !description.text.isEmpty &&
                                    !technology.text.isEmpty) {
                                  final connection =
                                      await Provider.of<Userprovider>(context,
                                              listen: false)
                                          .connection();

                                  if (connection) {
                                    Portfolio x = Portfolio(
                                        tittle: projecttittle.text,
                                        description: description.text,
                                        technologies: technology.text,
                                        date: date.text,
                                        email: email,
                                        images: images);
                                    bool y = x.uploadportfolio();

                                    print(y);

                                    if (y) {
                                      SnackBar snackbar = SnackBar(
                                          content:
                                              Text('Uploaded Successfully'));
                                      widget.globalKey.currentState
                                          .showSnackBar(snackbar);
                                    }
                                    setState(() {
                                      images = [];
                                      // imageUrls = [];
                                    });
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailsPage(
                                                  useremail: email,
                                                )));
                                  } else {
                                    Provider.of<Userprovider>(context,
                                            listen: false)
                                        .noconnection(context);
                                  }
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
