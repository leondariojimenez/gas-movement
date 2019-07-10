clear all
clc
close all

param


tfinal=6; %Tiempo total de simulación (s) 

%% Vector de condiciones iniciales de CO2
for k=1:5*N
    C0(k)=Ca;  % Concentración de CO2 en el alveolo(kmol/m3)
end
C0(1)=C_inicial; 

%% Vector de condiciones iniciales de O2
for k=1:5*N
    C0_ox(k)=Ca_ox;  % Concentración de O2 el alveolo(kmol/m3)
end
C0_ox(1)=C_inicial_ox; 

%% Solución 
% El ode 15s se usa cuando el sistema es tipo Stiff; sin embargo, es
% preferible usar el ode45

%[t,C]=ode45(@funciones,[0,tfinal],C0);
[t,C]=ode15s(@funciones,[0,tfinal],C0);  %Solución para el CO2
[t_ox,C_ox]=ode15s(@funciones,[0,tfinal],C0_ox);  %Solución para el O2
%% Gráfica de la velocidad en el tiempo

ti=linspace(0,tfinal,10000*tfinal);  %vector de tiempos
%a=0.009*3;            %constante 1 para la función velocidad senoidal
%b=1.5;                %constante 2 para la función velocidad senoidal

for i=1:length(ti)    
   % v(i)=a.*sin(b.*ti(i));  %vector de velocidad Senoidal
    v(i) = Signal2(FR,RelI,RelE,Amp1,Amp2,TP,F2,ti(i)); %Vector velocidad real 
end
figure
plot(ti(:),v(:))
xlabel('Tiempo (s)'),ylabel('Velocidad (m/s)'), grid on

%% Postprocesado

[m,n]=size(C) ;  %Tamaño del vector solución de CO2
[m_ox,n_ox]=size(C_ox) ;  %Tamaño del vector solución de O2

xAa=linspace(0,LAa,N); % agregado por mi vector distancias Aa
x13=linspace(LAa+dLAa,LAa+L13,N);  %verctor ditancias 13  
x37=linspace(LAa+L13+dL37,LAa+L13+L37,N);  %verctor ditancias 37
x78=linspace(LAa+L13+L37+dL78,LAa+L13+L37+L78,N);  %verctor ditancias 78
x89=linspace(LAa+L13+L37+L78+dL89,LAa+L13+L37+L78+L89,N);  %verctor ditancias 89

x=[xAa x13 x37 x78 x89];  %vector disditancia desde 1 hasta 9

%% Figuras
%% Concentracion vs tiempo del CO2
figure('Name','Concentración de CO_2 vs tiempo')
plot(t(:),C(:,2),'-k',t(:),C(:,N+1),'-b',t(:),C(:,2*N+1),'-m',t(:),C(:,3*N+1),'-r',t(:),C(:,4*N+1),'--k',t(:),C(:,5*N-1),'-.k'  )
xlabel('Tiempo (s)'),ylabel('Concentración de CO_2 (kmol/m^3)'), grid on
legend('Nodo 2','Nodo N+1','Nodo 2*N+1','Nodo 3*N+1','Nodo 4*N+1','Boca','Location','Best');
%set(gcf, 'Visible', 'off');

%% Concentracion vs tiempo del O2
figure('Name','Concentración de O_2 vs tiempo')
plot(t_ox(:),C_ox(:,2),'-k',t_ox(:),C_ox(:,N+1),'-b',t_ox(:),C_ox(:,2*N+1),'-m',t_ox(:),C_ox(:,3*N+1),'-r',t_ox(:),C_ox(:,4*N+1),'--k',t_ox(:),C_ox(:,5*N-1),'-.k'  )
xlabel('Tiempo (s)'),ylabel('Concentración de O_2 (kmol/m^3)'), grid on
legend('Nodo 2','Nodo N+1','Nodo 2*N+1','Nodo 3*N+1','Nodo 4*N+1','Boca','Location','Best');
%set(gcf, 'Visible', 'off');

%% Concentración vs posición de CO2
figure('Name','Concentración de CO_2 vs posición')
semilogx(x(:),C(1,:),'-k',x(:),C(floor(m/2),:),'-r',x(:),C(m,:),'-b')
xlabel('Posición (m)'),ylabel('Concentración de CO_2 (kmol/m^3)'), grid on
hold on 
plot([LAa LAa], [0 0.003],'-.r')
hold on
plot([L13 L13],[0 0.003],'--k')
hold on
plot([L13+L37 L13+L37],[0 0.003],'-.m')
hold on
plot([L13+L37+L78 L13+L37+L78],[0 0.003],'--b')
axis([0 L13+L37+L78+L89 0 0.003])
legend('0 s',num2str(t(floor(m/2))),num2str(t(m)),'Punto A','Punto 3','Punto 7','Punto 8','Location','north');

