function [t,v, te, ie] = HH(pulsei, perturb)
tspan = [0 1000];
v0 = [-64.9997;0.0529;0.5961;0.3177; 1E-6];
te=[];
num_neurons = 10;
% gsyns = load("gsyns.mat");
% gsyns = gsyns.gsyns;
gsyns = 5.8 * ones(num_neurons, 1);
v0 = repmat(v0, [num_neurons, 1]);

% % Call the ODE solver ode15s.
% options = odeset('MaxStep',1);
% [t,v] = ode15s(@hh,tspan,v0,options);

% include option to save spike times: times in te, variables in ve, event
% type in ie
options = odeset('Events',@spikes,'MaxStep',1);
[t,v,te,ve,ie] = ode15s(@network,tspan,v0,options);

% figure; hold on;
% title("Firing Raster")
% for j=1:num_neurons
%     scatter(te, ie)
% end
% 
% figure; hold on;
% title("Voltage Traces")
% for j=1:num_neurons
%     plot(t,v(:,j*5-4));
% end
% 
% figure; hold on;
% title("Synapse gates")
% for j=1:num_neurons
%     plot(t,v(:,j*5));
% end


% compute conductances and currents
% gna=120;
%     gk=36;
%     gl=0.3;
%     ena=50;
%     ek=-77;
%     el=-54.4;
vm=v(:,1);
m=v(:,2);
h=v(:,3);
n=v(:,4);
gna_t=gna*m.^3.*h;
gk_t=gk*n.^4;
ina=gna*m.^3.*h.*(vm-ena);
ik=gk*n.^4.*(vm-ek);
itotal=gna*m.^3.*h.*(vm-ena)+gk*n.^4.*(vm-ek)+gl*(vm-el);



    % Define the ODE function as nested function, 
    % using the parameter pulsei.
    function dvdt = hh_ring(t, v, iapp)
    c=1;
    gna=120;
    gk=36;
    gl=0.3;
    ena=50;
    ek=-77;
    el=-54.4;
   
    ton=0;
    toff=1000;
    dvdt(1) = (-gna*(v(2)^3)*v(3)*(v(1)-ena)-gk*(v(4)^4)*(v(1)-ek)...
            -gl*(v(1)-el) + iapp)/c;
    dvdt(2) = alpham(v(1))*(1-v(2))-betam(v(1))*v(2);
    dvdt(3) = alphah(v(1))*(1-v(3))-betah(v(1))*v(3);
    dvdt(4) = alphan(v(1))*(1-v(4))-betan(v(1))*v(4);

    dvdt=dvdt';
    
        function am=alpham(x)
            am=-0.1*(x+40)/(exp(-(x+40)/10)-1) + perturb(1);
        end
        
        function bm=betam(x)
            bm=4*exp(-(x+65)/18) + perturb(2);
        end
        
        function ah=alphah(x)
            ah=0.07*exp(-(x+65)/20) + perturb(3);
        end
        
        function bh=betah(x)
            bh=1.0/(exp(-(x+35)/10)+1) + perturb(4);
        end
        
        function an=alphan(x)
            an=-0.01*(x+55)/(exp(-(x+55)/10)-1) + perturb(5);
        end
        
        function bn=betan(x)
            bn=0.125*exp(-(x+65)/80) + perturb(6);
        end
    end
    function dxdt = network(t, v)
        dxdt = zeros(num_neurons*5, 1);
        for i=1:num_neurons
            if (i==1)
              I_syn = gsyns(i) * v(end);
              dvdt = hh_ring(t, v(i*5-4:i*5-1), pulsei + 0.0 * I_syn);
            else
              I_syn = gsyns(i) * v((i-1)*5);
              dvdt = hh_ring(t, v(i*5-4:i*5-1), I_syn);
            end
            
            dxdt(i*5-4:i*5-1) = dvdt;
            taur = 1;
            taud = 5;
            dxdt(i*5) = (1 + tanh(v(i * 5 - 4)/10))/ 2 * (1-v(i*5))/taur - v(i*5) / taud;
        end
        
        
    end

% Events function to output spike times
    function [value,isterminal,direction] = spikes(t,v)
        % Locate the time voltage increases through -10mV
        value = zeros(num_neurons, 1);
        for i=1:num_neurons
            value(i) = v(i*5-4)+10;     % Detect height = 0
        end
        
        isterminal = zeros(num_neurons, 1);   % Don't stop the integration
        direction = ones(num_neurons, 1);   % positive direction only
    end

end
