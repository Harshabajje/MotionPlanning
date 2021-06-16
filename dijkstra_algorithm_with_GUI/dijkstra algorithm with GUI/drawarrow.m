function drawarrow(x1,x2,y1,y2,len)

cita=pi/12; 
cos_cita=cos(cita);
sin_cita=sin(cita);

x=[x1 x2];
y=[y1 y2];

r=len/sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)); 
hdl_line=line(x,y,'color',[0 1 0],'LineWidth',1); 
p1_x=x2;
p1_y=y2;
p2_x=x2+r*(cos_cita*(x1-x2)-sin_cita*(y1-y2));
p2_y=y2+r*(cos_cita*(y1-y2)+sin_cita*(x1-x2));
p3_x=x2+r*(cos_cita*(x1-x2)+sin_cita*(y1-y2));
p3_y=y2+r*(cos_cita*(y1-y2)-sin_cita*(x1-x2));
hdl_head=patch([p1_x p2_x p3_x],[p1_y p2_y p3_y],'g');