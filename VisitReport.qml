import QtQuick 2.9
import QtQuick.Controls 2.2
Item {
    property string incident: ""

    Page{

         id:pg
         width:1024
         height:768
         Rectangle{
             anchors.fill: parent
             Flickable{
             Image{
                 anchors.fill: parent
                 source:"file:///"+incident+".jpg"

             }
             anchors.fill: parent
         }

    }
    }
}
