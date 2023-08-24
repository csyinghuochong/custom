#target photoshop

app.bringToFront();

// save ruler info so it can be restored later
var OrigRulerUnits = preferences.rulerUnits;
preferences.rulerUnits = Units.PIXELS;
preferences.typeUnits = TypeUnits.PIXELS;

// settings for the active document
var AppActiveDoc     = app.activeDocument;
var ActiveDocWidth    = AppActiveDoc.width.value;
var ActiveDocHeight   = AppActiveDoc.height.value;

// global variables
var DocName = "";
var TargetImageFolders;
var CenteredLayerData;
var CurrenTextLayerIndex = 0;
var LayersCount = AppActiveDoc.layers.length;

// windo variables
var win, windowResource;
var createProgressWindow, progressWindow;

// xml string
var xmlString ="<?xml version=\"1.0\" encoding=\"gbk\"?>\n";

// add header 
//xmlString += "<npsd DocWidth=\"" + ActiveDocWidth + "\" DocHeight=\"" + ActiveDocHeight + "\">\n";
xmlString += "<objs>\n";

// fix bounds and center of this layer
function FixBounds(doc, layer) 
{
    this.layerWidth = layer.bounds[2].value - layer.bounds[0].value;
    this.layerHeight = layer.bounds[3].value - layer.bounds[1].value;

    this.middleCenterX = this.layerWidth / 2 + layer.bounds[0].value;
    this.middleCenterY = this.layerHeight / 2 + layer.bounds[1].value;

    this.center = this.middleCenterX + ", " + this.middleCenterY;


    return this;
}

function ExportAllLayerInfo(docs)
{
    //var docs = app.documents;
    var mystr = "";
    for (var i = 0; i < docs.layerSets.length; i++)
    {
        var layer = docs.layerSets[i].typename;
        if (layer == "LayerSet")
        {
            var TargetObj = docs.layerSets[i];
            ExportAllLayerInfo(docs.layerSets[i]);
       }
    }

    for (var j = 0; j < docs.artLayers.length; j++)
    {
        var layer = docs.artLayers[j].kind;
        var TargetObj = docs.artLayers[j];
        CenteredLayerData = FixBounds(app.activeDocument,  TargetObj);
        //mystr += docs.artLayers[j].textItem.contents + "\n";
        //mystr += TargetObj.name + "\n";
        //if (layer == "LayerKind.TEXT")
        //{
        //}
        xmlString += "<obj " 
        + "name=\"" + TargetObj.name 
        + "\" x=\""  + CenteredLayerData.middleCenterX 
        + "\" y=\"" + CenteredLayerData.middleCenterY 
        + "\" w=\"" + CenteredLayerData.layerWidth
        +"\" h=\"" + CenteredLayerData.layerHeight
        +"\"/>\n";
    }
}

windowResource = "dialog {  \
    orientation: 'column', \
    alignChildren: ['fill', 'top'],  \
    preferredSize:[140, 60], \
    text: 'NGUI PSD Photoshop Exporter',  \
    margins:15, \
    \
    bottomGroup: Group{ \
        cancelButton: Button { text: 'Cancel', properties:{name:'cancel'}, size: [120,24], alignment:['right', 'center'] }, \
        exporTextLayers: Button { text: 'Export Layers', properties:{name:'exporTextLayers'}, size: [120,24], alignment:['right', 'center'] }, \
    }\
}"

win = new Window(windowResource);

win.bottomGroup.cancelButton.onClick = function() 
{
  return win.close();
};
win.bottomGroup.exporTextLayers.onClick = function() 
{
    // start the export
    StartExporting();
};

// Begin exporting
function StartExporting()
{
    win.close();
    var exportFolderName    = Folder.selectDialog ("Select the target folder:");

    // exit if nothing found
    if (! exportFolderName)
        return;

    // show the progress window
    progressWindow = createProgressWindow("Exporting...", undefined, 0, 100); 
    progressWindow.show();
    
    DocName = app.activeDocument.name.match(/([^\.]+)/)[1];

    // create the target folder
    var TargetFolder = new Folder(exportFolderName+'/'+DocName+'/');
    TargetFolder.create();     
    
    // Read the image
    //ReadImageGroup(AppActiveDoc, "");
    ExportAllLayerInfo(app.activeDocument);
    //DocToSave.trim(TrimType.TRANSPARENT);
    //DocToSave.saveAs(new File(TargetImageFolders + DocToSave.name + ".png"), new PNGSaveOptions(), true, Extension.LOWERCASE);
    //DocToSave.close(SaveOptions.DONOTSAVECHANGES);
    
    // Export XML file folder
    var XMLFilePath = TargetFolder + "/";

    // create a reference to a file for output
    var xmlFile = new File(XMLFilePath.toString().match(/([^\.]+)/)[1] + "NPSD_Data.xml");
    
    // open the file, write the data, then close the file
    xmlFile.open('w');
    xmlFile.writeln(xmlString += "</objs>\n");
    xmlFile.close();
    
    // reset ruler units
    preferences.rulerUnits = OrigRulerUnits;

    // completed
    alert("Export Complete!" + "\n" + "Your widgets and sprites have been successfully exported");
}

createProgressWindow = function(title, message, min, max) 
{
  var win;
  win = new Window('palette', title);
  win.bar = win.add('progressbar', undefined, min, max);
  win.bar.preferredSize = [300, 20];
  win.stProgress = win.add("statictext");
  win.stProgress.preferredSize.width = 200;
 
  return win;
};


win.show();
