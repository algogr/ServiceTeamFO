import QtQuick 2.7
import QtQml.Models 2.3
import QtQuick.Controls 2.2

Item {

    width:listView.width
    height: 50



Rectangle{

    anchors.fill: parent
    Row{

        spacing: 5
    Rectangle{
        height: 40
        width: listView.width*2/16
        color:"#336699"
        Text{
            text:name
            x:5
            y:10
            anchors.centerIn: parent
            color: "white"

        }
    }
        Repeater{
            id:r1

            model:13
            Rectangle{
                id:hourbox
                property bool occupied:false
                height: 40
                width: listView.width/16
                color: "#d9e6f2"

                ListView{
                    id:list1
                    anchors.fill: parent
                    model: dgm
                    Connections{
                        target:rootrect
                        onMySignal:{
                            if (ind===modelData && id===technicianid)
                                dgm.filterOnGroup="refresh"
                                //&& sw.currentIndex===dow
                                //console.log("SIGNAL swci="+sw.currentIndex+" dow:"+dow)



                        }
                    }

                        DelegateModel

                         {
                             id:dgm



                             model:appCustomerTicketModel


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
                                         includeByDefault: false
                                     }
                                     ]
                             filterOnGroup: "selected"

                             delegate:Rectangle{
                                 color: "#132639"
                                 height: 40
                                 width: listView.width/14
                                 Component.onCompleted: {
                                    hourbox.occupied=true
                                 }

                             }

                             onFilterGroupChanged: {
                                 var rowCount = appCustomerTicketModel.rowCount()

                                 items.remove(0,rowCount);
                                 for( var i = 0;i < rowCount;i++ )
                                 {

                                     var entry = appCustomerTicketModel.get(i);
                                     var techid= entry.atechid
                                     var appdate=entry.appdate
                                     var day=appdate.getDay()
                                     var hour=appdate.getHours()

                                     if(hour===index+8 && day===pg.pindex && techid===id)
                                     {
                                         items.insert(entry, "refresh");


                                     }
                                 }

                             }





                             Component.onCompleted: {
                                 var rowCount = appCustomerTicketModel.rowCount()

                                 items.remove(0,rowCount);
                                 for( var i = 0;i < rowCount;i++ )
                                 {

                                     var entry = appCustomerTicketModel.get(i);
                                     var techid= entry.atechid
                                     var appdate=entry.appdate
                                     var day=appdate.getDay()
                                     var hour=appdate.getHours()

                                     if(hour===index+8 && day===pg.pindex && techid===id)
                                     {
                                         items.insert(entry, "selected");


                                     }
                                 }


                             }
                         }

                }

                Text{
                    text:(index+8)+":00"
                    color: hourbox.occupied?"white":"black"
                }
            }

        }

    }
}
}
