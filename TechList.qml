import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3




Item {


        property alias tld1: listView.delegate
        ListView {
            property alias tld: listView
            id: listView
            anchors.fill: parent
            anchors.margins: 5
            //anchors.bottomMargin: 250

            anchors.topMargin: 30
            clip:true
            //x: 22
            //y: 18
            //width: 490
            //height: 312
            contentHeight: 300
            model: techModel

            delegate: TechListDelegate{



            }

        }

}



