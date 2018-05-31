import QtQuick 2.7
import QtQuick.Controls 2.1

ToolBar {
    id: background
    width: 64
    height: 43
    Rectangle{
        anchors.fill: parent
        //color: "#494969"
        color: "#132639"

    Label {
        id: label
        text: section
        color: "white"
        anchors.fill: parent
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
    }
    }
}
