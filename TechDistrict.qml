import QtQuick 2.7
//import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2
import QtQuick.Controls 2.2
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.1
import QtQml.Models 2.3


Page {
    id: page1
    property int techid: 0
    property string rdate: new Date().getFullYear()+"/"+(new Date().getMonth()+1)+"/"+new Date().getDate()
    signal techDistrictChanged()


    anchors.fill: parent
    LinearGradient {
           anchors.fill: parent
           start: Qt.point(0, 0)
           end: Qt.point(0, 300)
           gradient: Gradient {
               GradientStop { position: 0.0; color: "#e6e6e6" }
               GradientStop { position: 1.0; color: "#333333" }
           }
       }



        Column {
            id:c1
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 20
            anchors.fill: parent







            Rectangle{
                width:  page1.availableWidth/3
                height: page1.availableHeight/20
                anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1

            ComboBox {


                id: techlist
                model: techModel
                textRole: "name"
                anchors.fill: parent
                currentIndex: -1
                onCurrentTextChanged: {

                    techid=techModel.get(currentIndex)["id"]
                    dgm.filterOnGroup=(dgm.filterOnGroup==="refresh"?"selected":"refresh")
                    dgm1.filterOnGroup=(dgm1.filterOnGroup==="refresh"?"selected":"refresh")

                }
            }

       }


            Rectangle{
                width:  page1.availableWidth
                height: page1.availableHeight/2
                //anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1
                color: "white"
                Row{
                    anchors.fill: parent
                    spacing: 10
                    anchors.topMargin: 10
                    anchors.bottomMargin: 10
                    Rectangle{
                                   id: calrect
                                   width:  (page1.availableWidth/2)-20
                                   height: (page1.availableHeight/2)-20

                                   //anchors.horizontalCenter: parent.horizontalCenter
                                   border.width: 1

                                   Calendar {
                                       id: calendar
                                       //width: (parent.width > parent.height ? parent.width * 0.6 - parent.spacing : parent.width)
                                       //height: (parent.height > parent.width ? parent.height * 0.6 - parent.spacing : parent.height)
                                       anchors.fill: parent
                                       anchors.leftMargin: 10
                                       frameVisible: true
                                       weekNumbersVisible: true
                                       selectedDate: new Date()
                                       focus: true
                                       onSelectedDateChanged:{
                                           rdate=selectedDate.getFullYear()+"/"+(selectedDate.getMonth()+1)+"/"+selectedDate.getDate()
                                           console.log(rdate)
                                           dgm.filterOnGroup=dgm.filterOnGroup==="refresh"?"selected":"refresh"
                                           dgm1.filterOnGroup=dgm.filterOnGroup==="refresh"?"selected":"refresh"
                                       }


                                       style: CalendarStyle {
                                           dayDelegate: Item {
                                               readonly property color sameMonthDateTextColor: "#444"
                                               readonly property color selectedDateColor: Qt.platform.os === "osx" ? "#3778d0" : "#3778d0"
                                               readonly property color selectedDateTextColor: "white"
                                               readonly property color differentMonthDateTextColor: "#bbb"
                                               readonly property color invalidDatecolor: "#dddddd"

                                               Rectangle {
                                                   anchors.fill: parent
                                                   border.color: "transparent"

                                                   color: styleData.date !== undefined && styleData.selected ? selectedDateColor : "#f2f2f2"
                                                   anchors.margins: styleData.selected ? -1 : 0
                                               }



                                               Label {
                                                   id: dayDelegateText
                                                   text: styleData.date.getDate()
                                                   anchors.centerIn: parent
                                                   color: {
                                                       var color = invalidDatecolor;
                                                       if (styleData.valid) {
                                                           // Date is within the valid range.
                                                           color = styleData.visibleMonth ? sameMonthDateTextColor : differentMonthDateTextColor;
                                                           if (styleData.selected) {
                                                               color = selectedDateTextColor;
                                                           }
                                                       }
                                                       color;
                                                   }
                                               }


                                           }
                                       }
                                   }




                               }


                    Rectangle{

                        width:  (page1.availableWidth/2)-20
                        height: (page1.availableHeight/2)-20
                        Column{
                            anchors.fill: parent
                            Rectangle {
                                           id: eventListHeader
                                           width:  page1.availableWidth/2
                                           height: page1.availableHeight/10
                                           anchors.horizontalCenter: parent.horizontalCenter


                                           Row {
                                               id: eventDateRow
                                               width: parent.width
                                               height: eventDayLabel.height
                                               spacing: 30

                                               Label {
                                                   id: eventDayLabel
                                                   text: calendar.selectedDate.getDate()
                                                   font.pointSize: 35
                                               }

                                               Column {
                                                   height: eventDayLabel.height


                                                   Label {
                                                       readonly property var options: { weekday: "long" }
                                                       text: Qt.locale().standaloneDayName(calendar.selectedDate.getDay(), Locale.LongFormat)
                                                       font.pointSize: 18
                                                   }
                                                   Label {
                                                       text: Qt.locale().standaloneMonthName(calendar.selectedDate.getMonth())
                                                             + calendar.selectedDate.toLocaleDateString(Qt.locale(), " yyyy")
                                                       font.pointSize: 12
                                                   }


                                               }

                                           }
                                       }

                            Rectangle {
                                           id: t
                                           width:  (page1.availableWidth/2)-20
                                           height: (page1.availableHeight/3)+20
                                           anchors.horizontalCenter: parent.horizontalCenter


                                           color: "#f2f2f2"
                                           ListView{
                                               id:list
                                               clip: true
                                               anchors.fill: parent
                                               model: dgm
                                               property variant pobj: page1
                                               Connections{
                                                   target: page1
                                               onTechDistrictChanged:{

                                                   dgm.filterOnGroup=(dgm.filterOnGroup==="refresh"?"selected":"refresh")
                                                   dgm1.filterOnGroup=(dgm1.filterOnGroup==="refresh"?"selected":"refresh")
                                               }
                                               }

                                               DelegateModel

                                               {
                                               id:dgm

                                               model:techDistrictQModel
                                               groups: [

                                               DelegateModelGroup
                                               {

                                               name: "selected"
                                               includeByDefault: false

                                               },
                                               DelegateModelGroup
                                               {

                                                   name: "refresh"
                                                   includeByDefault: false

                                               }


                                               ]
                                               filterOnGroup: "selected"

                                               delegate:



                                                   Rectangle{
                                                   width: list.width
                                                   height: 30
                                                   border.width: 1
                                                   color: (index+2)%2===0?"#cccccc":"white"
                                                   MouseArea{
                                                       anchors.fill: parent
                                                       onPressAndHold: {
                                                           sel.visible=sel.visible===true?false:true
                                                       }
                                                   }

                                                   Row{
                                                       anchors.fill: parent
                                                       anchors.leftMargin: 25
                                                       anchors.rightMargin: 5

                                                   Text{

                                                       text: model.ddescription

                                                       //anchors.verticalCenter: parent.verticalCenter
                                                       font.pointSize: 15

                                                   }
                                                   Rectangle{
                                                       id:sel

                                                       color:"red"
                                                       width: 75
                                                       height: 25
                                                       visible: false
                                                       anchors.verticalCenter: parent.verticalCenter
                                                       anchors.right: parent.right
                                                       MouseArea{
                                                           anchors.fill:parent
                                                           onPressAndHold: {


                                                               var obj=techDistrictModel
                                                               var obj1=list
                                                               var obj2=dgm
                                                               obj.setFilter(setFilter(("techid=%1 and districtid=%2 and refdate='%3'").arg(techid).arg(did).arg(rdate)))
                                                               obj.select()
                                                               obj.removeRow(0)
                                                               obj.submitAll()
                                                               obj.select()
                                                               techDistrictQModel.refresh()
                                                               obj1.pobj.techDistrictChanged()
                                                               obj2.filterOnGroup=obj2.filterOnGroup==="refresh"?"selected":"refresh"

                                                           }
                                                       }

                                                       Text{

                                                           text: "-"
                                                           color: "white"
                                                           anchors.verticalCenter: parent.verticalCenter
                                                           anchors.horizontalCenter: parent.horizontalCenter
                                                           font.pointSize: 25

                                                       }
                                                   }

                                                   }

                                               }


                                               onFilterGroupChanged: {

                                               var rowCount = techDistrictQModel.rowCount()
                                               for (var i=0;i<items.count;++i)
                                               {

                                                       items.get(i).inSelected=false
                                                       items.get(i).inRefresh=false

                                               }
                                               var fg=dgm.filterOnGroup

                                               for( var j = 0;j < rowCount;j++ )
                                               {

                                                   var entry = techDistrictQModel.get(j);
                                                   var tdtechid= entry.tdtechid
                                                   var tdrefdate=entry.tdrefdate

                                                   if((tdtechid===techid) && (tdrefdate===rdate))
                                                   {

                                                       items.insert(entry, dgm.filterOnGroup==="refresh"?"refresh":"selected");


                                                   }
                                               }

                                               }



                                               Component.onCompleted: {

                                               var rowCount = techDistrictQModel.rowCount()

                                               items.remove(0,rowCount);
                                               for( var i = 0;i < rowCount;i++ )
                                               {

                                                   var entry = techDistrictQModel.get(i);
                                                   var tdtechid= entry.tdtechid
                                                   var tdrefdate= entry.tdrefdate
/*

*/

                                                   if((tdtechid===techid) && (tdrefdate===rdate))
                                                   {


                                                       items.insert(entry, "selected");


                                                   }
                                               }

                                               }







                                           }

                           }

                        }



                    }







                }






            }


    }

            Rectangle{

                width:  page1.availableWidth
                height: page1.availableHeight/5
                color: "#4d4d4d"

                ListView{
                    //width: parent.width/2
                    //height: parent.height*9/10
                    id:list1
                    property variant pobj: page1
                    width:  page1.availableWidth/2
                    height: page1.availableHeight/6
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    model:dgm1
                    clip:true
                    DelegateModel{
                        id:dgm1
                        model:districtModel
                        groups: [

                        DelegateModelGroup
                        {

                        name: "selected"
                        includeByDefault: false

                        },
                        DelegateModelGroup
                        {

                            name: "refresh"
                            includeByDefault: false

                        }


                        ]
                        delegate:



                            Rectangle{
                            width: list1.width
                            height: 30
                            border.width: 1
                            color: (index+2)%2===0?"#cccccc":"white"
                            MouseArea{
                                anchors.fill: parent
                                onPressAndHold: {
                                    sel1.visible=sel1.visible===true?false:true
                                }
                            }

                            Row{
                                anchors.fill: parent
                                anchors.leftMargin: 25
                                anchors.rightMargin: 5

                            Text{

                                text: model.description

                                //anchors.verticalCenter: parent.verticalCenter
                                font.pointSize: 15

                            }
                            Rectangle{
                                id:sel1

                                color:"blue"
                                width: 75
                                height: 25
                                visible: false
                                anchors.verticalCenter: parent.verticalCenter
                                //anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                MouseArea{
                                    anchors.fill:parent
                                    onPressAndHold: {


                                        var obj=techDistrictModel
                                        var obj1=list1
                                        var obj2=dgm1
                                        var obj3=dgm

                                        var rowcount=techDistrictModel.rowCount()
                                        console.log("11")
                                        techDistrictModel.insertRow(rowcount)
                                        console.log("12")
                                        var tindex=techDistrictModel.index(rowcount,0)
                                        var dindex=techDistrictModel.index(rowcount,1)
                                        var rindex=techDistrictModel.index(rowcount,3)

                                        techDistrictModel.setData(tindex,techid)
                                        techDistrictModel.setData(dindex,model.id)
                                        techDistrictModel.setData(rindex,rdate)
                                        console.log("0")
                                        obj.submitAll()
                                        console.log("110")
                                        obj.commit()
                                        console.log("1")

                                        obj.select()
                                        console.log("2")
                                        techDistrictQModel.refresh()
                                        console.log("3")


                                        obj1.pobj.techDistrictChanged()
                                        console.log("5")
                                        obj2.filterOnGroup=obj2.filterOnGroup==="refresh"?"selected":"refresh"
                                        console.log("6")
                                        obj3.filterOnGroup=obj3.filterOnGroup==="refresh"?"selected":"refresh"
                                        console.log("7")
                                        //TODO Fix Lost connection to MySQL

                                    }
                                }

                                Text{

                                    text: "+"
                                    color: "white"
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    font.pointSize: 25

                                }
                            }

                            }

                        }
                        onFilterGroupChanged: {
                            console.log("Changed")
                        var rowCount = districtModel.rowCount()
                        for (var i=0;i<items.count;++i)
                        {

                                items.get(i).inSelected=false
                                items.get(i).inRefresh=false

                        }
                        var fg=dgm1.filterOnGroup

                        for( var j = 0;j < rowCount;j++ )
                        {

                            var entry = districtModel.get(j);
                            var did= entry.id
                            techDistrictModel.setFilter(("techid=%1 and districtid=%2 and refdate='%3'").arg(techid).arg(did).arg(rdate))
                            console.log(techid+"+"+did+"+"+rdate)
                            console.log("Count:"+techDistrictModel.rowCount())
                            if(techDistrictModel.rowCount()===0)
                            {

                                items.insert(entry, dgm1.filterOnGroup==="refresh"?"refresh":"selected");


                            }
                            techDistrictModel.setFilter("")
                            techDistrictModel.select()
                        }

                        }


                        Component.onCompleted: {
                         console.log("Completed")
                        var rowCount = districtModel.rowCount()

                        items.remove(0,rowCount);
                        for( var i = 0;i < rowCount;i++ )
                        {

                            var entry = districtModel.get(i);
                            var did= entry.id
                            techDistrictModel.setFilter(("techid=%1 and districtid=%2 and refdate=%3").arg(techid).arg(did).arg(rdate))
                            console.log("Count:"+techDistrictModel.rowCount())
                            if(techDistrictModel.rowCount()===0)
                            {

                                items.insert(entry, dgm1.filterOnGroup==="refresh"?"refresh":"selected");


                            }
                            techDistrictModel.setFilter("")
                            techDistrictModel.select()
                        }

                        }




                    }
                }

            }

}





}
