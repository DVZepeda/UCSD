% TEST
as=RR_poly([1 2 3 4 5]), bs=RR_poly([1 2 3 6])   % Define a couple of test polynomials

Gs = RR_tf(bs, as);

h = 0.1;

% Convert Poles and Zeros to the z domain
for i = 1:length(Gs.p)
    p_zd(i) = exp(Gs.p(i).*h);
end

for i = 1:length(Gs.z)
    z_zd(i) = exp(Gs.z(i).*h);
end

Gz = RR_tf(z_zd,p_zd,1)

r = length(Gz.p) - length(Gz.z)
% add
for i = 1:r
    Gz.z(length(Gz.z)+i) = -1;
end
