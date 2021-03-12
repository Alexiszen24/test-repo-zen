spectra = importdata("spectra.csv");
lambdaStart = importdata("lambda_start.csv");
lambdaDelta = importdata("lambda_delta.csv");
starNames = importdata("star_names.csv");
lambdaPr = 656.28; %нм
speed_of_light = 299792.458; %км/с
nObs = size(spectra, 1);
nAmount = size((spectra)', 1);
lambdaEnd = lambdaStart + (nObs -1)* lambdaDelta;
lambda = (lambdaStart :  lambdaDelta : lambdaEnd)';
z = 1:nAmount; 
fg = figure;
hold on;
grid on;
text(lambdaStart + 5, 0.2*10^(-13), ['Зенькович Алексей Б01-009']);
for shet = 1 : nAmount
    s = spectra(:, shet);
    [sHa, idx] = min(s);
    lambdaHa = lambda(idx);
    z(shet) = (lambdaHa / lambdaPr) - 1;
    
    if (z(shet) < 0)
        p = plot(lambda, s,'--','Color',[rand(1) rand(1) rand(1)]);
        p.LineWidth = 1;
    else
        p = plot(lambda, s, 'Color',[rand(1) rand(1) rand(1)]);
        p.LineWidth = 3; 
    end  
end
xlabel('Длина волны, нм');
ylabel(['Интенсивность, эрг/см^2/с/', char(197)]);
title('Спектры звезд');
legend(starNames);
set(fg, 'Visible', 'on'); 
saveas(fg, 'spacemotion.png');
speed = (speed_of_light * z)';
movaway = starNames(z > 0)
