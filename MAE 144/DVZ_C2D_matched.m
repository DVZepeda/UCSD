function [bz, az] = DVZ_C2D_matched(bs, as, h, omega_bar,causal_type)
% Convert a continuous-time transfer function D(s) to a discrete-time
% transfer function D(z) using the matched z-transform method.
%
% INPUTS:
%   bs - Numerator in the RR_poly Class
%   as - Denominator in the RR_poly Class
%   h - Time step
%   omega_bar - Frequency of interest (optional, default: 0)
%   causal_type - 'semi-causal' or 'strictly-causal' (optional, default: 'semi-causal')
%
% OUTPUTS:
%   bz - Numerator coefficients of D(z)
%   az - Denominator coefficients of D(z)
%
% NOTES:
%   - Supports symbolic variables in bs and as.
%   - Follows the heuristic pole-zero mapping method.
%
% Reference: Footnote 14 of Section 9.3 of RR.
%   
% Example usage:
%   syms s z z1 p1;
%   bs = s + z1;
%   as = s * (s + p1);
%   h = 0.1;
%   omega_bar = 1;  % Example frequency of interest
%   causal_type = 'semi-causal';  % or 'strictly-causal'
%   [bz, az] = DVZ_C2D_matched(bs, as, h, omega_bar, causal_type);

% Create the Transfer Function G(s)
Gs = RR_tf(bs, as);

% Convert Poles and Zeros to the z domain
for i = 1:length(Gs.p)
    p_zd(i) = exp(Gs.p(i)*h);
end

for i = 1:length(Gs.z)
    z_zd(i) = exp(Gs.z(i)*h);
end

% convert back to RR_poly class
p_zd = RR_poly(p_zd)
z_zd = RR_poly(z_zd)









% % Map poles and finite zeros
% az = subs(as, sym('s'), log(sym('z'))/h);
% bz = subs(bs, sym('s'), log(sym('z'))/h);
% 
% % Map infinite zeros
% if strcmp(causal_type, 'strictly-causal')
%     % Map an infinite zero to z = ∞
%     bz = subs(bz, sym('z'), inf);
% else
%     % Map infinite zeros to z = -1
%     bz = subs(bz, sym('z'), -1);
% end
% 
% % Set gain at omega_bar
% if nargin > 3
%     az_at_omega = subs(as, sym('s'), 1i*omega_bar);
%     bz_at_omega = subs(bs, sym('s'), 1i*omega_bar);
%     gain_ratio = abs(bz_at_omega) / abs(az_at_omega);
%     bz = bz * gain_ratio;
% end
% 
% % Simplify the resulting transfer function
% [bz, az] = RationalSimplify(bz, az);
% 
% end