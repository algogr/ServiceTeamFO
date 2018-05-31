import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import QtQml.Models 2.3


Item {


    Rectangle{
        width: pg1.width/2
        height: pg1.height
        ListView{
            id:lv
            anchors.fill: parent
            model:dgm2
            DelegateModel{
                id:dgm2
                model: customerTicketModel
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
]
                filterOnGroup: "selected"
                delegate: Rectangle{
                    height: 50
                    width: lv.width
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            pg1.ticketchanged(tid)
                            console.log(tid)
                        }
                    }

                    Row{
                        spacing:10
                        Rectangle{
                            width: 40
                            height: 40
                            color: "green"
                        }

                        Rectangle
                        {
                            height: 40
                            width: lv.width-60
                            Text {
                                id: name
                                text: tincident
                                anchors.centerIn: parent
                            }
                        }

                    }
                }

                onFilterGroupChanged: {
                    var rowCount = customerTicketModel.rowCount()
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

                        var entry = customerTicketModel.get(j);
                        var techid= entry.ttechid
                        var status=entry.tstatus
                        var newdate=entry.tnewappointmentdate
                        var firstappdate=entry.tappointmentfrom

                        var checknewdate = newdate instanceof Date && !isNaN(newdate.valueOf())


                        if ((firstappdate.setHours(0,0,0,0)===pg.seldate.setHours(0,0,0,0) || newdate.setHours(0,0,0,0)===pg.seldate.setHours(0,0,0,0)) && techid===firstrect.seltechid)
                        //if (((firstappdate.setHours(0,0,0,0)===seldate.setHours(0,0,0,0) && checknewdate===false) && status===1 && techid===seltechid) || ((newdate.setHours(0,0,0,0)===seldate.setHours(0,0,0,0)) && (status===1) && techid===seltechid))

                        {

                            items.insert(entry, fg);




                        }




                    }






                }
                Component.onCompleted: {
                    var rowCount = customerTicketModel.rowCount()

                    items.remove(0,rowCount);
                    var done=0
                    var total=0
                    for( var i = 0;i < rowCount;i++ )
                    {

                        var entry = customerTicketModel.get(i);
                        var techid= entry.ttechid
                        var status=entry.tstatus
                        var newdate=entry.tnewappointmentdate
                        var firstappdate=entry.tappointmentfrom

                        var checknewdate = newdate instanceof Date && !isNaN(newdate.valueOf())


                        if ((firstappdate.setHours(0,0,0,0)===pg.seldate.setHours(0,0,0,0) || newdate.setHours(0,0,0,0)===pg.seldate.setHours(0,0,0,0)) && techid===firstrect.seltechid)
                        //if (((firstappdate.setHours(0,0,0,0)===seldate.setHours(0,0,0,0) && checknewdate===false) && status===1 && techid===seltechid) || ((newdate.setHours(0,0,0,0)===seldate.setHours(0,0,0,0)) && (status===1) && techid===seltechid))
                        {
                            items.insert(entry, "selected");




                        }




                    }


                }

            }

        }

    }

}
