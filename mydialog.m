function mydialog
%okienko gdy niemo�liwe przej�cie mi�dzy punktami
d = dialog('Position',[300 300 250 150],'Name','My Dialog');

txt = uicontrol('Parent',d,'Style','text','Position',[20 80 210 40],'String','Niemo�liwe przej�cie mi�dzy punktami.');

btn = uicontrol('Parent',d,'Position',[85 20 70 25],'String','Powr�t','Callback','delete(gcf)');