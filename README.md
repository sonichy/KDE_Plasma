# KDE plasma widget

Add widget：mouse right menu of desktop or taskbar, add widget.	

Local widget path: ~/.local/share/plasma/plasmoids/

Widget info: metadata.json  
Category: https://develop.kde.org/docs/extend/plasma/widget/properties/#category

Tooltip:  
Plasmoid.toolTipMainText, Plasmoid.toolTipSubText

Popup：Plasmoid.fullRepresentation

Config: https://develop.kde.org/docs/plasma/widget/configuration/

Test: plasmawindowed org.hty.CMUD  
Reload: plasmashell --replace

## Reference 
https://develop.kde.org/docs/plasma/widget/

## Note
1.If the id(metadata.json) and dir name are not the same, add widget will fail !  
2.Add widget must restart plasma to reload widget: plasmashell --replace