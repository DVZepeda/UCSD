function Gz = DVZ_C2D_matched(bs, as, h, omega_bar,causal_type)
% Convert a continuous-time transfer function D(s) to a discrete-time
% transfer function D(z) using the matched z-transform method.
%
% INPUTS:
%   bs - Numerator in the RR_poly Class
%   as - Denominator in the RR_poly Class
%   h - Time step
%   omega_bar - Frequency of interest (optional, default: 0)
%   causal_type - 'semi-causal' (0) or 'strictly-causal' (1) (optional, default: 'semi-causal')
%
% OUTPUTS:
%   Gz - Transfer function G(z)
%
% NOTES:
%   - Supports symbolic variables in bs and as.
%   - Follows the heuristic pole-zero mapping method.
%
% Reference: Footnote 14 of Section 9.3 of RR.
%   
% Example usage:
%   syms s z z1 p1;
%   bs = RR_poly([1 z1]);
%   as = RR_poly([1 p1 0]);
%   h = 0.1;
%   omega_bar = 1;  % Example frequency of interest
%   causal_type = 0 %'semi-causal' or (1) 'strictly-causal'
%   Gz = DVZ_C2D_matched(bs, as, h, omega_bar, causal_type);

% set values for variables if, they weren't included
if nargin == 3
    omega_bar = 0;
    causal_type = 0;
elseif nargin == 4
    causal_type = 0;
end

% Create the Transfer Function G(s)
Gs = RR_tf(bs, as);

p_zd = [];
z_zd = [];

% Convert Poles and Zeros to the z domain
for i = 1:length(Gs.p)
    p_zd(i) = exp(Gs.p(i).*h);
end


for i = 1:length(Gs.z)
    z_zd(i) = exp(Gs.z(i).*h);
end

% Create new transfer function 
Gz = RR_tf(z_zd,p_zd,1)

% Assign Number of zeros at infinity
r = length(Gz.p) - length(Gz.z)

% Adjust number of infinite zeros added to D(z)
if causal_type == 1
    r = r-1;
end

% add the infinite zeros
if r > 0
    for i = 1:r
        Gz.z(length(Gz.z)+i) = -1;
    end
end
% Calculate the Gain Given the omega_bar value
ks = i*omega_bar;
DC_gains = RR_evaluate(Gs,ks);

DC_gainz = RR_evaluate(Gz,exp(i*omega_bar*h));

kz = DC_gains/DC_gainz;

Gz.K = Gz.K * kz;

end