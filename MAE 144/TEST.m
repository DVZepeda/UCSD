% TEST
as=RR_poly([1 2 3]), bs=RR_poly([1 2 3 4 5 6])   % Define a couple of test polynomials

Gs = RR_tf(bs, as);

h = 0.1;

% Convert Poles and Zeros to the z domain
for i = 1:length(Gs.p)
    p_zd(i) = exp(Gs.p(i)*h);
end

for i = 1:length(Gs.z)
    z_zd(i) = exp(Gs.z(i)*h);
end

% convert to RR_poly class
p_zd = RR_poly(p_zd)