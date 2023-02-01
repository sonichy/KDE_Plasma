import QtQuick 2.0
import QtQuick.Controls 2.5
import org.kde.kirigami 2.4 as Kirigami

Kirigami.FormLayout {
    id: page
  
    property alias cfg_showSeconds: showSeconds.checked
    property alias cfg_showWeekNumbers: showWeekNumbers.checked

    CheckBox {
        id: showSeconds
        text: i18n("Show seconds")
        checked: plasmoid.configuration.showSeconds
        onCheckedChanged: plasmoid.configuration.showSeconds = checked
    }
    
    CheckBox {
        id: showWeekNumbers
        text: i18n("Show week numbers")
        checked: plasmoid.configuration.showWeekNumbers
        onCheckedChanged: {
        	plasmoid.configuration.showWeekNumbers = checked
        	calendar.weekNumbersVisible = plasmoid.configuration.showWeekNumbers
        }
    }

}
