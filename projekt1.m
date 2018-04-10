clear;
clc;
%dane pocz¹tkowe
d1=-1;d2=-1;d5=-1; %delta=[d1 d2 d5];
l1=600;l2=2000;l3=3200;d=600;e=500;% geoR=[l1 l2 l3 d e];
l4=600;l5=400;l6=300;l=l5+l6;% geoL=[l4 l5 l6];
theta=30;psi=40;% wekpod=[theta ksi];
St=sin(theta*pi/180);Ct=cos(theta*pi/180);Sp=sin(psi*pi/180);Cp=cos(psi*pi/180);
xpocz=0; ypocz=750; zpocz=1000;% wpkt1=[];
xkon=1000; ykon=1750; zkon=2000;% wpkt2=[];
kroki=100;

[X,Y,Z,fi]=oblicz(kroki,xpocz,ypocz,zpocz,xkon,ykon,zkon,St,Ct,Sp,Cp,d1,d2,d5,l1,l2,l3,d,e,l4,l);

%sprawdzanie czy mo¿liwe, czy nie s¹ urojone
zn=0;
for i = 1:kroki
    if zn ~= 1
        for j = 1:8
            if zn ~= 1
                if(X(i,j)^2<0)
                    zn=1;
                else
                    if(Y(i,j)^2<0)
                        zn=1;
                    else
                        if(Z(i,j)^2<0)
                            zn=1;
                        end
                    end
                end
            end
        end
    end
end

if zn ~= 1
    %rysowanie wykresów
    for i = 1:kroki
        % wykresy 2d
        % subplot(2,2,3);plot(X,Y);title('XY');
        % subplot(2,2,1);plot(X,Z);title('XZ');
        % subplot(2,2,2);plot(Y,Z);title('YZ');
        
        % wykres 3d animacja
        plot3(X(i,:),Y(i,:),Z(i,:));title('XYZ');
        pause(0.1);
    end
else
    fprintf('NIE mo¿liwe');
end

function [X,Y,Z,fi] = oblicz(kroki,xpocz,ypocz,zpocz,xkon,ykon,zkon,St,Ct,Sp,Cp,d1,d2,d5,l1,l2,l3,d,e,l4,l)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
X=zeros(kroki,8);
Y=zeros(kroki,8);
Z=zeros(kroki,8);
fi=zeros(kroki,5);
for i = 1:kroki
    xT=xpocz+i*(xkon-xpocz)/kroki;
    yT=ypocz+i*(ykon-ypocz)/kroki;
    zT=zpocz+i*(zkon-zpocz)/kroki;
    
    xP=xT-l*Ct*Cp;
    yP=yT-l*Ct*Sp;
    zP=zT-l*St;
    
    S1=(e*xP+d1*yP*sqrt(xP^2+yP^2-e^2))/(xP^2+yP^2);
    C1=(-e*yP+d1*xP*sqrt(xP^2+yP^2-e^2))/(xP^2+yP^2);
    f1=acos(C1)*180/pi;
    
    S5=Ct*(Sp*C1-Cp*S1);
    C5=d5*sqrt(1-S5^2);
    f5=acos(C5)*180/pi;
    
    S234=St/C5;
    C234=Ct*(Cp*C1+Sp*S1)/C5;
    f234=acos(C234)*180/pi;
    
    xR=xP-l4*C1*C234;
    yR=yP-l4*S1*C234;
    zR=zP-l4*S234;
    
    a=-l1+d1*sqrt(xR^2+yR^2-e^2);
    b=(a^2+zR^2+l2^2-l3^2)/(2*l2);
    
    S2=(zR*b+d2*a*sqrt(a^2+zR^2-b^2))/(a^2+zR^2);
    C2=(a*b-d2*zR*sqrt(a^2+zR^2-b^2))/(a^2+zR^2);
    f2=acos(C2)*180/pi;
    
    S3=(-d2*sqrt(a^2+zR^2-b^2))/l3;
    C3=(b-l2)/l3;
    f3=acos(C3)*180/pi;
    
    S23=(zR-l2*S2)/l3;
    C23=(a-l2*C2)/l3;
    f23=acos(C23)*180/pi;
    
    S4=S234*C23-C234*S23;
    C4=C234*C23+S234*S23;
    f4=acos(C4)*180/pi;
    
    x01=l1*C1; y01=l1*S1; z01=0;
    x01p=x01+d*S1; y01p=y01-d*C1; z01p=0;
    x02p=x01p+l2*C2*C1; y02p=y01p+l2*C2*S1; z02p=l2*S2;
    x02=x02p-(d-e)*S1; y02=y02p+(d-e)*C1; z02=z02p;
    %     % sprawdzanie ?
    %     xR2=x02+l3*C1*C23; yR2=y02+l3*S1*C23; zR2=z02+l3*S23;
    %     xP2=xR2+l4*C1*C234; yP2=yR2+l4*S1*C234; zP2=zR2+l4*S234;
    %     xT2=xP2+l*Ct*Cp; yT2=yP2+l*Ct*Sp; zT2=zP2+l*St;
    %     if xP2==xP
    %         fprintf('TAK\n');
    %     elseif abs(xP2-xP)<1e-10
    %         fprintf('TAK2\n');
    %     else
    %         fprintf('NIE');
    %         xP2-xP
    %     end
    
    X(i,:)=[0, x01, x01p, x02p, x02, xR, xP, xT];
    Y(i,:)=[0, y01, y01p, y02p, y02, yR, yP, yT];
    Z(i,:)=[0, z01, z01p, z02p, z02, zR, zP, zT];
    fi(i,:)=[f1,f2,f3,f4,f5];
    % %sprawdzanie odled³oœci
    % odl=@(x,y,z,x1,y1,z1)sqrt((x-x1)^2+(y-y1)^2+(z-z1)^2);
    % odl(X(7),Y(7),Z(7),X(6),Y(6),Z(6))
    %
    % %sprawdzanie sin i cos
    % odl=@(s,c)sqrt((s)^2+(c)^2);
    % odl(S234,C234)
    
  
end
end