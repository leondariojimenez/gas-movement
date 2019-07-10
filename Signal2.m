%% Función señal de flujo 
% Se genera una señal de flujo con amplitud y frecuencia variable a partir
% de un instante de tiempo i 
% Entrada: 
% FR: frecuencia respiratoria
% RelI: relación inspiración 
% RelE: relación espiración 
% A1: amplitud para la señal seno de la fase inspiratoria
% A2: amplitud para la señal exponencial de la fase espiratoria
% TP: tiempo de pausa inspiratoria 
% F2: factor del numerador para la frecuencia de la señal exponencial 
% T: tiempo i
function [Y] = Signal2 (FR,RelI,RelE,A1,A2,TP,F2, T)

    TE = round(((60 * RelE) / (FR * (RelI + RelE))),1);                    % Calculo tiempo espiratorio
    TI = round(((60*RelI) / (FR*(RelI + RelE))),1);                        % Calculo tiempo inspiratorio
    TR = round((60 / FR),1);                                               % Tiempo respiratorio total     ;                                                             % Temporal para el tiempo espiratorio en simulación                                                             % Periodo 
    TiC = TI+TP;                                                   
    Frequency1 = (1/TiC);                                                  % Frecuencia para la señal senosoidal 
    Frequency2 = round( F2/ TR,1);                                         % Frecuencia para la señal exponencial 
    P = floor(T/TR);                                       
  %  if (T <= round(((TR-TE)), 1) || ((T-TR) >= 0 && (T-TR) <=TI))      % Condicional para diferenciar entre el TI y el TE y el periodo 
   if(T >= (TR*P) && T<((TR*P)+TI)) 
       tm = Frequency1 * (T-(TR*P));
       Vtemp = A1 * sin(2*pi*tm);
        if(Vtemp <= 0)                                                 % Condicional para evitar valores negativos 
            Vtemp = 0;
        end
   else
        if(T >= (TR*P) + TI)  
            tm = Frequency2 * (T - ((TR*P)+TI));
        end
        % Calculo de la señal exponencial
        Vtemp = -1 * A2 * exp(-tm) + 0;            
    end    

    Y= Vtemp;                                                         
                                                       

end
