function [ts, vs, te, ve, ie] = sim_model(ton, toff, odefun, initcs)
    tspan = [ton, toff];
    v0 = initcs;

    options = odeset('Events',@spikes, 'MaxStep',1);
    [ts,vs,te,ve,ie] = ode15s(odefun,tspan,v0,options);
end

% Events function to output spike times
function [value,isterminal,direction] = spikes(t,v)
    % Locate the time voltage increases through -10mV
    value = v(1)+10;     % Detect height = 0
    isterminal = 0;   % Don't stop the integration
    direction = +1;   % positive direction only
end