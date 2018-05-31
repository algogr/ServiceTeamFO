import QtQuick 2.7
import QtQuick.Dialogs 1.1

Item {
            id:appticket

                property real detailsOpacity: 0
                property point beginDrag
                property bool caught: false
                property var rparent: null
                property int ticketid: tid
                property int listindex: listView.currentIndex

                //Drag.active: mouseArea.held
                //qml state reparentx: 5
                //z: mouseArea.drag.active ||  mouseArea.pressed ? 0 : 1
                width: listView.width
                height: 40
                clip: true



                Rectangle {

                    id: background
                    x: 2; y: 2; width: parent.width - x*2; height: parent.height - y*2
                    color: "#b3cccc"
                    border.color: "orange"
                    radius: 5


                    ParallelAnimation {
                                   id: backAnim
                                   SpringAnimation { id: backAnimX; target: appticket; property: "x"; duration: 500; spring: 2; damping: 0.2 }
                                   SpringAnimation { id: backAnimY; target: appticket; property: "y"; duration: 500; spring: 2; damping: 0.2 }
                               }

                    MouseArea {
                                   id: mouseArea
                                   property bool held: false
                                   anchors.fill: parent
                                   //drag.target: held ? appticket: undefined
                                   onPressAndHold: {
                                            console.log("1"+tid)
                                            console.log("2"+dgm)
                                            var tst=dgm
                                            var mss=Qt.createQmlObject('import QtQuick 2.0;import QtQuick.Dialogs 1.1;MessageDialog {
                                       property var lv: list1
                                       property var rc: rootrect
                                       property var reppage: pg
                                       property int tech: atechid
                                       property var delflick: tldf
                                       property var timerr: timerepeat
                                       id: messageDialog
                                        standardButtons: StandardButton.Yes | StandardButton.No
                                       title: "Ακύρωση ανάθεσης"
                                       text: \"Θέλετε να ακυρώσετε την ανάθεση;\"

                                       onYes: {


                                           ticketModel.setFilter("id="+tid)
                                           var tindex=ticketModel.index(0,16);

                                           ticketModel.select()

                                           ticketModel.setData(tindex,0)
                                           ticketModel.submitAll()

                                           appointmentModel.setFilter("ticketid="+tid)
                                           console.log(tid)

                                           appointmentModel.removeRow(0)
                                           appointmentModel.select()
                                           customerTicketModel.refresh()
                                           appCustomerTicketModel.refresh()



                                           lv.model.filterOnGroup="refresh"
                                           console.log("refresh:"+timerr+"-"+tech)
                                           rc.mySignal(timerr.index,tech)

                                           delflick.occupied=false
                                           messageDialog.destroy(1000)
                                       }
                                        onNo: messageDialog.destroy(1000)


                                           Component.onCompleted: visible = true
                                   }' ,appticket,'')

                                   }




/*
                                   onPressed: {
                                       held=true
                                       appticket.parent=list1
                                       rparent=appticket.parent
                                       console.log("Rparent"+rparent)
                                       console.log("list1_z"+parent)
                                       listView.currentIndex = index

                                       appticket.beginDrag = Qt.point(appticket.x, appticket.y);
                                       appticket.z=200
                                       appticket.state="reparented"
                                       //console.log("Mouse da:"+mouseArea.drag.active)
                                       //console.log("App TicketState:"+appticket.state)
                                   }
                                   onReleased: {
                                       held=false
                                       if(!appticket.caught) {
                                           appticket.state="return"
                                           backAnimX.from = appticket.x;
                                           backAnimX.to = beginDrag.x;
                                           backAnimY.from = appticket.y;
                                           backAnimY.to = beginDrag.y;
                                           backAnim.start()
                                       }
                                       else{
                                           ticketModel.setFilter("id="+tid)
                                           var tindex=ticketModel.index(0,16);

                                           ticketModel.select()

                                           ticketModel.setData(tindex,0)
                                           ticketModel.submitAll()

                                           appointmentModel.setFilter("ticketid="+tid)
                                           appointmentModel.removeRow(0)
                                           appointmentModel.select()
                                           customerTicketModel.refresh()
                                           appCustomerTicketModel.refresh()
                                           appticket.Drag.drop()





                                       }
                                   }
*/
                               }


                }


                Row {
                    id: row1
                    spacing: 10
                    Rectangle {
                        width: 40
                        height: 40
                        color: "#669999"
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {

                                appticket.state = (detailsOpacity===0)?'Details':''
                            }

                        }
                    }

                    Text {
                        text: tincident

                        font.bold: true
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text {
                        id:cityt
                        text: ccounty
                        font.bold: true
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }



                Item{
                    id:details
                    x:10;width: parent.width-20
                    anchors { top: row1.bottom;
                        topMargin: 10; bottom: parent.bottom;
                        bottomMargin: 10 }
                    opacity: appticket.detailsOpacity





                    Flickable {
                        id: flick
                        width: parent.width
                        height:parent.height
                        //anchors { top: row1.bottom; bottom: parent.bottom }
                        contentHeight: 520


                        clip: true
                        Column{



                        Text {

                                    text: "Title:"+ttitle+"<br>"
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter


                                }

                                Text {

                                    text: "Company:"+oname
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter
                                }


                                Text {

                                    text: "Service:"+tservice
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter
                                }


                                Text {

                                    text: "Service Recipient:"+cname
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter
                                }

                                Text {

                                    text: "Location:"+clocation
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter
                                }


                                Text {

                                    text: "City:"+ccity
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter
                                }

                                Text {

                                    text: "County:"+ccounty
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter
                                }

                                Text {

                                    text: "Address:"+caddress
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter
                                }

                                Text {

                                    text: "Phone:"+cphone1
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter
                                }

                                Text {

                                    text: "Contact Phone:"+cphone2
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter
                                }


                                Text {

                                    text: "Priority:"+tpriority
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter
                                }

                                Text {

                                    text: "Ticket No."+tcustomerticketno
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter
                                }

                                Text {

                                    text: "Appointment:"+tappointmentfrom
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter
                                }

                                Text {

                                    text: "Description:"+tdescription
                                    font.bold: true
                                    width: 80
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter
                                }

}
                    }
                }

                        states: [State {
                            name: "Details"

                            //PropertyChanges { target: background; color: "white" }
                            //PropertyChanges { target: recipeImage; width: 130; height: 130 } // Make picture bigger
                            PropertyChanges { target: appticket; detailsOpacity: 1; x: 0 } // Make details visible
                            PropertyChanges { target: appticket; height: rootrect.height/2 } // Fill the entire list area with the detailed view

                            // Move the list so that this item is at the top.
                            //PropertyChanges { target: ticket.ListView.view; explicit: true; contentY: timetable.y }

                            // Disallow flicking while we're in detailed view
                            PropertyChanges { target: appticket.ListView.view; interactive: false }
                        },

                        State {
                                   name: "reparented"
                                   ParentChange { target: appticket; parent: swipeView }
                                   AnchorChanges {target: appticket;  anchors.top: undefined; anchors.bottom: undefined ;  anchors.left: undefined; anchors.right: undefined}
                               },
                        State {
                                   name: "reparented1"

                                   ParentChange { target: appticket; parent: rootrect}
                                   //PropertyChanges { target: background; color:"red" }


                               },
                            State {
                                       name: "return"

                                       ParentChange { target: appticket; parent:rparent}
                                       //PropertyChanges { target: background; color:"red" }


                                   }

                        ]

                        transitions: Transition {
                            // Make the state changes smooth
                            ParallelAnimation {
                                ColorAnimation { property: "color"; duration: 500 }
                                NumberAnimation { duration: 300; properties: "detailsOpacity,x,contentY,height,width" }
                            }
                        }
Component.onCompleted: {
    ph.occupied=true


}



            }

