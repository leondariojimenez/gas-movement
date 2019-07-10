%% Parámetros de entrada

VCO2=0.05;   %Fracción volumen de CO2
VO2=0.14;    %Fracción volumen de O2
VCO2_a=0;    %Fracción volumen de CO2 en el ambiente
VO2_a=0.21;  %Fracción volumen de O2 en el ambiente


%% Archivo de parámetros
ro_O2=1.254; %densidad del O2 (kg/m3) a 37 °C y 101 kPa
ro_CO2=1.731;  %densidad del CO2 (kg/m3) a 37 °C y 101 kPa
PM_O2=32;     %peso molecular del O2 (kg/kmol)
PM_CO2=44;    %peso molecular del CO2 (kg/kmol

%% Cálculo de concentraciones iniciales

Ca=VCO2_a*ro_CO2/PM_CO2;        %Concentración de CO2 en el ambiente (kmol/m3)
C_inicial=VCO2*ro_CO2/PM_CO2;   %Concentración de CO2 en el alveolo (VCO2)(kmol/m3)

Ca_ox=VO2_a*ro_O2/PM_O2;        %Concentración de O2 en el ambiente (kmol/m3)
C_inicial_ox=VO2*ro_O2/PM_O2;   %Concentración de O2en el alveolo (VO2)(kmol/m3)

%% nodos
N=50;             %Número de nodos 

%% Difusividad de gases
D=0.000012805;     %Difusividad del CO2 (m2/s) a 37 °C y 101 kPa (valor promedio) (Tabla excel)
D_ox=0.000017193;     %Difusividad del O2 (m2/s) 37 °C y 101 kPa (valor promedio) (Tabla excel)


%% Función de velocidad
%a=-0.009*3;            %constante 1 para la función velocidad
%b=1.5;                 %constante 2 para la función velocidad
%va=a*sin(b*t);         % en m/s

FR = 20;                                        % Frecuencia respiratoria
RelI = 1;                                       % Relacion inspiracion 
RelE = 2;                                       % Relacion espiracion
Amp1 = 0.5;                                     % Amplitud Senosoidal
Amp2 = 0.7;                                     % Amplitud exponencial
TP = 3;                                       % Tiempo pausa inspiratoria
F2 = 14;                                         % Factor del numerador para la frecuencia de la señal exponencial

 


%% Longitudes-modelo de Weibel (Gráfico definido Aa,;1-3;3-7;7-8;8-9) y según (B. R.WIGGS,R. MORENO,J. C.HOGG,et all)

LAa=0.0005;
L13=0.0043;
L23=L13;
L46=L13;
L56=L13;
L37=0.0736;
L67=L37;
L78=0.0745;
L89=0.12;

%% Áreas-modelo de Weibel (Gráfico del tablero) en m^2
%A13=15202/10000; este dato esta malo pues es 152.02
%A13=1922/10000; este es el promedio de las generaciones 23 a 18
Aa=5607.38/10000;
A13i=2877.39/10000 ;% agrego este valor porque es lo que pasa en la via aera a nivel alveolar
A13f=259.91/10000 ; % agrego este valor porque es lo que pasa en la via aera a nivel alveolar
%A23=A13;
%A46=A13;
%A56=A13;
%A37i=15202/10000; este dato esta malo pues es 152.02
A37i=259.91/10000; % el dato que habia era 1922 y lo corrijo por este
A37f=1.46/10000;   % eldato que habia era 1.19 y lo corrijo por este 
%A67i=A37i;
%A67f=A37f;
A78f=1.46/10000;   % eldato que habia era 1.8 y lo corrijo por este
A89f=2.2/10000;

%% dL diferenciales de longitud para cada tramo en m

dLAa=LAa/(N-1);
dL13=L13/(N-1);   %Separación de los nodos
dL23=dL13; 
dL46=dL13; 
dL56=dL13; 
dL37=L37/(N-1);
dL67=dL37; 
dL78=L78/(N-1);
dL89=L89/(N-1);

%% Vectores de áreas
% Vectores para los tramos cuya área transversal es variable

A13=linspace (Aa,A13i,N+1); % lo agrego porque ya eltramo A13 es area transversal variable
A37=linspace(A13f,A37f,N+1);  % corrijo A13 por A13f 
A78=linspace(A37f,A78f,N+1);
A89=linspace(A78f,A89f,N+1);
