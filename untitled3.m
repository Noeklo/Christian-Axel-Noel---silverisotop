N = data{2};               % Uppmätta pulser
B = background_data{2};    % Bakgrundspulser

Y = N - B;
fel = sqrt(N + B);         % Statistisk osäkerhet

semilogy(X,Y)
valid = (Y > 0);

errorbar(X(valid), Y(valid), fel(valid), 'o');
set(gca, 'XScale', 'linear', 'YScale', 'log');

xlabel('X');
ylabel('Antal pulser efter bakgrundssubtraktion');
grid on;

% Klicka på två ställen där du vill att linjen ska gå
[xP, yP] = ginput(2);

% Beräkna lutning och intercept i logaritmisk skala
k = (log(yP(2)) - log(yP(1))) / (xP(2) - xP(1));
b = log(yP(1)) - k*xP(1);

% Beräkna linjen över hela diagrammet
xLinje = linspace(min(X), max(X), 500);
yLinje = exp(k*xLinje + b);

% Rita ovanpå dina felstaplar
hold on;
plot(xLinje, yLinje, '-', 'LineWidth', 2);
hold off

T_lang = -log(2)/k;
%%

% Långlivades bidrag vid varje ursprunglig mätpunkt
Y_lang = exp(k*X + b);

% Dra bort det från de b0akgrundskorrigerade värdena
Y_kort = Y - Y_lang;

% Visa den kortlivade komponenten i ett nytt diagram
valid_kort = Y_kort > 0;

figure;
errorbar(X(valid_kort), Y_kort(valid_kort), ...
         fel(valid_kort), 'o');

set(gca, 'XScale', 'linear', 'YScale', 'log');
xlabel('X');
ylabel('Kortlivad komponent: antal pulser');
grid on;

% Klicka två gånger längs den tidiga, ungefär raka trenden
[xK, yK] = ginput(2);

k_kort = (log(yK(2)) - log(yK(1))) / (xK(2) - xK(1));
b_kort = log(yK(1)) - k_kort*xK(1);

hold on;
plot(xLinje, exp(k_kort*xLinje + b_kort), ...
     'r-', 'LineWidth', 2);
hold off;

T_kort = -log(2)/k_kort
T_lang
