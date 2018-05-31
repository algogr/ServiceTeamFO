import QtQuick 2.7
import QtQml.Models 2.3
import QtQuick.Controls 2.2

Item {

    width:listView.width
    height: 50



    Rectangle{
        id:firstrect
        anchors.fill: parent
        property int seltechid: 0
        Row{

            spacing: 5
            Rectangle{
                height: 40
                width: listView.width*2/16
                radius: 3
                color:"#336699"
                Text{
                    text:name
                    x:5
                    y:10
                    anchors.centerIn: parent
                    color: "white"

                }
                Component.onCompleted: {
                    firstrect.seltechid=id
                }
            }
            Rectangle{
                width: listView.width*12/16
                height: 40

                Column{
                    //anchors.fill: parent
                    //height: 40
                    //width: listView.width
                    Rectangle{
                        id:linerect
                        height: 10
                        width: listView.width*12/16
                        //border.color: "black"
                        //border.width: 1
                        Row
                        {
                            //height: 10
                            //width: listView.width*10/16

                            Rectangle{
                                id: greenline
                                height: 10
                                width: (listView.width*12/16)*6/10
                                border.width:10
                                border.color:"green"
                            }

                            Rectangle{
                                id: orangeline
                                height: 10
                                width: (listView.width*12/16)*2/10
                                border.width:10
                                border.color: "orange"
                            }

                            Rectangle{
                                id: redline
                                height: 10
                                width: (listView.width*12/16)*2/10
                                border.width:10
                                border.color: "red"
                            }

                        }

                    }

                    ListView{
                        id:hlv
                        orientation: ListView.Horizontal
                        width: listView.width*12/16
                        height: 30
                        Connections{
                            target:pg
                            onModelChange:{

                                dgm.filterOnGroup=dgm.filterOnGroup==="refresh"?"selected":"refresh"


                            }
                        }
                        model:dgm
                        DelegateModel{
                            id: dgm
                            model:ticketModel
                            groups: [

                                DelegateModelGroup
                                {

                                    name: "selected"
                                    includeByDefault: false
                                }
                                ,
                                DelegateModelGroup
                                {

                                    name: "refresh"

                                }
                                ,
                                DelegateModelGroup
                                {

                                    name: "techtickets"

                                }
                            ]
                            filterOnGroup: "selected"
                            delegate: Rectangle{
                                id:inc
                                MouseArea{
                                    anchors.fill: parent
                                    onPressAndHold: {
                                        console.log("PRESSED")

                                        stackView.push(Qt.resolvedUrl("VisitReport.qml"),{incident:ve.readSetting("scandocspath")+incident}) //to push sikonei parameters
                                    }
                                }

                                /*
                                SequentialAnimation {
                                            id: animred
                                            PropertyAnimation {
                                                target: inc
                                                property: "color"
                                                to: "red"
                                                duration: 500

                                            }
                                            PropertyAnimation {
                                                target: inc
                                                property: "color"
                                                to: "grey"
                                                duration: 500

                                            }
                                        }
                                SequentialAnimation {
                                            id: animblue
                                            PropertyAnimation {
                                                target: inc
                                                property: "color"
                                                to: "light blue"
                                                duration: 500

                                            }
                                            PropertyAnimation {
                                                target: inc
                                                property: "color"
                                                to: "grey"
                                                duration: 500

                                            }
                                        }
                                */
                                width: listView.width*1/16
                                color: "#132639"
                                /*
                                Behavior on color {
                                                    SequentialAnimation {
                                                        loops: 53
                                                        ColorAnimation { from: "grey"; to: "red"; duration: 300 }
                                                        ColorAnimation { from: "red"; to: "grey";  duration: 300 }
                                                        ColorAnimation { from: "grey"; to: "lightblue"; duration: 300 }
                                                        ColorAnimation { from: "light blue"; to: "grey";  duration: 300 }
                                                    }

                                }
                                */
                                height: 30
                                Column{
                                    Image {
                                        id: symbol
                                        width:15
                                        height: 15
                                        //source: status===1?"transfer.jpg":status===2?"check.png":"black-x-png-27.png"

                                    }

                                Text{
                                    color: "white"
                                    //anchors.bottom: parent.bottom
                                    text:incident
                                }

                                }
                                Component.onCompleted: {
                                    switch(ccckatastash){
                                    case 1:
                                        color="light blue"
                                        symbol.source="images/reset-icon.png"
                                        //animblue.running=true
                                        break;
                                    case 2:
                                        color="green"
                                        //symbol.source="images/check.png"
                                        break;

                                    case 3:
                                        color="red"
                                        symbol.source="images/black-x-png-27.png"
                                        //animred.running=true
                                        break;

                                    }

                                }


                            }

                            onFilterGroupChanged: {
                                var rowCount = ticketModel.rowCount()
                                for (var i=0;i<items.count;++i)
                                {

                                    items.get(i).inSelected=false
                                    items.get(i).inRefresh=false

                                }
                                var fg=dgm.filterOnGroup
                                var done=0
                                var total=0
                                for( var j = 0;j < rowCount;j++ )
                                {

                                    var entry = ticketModel.get(j);

                                    var techid= entry.ccctexnikos
                                    var appdate=entry.lastchangedatetime
                                    var status=entry.ccckatastash
                                    var newdate=entry.cccnewappointmentdate
                                    var firstappdate=entry.cccappointmentfrom
                                    var day=appdate.getDay()
                                    var hour=appdate.getHours()
                                    //console.log(appdate+"-"+techid+"-"+status+"-"+newdate)
                                    //firstrect.seltechid=entry.techid

                                    if(appdate.setHours(0,0,0,0)===pg.seldate.setHours(0,0,0,0)  && techid===firstrect.seltechid && ((status===2) || (status===3) || ((status===1) && (newdate.setHours(0,0,0,0)>=pg.seldate.setHours(0,0,0,0)))))

                                    {

                                        items.insert(entry, fg);
                                        done++
                                        console.log("Done:"+done)


                                    }

                                    if ((firstappdate.setHours(0,0,0,0)===pg.seldate.setHours(0,0,0,0) || newdate.setHours(0,0,0,0)===pg.seldate.setHours(0,0,0,0)) && techid===firstrect.seltechid)
                                    {

                                        total++
                                        console.log("Done:"+done+" Total:"+total)


                                    }



                                }



                                tdone.text=done
                                ttotal.text=total
                                var rem=1-(done/total)

                                calclines(1-rem)



                            }

                            Component.onCompleted: {
                                var rowCount = ticketModel.rowCount()

                                items.remove(0,rowCount);
                                var done=0
                                var total=0
                                for( var i = 0;i < rowCount;i++ )
                                {

                                    var entry = ticketModel.get(i);
                                    var techid= entry.ccctexnikos
                                    var appdate=entry.lastchangedatetime
                                    var status=entry.ccckatastash
                                    var newdate=entry.cccnewappointmentdate
                                    var firstappdate=entry.cccappointmentfrom
                                    var day=appdate.getDay()
                                    var hour=appdate.getHours()


                                    //firstrect.seltechid=entry.techid


                                    if(appdate.setHours(0,0,0,0)===pg.seldate.setHours(0,0,0,0)  && techid=== firstrect.seltechid && ((status===2) || (status===3) || ((status===1) && (newdate.setHours(0,0,0,0)>=pg.seldate.setHours(0,0,0,0)))))
                                    {
                                        items.insert(entry, "selected");
                                        done++




                                    }

                                    if ((firstappdate.setHours(0,0,0,0)===pg.seldate.setHours(0,0,0,0) || newdate.setHours(0,0,0,0)===pg.seldate.setHours(0,0,0,0)) && techid===firstrect.seltechid)
                                    {

                                        total++



                                    }


                                }

                                tdone.text=done
                                ttotal.text=total
                                var rem=done/total
                                calclines(1-rem)

                            }


                            function calclines(rem){
                                var smallwidth=(listView.width*12/16)*2/10
                                var largewidth=(listView.width*12/16)*6/10


                                if (rem>0.8)
                                {
                                    greenline.width=largewidth
                                    orangeline.width=smallwidth
                                    redline.width=((rem-0.8)/0.2)*smallwidth
                                }

                                if ((rem>0.6) && (rem<=0.8))
                                {
                                    greenline.width=largewidth
                                    orangeline.width=((rem-0.6)/0.2)*smallwidth
                                    redline.width=0
                                }

                                if (rem<=0.6)
                                {

                                    greenline.width=(rem/0.6)*largewidth
                                    orangeline.width=0
                                    redline.width=0
                                }
                            }

                        }
                    }
                }
            }
            Rectangle{
                height: 40
                width: listView.width*0.5/16
                color:"green"
                radius: 3
                Text{
                    id:tdone
                    text:name
                    x:5
                    y:10
                    anchors.centerIn: parent
                    color: "white"


                }
            }

                Rectangle{
                    height: 40
                    width: listView.width*0.5/16
                    color:"#336699"
                    radius: 3
                    MouseArea{
                        anchors.fill: parent
                        onPressAndHold: {

                            stackView.push(Qt.resolvedUrl("TickeListPage.qml"),{seltechid:firstrect.seltechid,seldate:pg.seldate}) //to push sikonei parameters
                        }
                    }
                    Text{

                        id:ttotal
                        text:name
                        x:5
                        y:10
                        anchors.centerIn: parent
                        color: "white"

                    }
            }

        }
    }

}

