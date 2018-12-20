function trying_some_things()
   vs = linspace(-90, 60, 1000);
   figure(); 
   ams = alpha_m(vs);
   plot(vs, ams)
   figure();
   den = 1./(alpha_m(vs) + beta_m(vs));
   plot(vs, den);
   
   num_p = polyfit(vs,ams,4);
   den_p = polyfit(vs, den,5);
   
   ams_eval = polyval(num_p, vs);
   den_eval = polyval(den_p, vs);
   
   figure();hold on;
   plot(vs, ams_eval);
   plot(vs, ams);
   legend("num", "den")
   
   figure(); hold on;
   plot(vs, den_eval);
   plot(vs, den);
   
   legend("den", "num")
   
   minf_polys = ams_eval .* den_eval;
   minfs = ams .* den;
   figure(); hold on;
   plot(vs, minfs);
   plot(vs, minf_polys);

end

function m = m_inf(v)
    m = alpha_m(v)./(alpha_m(v) + beta_m(v));
end
function am = alpha_m(v)
    am = ((v + 45)./10)./(1-exp(-(v+45)/10));
end
function bm = beta_m(v)
    bm = 4*exp(-(v+70)/18);
end