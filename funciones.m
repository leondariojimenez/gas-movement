function F=funciones(time,x) 
% Archivo de ecuaciones de balance de masa para el CO2 Y O2
% x es la variable concentración y time esel tiempo

param


%% velocidades (velocidad de entrada)

Flow = Signal2(FR,RelI,RelE,Amp1,Amp2,TP,F2,time); 
%% Tramo Aa
%le damos las condiciones de frontera
F(1,1)=0;  %en Aai

for i=2:N
    
    if Flow>=0 %Esquema upwind
      F(i,1)=D*(x(i-1)-2*x(i)+x(i+1))/(dLAa^2)-Flow*(x(i)-x(i-1))/(dLAa);   %Nodos internos
    else
        F(i,1)=D*(x(i-1)-2*x(i)+x(i+1))/(dLAa^2)-Flow*(x(i+1)-x(i))/(dLAa);   %Nodos internos
    end
end


%% Tramo 13

for i=N+1:2*N
    
    if Flow>=0 %Esquema upwind
      F(i,1)=D*(x(i-1)-2*x(i)+x(i+1))/(dL13^2)-Flow*(Aa/A13(i-N+1))*(x(i)-x(i-1))/(dL13);   %Nodos internos
    else
        F(i,1)=D*(x(i-1)-2*x(i)+x(i+1))/(dL13^2)-Flow*(Aa/A13(i-N+1))*(x(i+1)-x(i))/(dL13);   %Nodos internos
    end
end
%% Tramo 37

for i=2*N+1:3*N
    
    if Flow>=0 %Esquema upwind
      F(i,1)=D*(x(i-1)-2*x(i)+x(i+1))/(dL37^2)-Flow*(Aa/A37(i-2*N+1))*(x(i)-x(i-1))/(dL37);   %Nodos internos
    else
        F(i,1)=D*(x(i-1)-2*x(i)+x(i+1))/(dL37^2)-Flow*(Aa/A37(i-2*N+1))*(x(i+1)-x(i))/(dL37);   %Nodos internos
    end
end

%% Tramo 78 (nodos: 3*N+1 hasta 4*N)

for i=3*N+1:4*N
    
    if Flow>=0 %Esquema upwind
      F(i,1)=D*(x(i-1)-2*x(i)+x(i+1))/(dL78^2)-Flow*(Aa/A78(i-3*N+1))*(x(i)-x(i-1))/(dL78);   %Nodos internos
    else
        F(i,1)=D*(x(i-1)-2*x(i)+x(i+1))/(dL78^2)-Flow*(Aa/A78(i-3*N+1))*(x(i+1)-x(i))/(dL78);   %Nodos internos
    end
end

%% Tramo 89 (nodos: 4*N+1 hasta 5*N)


F(5*N,1)=0;  %Concentración del ambiente constante


for i=4*N+1:5*N-1
    
    if Flow>=0 %Esquema upwind
      F(i,1)=D*(x(i-1)-2*x(i)+x(i+1))/(dL89^2)-Flow*(Aa/A89(i-4*N+1))*(x(i)-x(i-1))/(dL89);   %Nodos internos
    else
        F(i,1)=D*(x(i-1)-2*x(i)+x(i+1))/(dL89^2)-Flow*(Aa/A89(i-4*N+1))*(x(i+1)-x(i))/(dL89);   %Nodos internos
    end
end
end
