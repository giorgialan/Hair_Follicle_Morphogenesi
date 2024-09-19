close all
clear all
clc

plotting = 1;   
compute = 1;   

npoints = 200;
fnameBif = ['Matfiles/TuringBifurcations' num2str(npoints) '.mat'];
if compute || ~exist(fnameBif, 'file')
    k = 2; 
    lambda = 0.08; 
    mu = 0.04;
    rspace = logspace(-2, 4, npoints);
    rho1 = 3.37; 
    gamma = 2; 
    Dx = 1;
    Dyspace = logspace(-4, 1, npoints);
    qspace = logspace(-5, 5, 200);
    U = meshgrid(rspace, rspace);
    V = meshgrid(Dyspace, Dyspace)';

    raw2 = arrayfun(@(rho2, Dy) Bifurcation_Turing(k, lambda, mu, rho1, rho2, gamma, Dx, Dy, qspace), U, V);
    Bif2 = reshape(raw2, npoints, npoints);

    mkdir Matfiles
    save(fnameBif, 'qspace', 'rspace', 'Dyspace', 'Bif2')
else
    load(fnameBif)
end

T = 5000;
fnamePDE = ['Matfiles/TuringPDE' num2str(T) '.mat'];
if compute || ~exist(fnamePDE, 'file')
    [x, concentration_u, concentration_v] = TuringPDE(T, plotting);
    pde2 = concentration_u; 
    mkdir Matfiles
    save(fnamePDE, 'pde2', 'x')
else
    load(fnamePDE)
end

Bifs = {Bif2};
pdes = {pde2};
lw = 1;
greyscale = [0 0 0; 1 1 1; 0.75 0.75 0.75];
xlims = [1e-2 1e4];
ylims = [1e-4 1e1];
clims = [0 1.5];

left = 0.075;
bottom = 0.1;
width = 0.24;
height = 0.36;
dy = 0.49;

dim = 225;
fwidth = 2*dim + 100;
fheight = 2*dim + 50;
dx = dim / fwidth;

f1 = figure(1);
f1.Position = [100 100 fwidth fheight];

for i = 1:1
    ax(i) = subplot('position', [left bottom + dy width height]);
    area([5 6], [100 200], 100, 'FaceColor', 'w')
    hold on
    surf(rspace, Dyspace, Bifs{i})
    set(gca, 'Xtick', 10.^(-2:2:4), 'Yscale', 'log', 'Ydir', 'reverse', 'Xscale', 'log', 'layer', 'top', 'LineWidth', lw, 'tickdir', 'out');
    colormap(ax(i), greyscale)
    axis([xlims ylims])
    caxis([0 3])
    shading flat
    grid off
    box off
    view([0 90])
    hold on
    hs(1) = area([5 6], [100 200], 100, 'FaceColor', greyscale(2, :));
    hs(2) = area([5 6], [100 200], 100, 'FaceColor', greyscale(1, :));
    hs(3) = area([5 6], [100 200], 100, 'FaceColor', greyscale(3, :));
    hold off
    legend(hs, {'Stable', 'Patterns', 'Unstable'}, 'position', [0.87 0.75 0.12 0.05])
end

for i = 1:1
    subplot('position', [left bottom width height]);
    surf(x, x, pdes{i});
    set(gca, 'layer', 'top', 'LineWidth', lw, 'tickdir', 'out')
    axis([min(x) max(x) min(x) max(x)])
    caxis(clims)
    shading flat
    grid off
    view([0 90])
end

if ~exist('Figures', 'dir')
    mkdir('Figures');
end

colorbar('position', [2 * dx + 0.04 bottom 0.02 height]);
print('-depsc2', '-r600', 'Figures/TuringExample')

return