%% Concentracion vs posición del O2
figure('Name','Concentración de O_2 vs posición')
semilogx(x(:),C_ox(1,:),'-k',x(:),C_ox(floor(m_ox/2),:),'-r',x(:),C_ox(m_ox,:),'-b')
xlabel('Posición (m)'),ylabel('Concentración de O_2 (kmol/m^3)'), grid on
hold on 
plot([LAa LAa], [0.005 0.01],'-.r')
hold on
plot([L13 L13],[0.005 0.01],'--k')
hold on
plot([L13+L37 L13+L37],[0.005 0.01],'-.m')
hold on
plot([L13+L37+L78 L13+L37+L78],[0.005 0.01],'--b')
axis([0 L13+L37+L78+L89 0.005 0.01])
legend('0 s',num2str(t_ox(floor(m_ox/2))),num2str(t_ox(m_ox)),'Punto A','Punto 3','Punto 7','Punto 8','Location','north');


%% Animación  CO2

figure('Name','Distribución de concentración de CO_2')
title('Distribución de concentración de CO_2')
semilogx(x(:),C(1,:),'-k')
%plot(x(:),C(1,:),'-k')
xlabel('Posición (m)'),ylabel('Concentración (kmol/m^3)'), grid on
axis([0 LAa+L13+L37+L78+L89 0 0.003])
set(gca,'nextplot','replacechildren');
set(gcf,'Renderer','zbuffer');


for j=1:m
    
    semilogx(x(:),C(j,:),'-k',[LAa LAa], [0 0.003],'-.r',[LAa+L13 LAa+L13],[0 0.003],'--k',[LAa+L13+L37 LAa+L13+L37],[0 0.003],'-.m',[LAa+L13+L37+L78 LAa+L13+L37+L78],[0 0.003],'--b')
    %plot(x(:),C(j,:),'-k',[L13 L13],[0 0.003],'--k',[L13+L37 L13+L37],[0 0.003],'-.k',[L13+L37+L78 L13+L37+L78],[0 0.003],'--b')
    xlabel('Posición (m)'),ylabel('Concentración (kmol/m^3)'), grid on     
    axis([0 LAa+L13+L37+L78+L89 0 0.003])   
    title('Distribución de concentración de CO_2')
    xlabel('Posición (m)'),ylabel('Concentración (kmol/m^3)'), grid on
    axis([0 LAa+L13+L37+L78+L89 0 0.003])
    legend(num2str(t(j)),'Punto A','Punto 3','Punto 7','Punto 8','Location','southoutside');   
    mov(j) = getframe(gcf);

   end

%movie2avi(mov, 'Simulación_O2', 'compression', 'None');

%% Animación  O2

figure('Name','Distribución de concentración de O_2')
title('Distribución de concentración de O_2')
%semilogx(x(:),C_ox(1,:),'-k')
semilogx(x(:),C_ox(1,:),'-b', [LAa LAa], [0.005 0.01],'-.r',[LAa+L13 LAa+L13],[0.005 0.01],'--k',[LAa+L13+L37 LAa+L13+L37],[0.005 0.01],'-.m',[LAa+L13+L37+L78 LAa+L13+L37+L78],[0.005 0.01],'--b')
%plot(x(:),C_ox(1,:),'-b',[L13 L13],[0 0.003],'--k',[L13+L37 L13+L37],[0 0.003],'-.k',[L13+L37+L78 L13+L37+L78],[0 0.003],'--b')
xlabel('Posición (m)'),ylabel('Concentración (kmol/m^3)'), grid on
axis([0 LAa+L13+L37+L78+L89 0.005 0.01])
set(gca,'nextplot','replacechildren');
set(gcf,'Renderer','zbuffer');


for j=1:m_ox
    semilogx(x(:),C_ox(j,:),'-b',[LAa LAa], [0.005 0.01],'-.r',[LAa+L13 LAa+L13],[0.005 0.01],'--k',[LAa+L13+L37 LAa+L13+L37],[0.005 0.01],'-.m',[LAa+L13+L37+L78 LAa+L13+L37+L78],[0.005 0.01],'--b')
    %plot(x(:),C_ox(j,:),'-b',[L13 L13],[0 0.01],'--k',[L13+L37 L13+L37],[0 0.01],'-.k',[L13+L37+L78 L13+L37+L78],[0 0.01],'--b')
    xlabel('Posición (m)'),ylabel('Concentración (kmol/m^3)'), grid on
    title('Distribución de concentración de O_2')
    xlabel('Posición (m)'),ylabel('Concentración (kmol/m^3)'), grid on
    axis([0 LAa+L13+L37+L78+L89 0.005 0.01])
    legend(num2str(t(j)),'Punto A','Punto 3','Punto 7','Punto 8','Location','southoutside');
    mov(j) = getframe(gcf);
   
end

 %movie2avi(mov, 'Simulación_O2', 'compression', 'None');
