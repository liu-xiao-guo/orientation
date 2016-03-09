import QtQuick 2.0
import Ubuntu.Components 1.1
import QtSensors 5.0

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    id: root
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "orientation.liu-xiao-guo"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    width: units.gu(60)
    height: units.gu(85)

    property bool isLandscape: pageStack.width > pageStack.height ? true : false

    onWidthChanged: {
        console.log("Main width is changed: " + width)
    }

    function displayOrientation(reading) {
        orientation.text = "unknown"
        console.log("orientation: " + reading.orientation);

        if ( reading.orientation === OrientationReading.TopUp) {
            orientation.text = "TopUp";
        } else if ( reading.orientation === OrientationReading.TopDown) {
            orientation.text = "TopDown";
        } else if ( reading.orientation === OrientationReading.LeftUp) {
            orientation.text = "LeftUp";
        } else if ( reading.orientation === OrientationReading.RightUp) {
            orientation.text= "RightUp";
        } else if ( reading.orientation === OrientationReading.FaceDown) {
            orientation.text = "FaceDown";
        }  else if ( reading.orientation === OrientationReading.FaceUp) {
            orientation.text = "FaceUp";
        }
    }

    OrientationSensor {        
        id: sensor
        active: true
        alwaysOn: true
        onReadingChanged: {
            displayOrientation(reading);
        }
    }

    PageStack {
        id: pageStack
        anchors.fill: parent

        onWidthChanged: {
            console.log("PageStack width is changed: " + width);
            console.log("root width: " + root.width);
        }

        onHeightChanged: {
            console.log("PageStack height is changed: " + height);
        }
    }

    Page {
        id: page1
        title: i18n.tr("Orientation")
        anchors.fill: parent

        onWidthChanged: {
            console.log("Page width is changed: " + width);
        }

        Column {
            anchors.centerIn: parent
            spacing: 20

            Text {
                id: orientation
                text: "unknown"
            }

            Text {
                text: root.isLandscape ? "Landscape" : "portrait"
            }
        }
    }

    Component.onCompleted: {
        console.log("original reading: " + sensor.reading.orientation);
        displayOrientation(sensor.reading);
    }
}

