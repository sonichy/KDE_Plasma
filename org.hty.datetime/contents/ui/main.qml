import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.6
 
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
 
Item {
    id: root 

    readonly property date currentDateTime: new Date()
 
    width: PlasmaCore.Units.gridUnit * 10
    height: PlasmaCore.Units.gridUnit * 4
 
    Plasmoid.toolTipMainText: plasmoid.configuration.toolTipMain	//Qt.formatTime(currentDateTime, "hh:mm")
    Plasmoid.toolTipSubText: plasmoid.configuration.toolTipSub	//Qt.formatDate(currentDateTime, Qt.locale().dateFormat(Locale.LongFormat))
 
    PlasmaCore.DataSource {
        id: dataSource
        engine: "time"
        connectedSources: ["Local"]
        interval: 60000
        intervalAlignment: PlasmaCore.Types.AlignToMinute
    }
 
	Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
    Plasmoid.compactRepresentation: CompactRepresentation { }
   
    Plasmoid.fullRepresentation: FullRepresentation { }
}
