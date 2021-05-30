% b) Uklad rownan liniowych z macierza R


clear;
clc;


% Dane pomiarowe (probki)
x = [-5:5]';
y = [-79.1639 -40.7900 -18.7814 -6.3530 -0.4392 ...
    0.8270 0.0585 -1.7477 -3.4384 -6.3580 -9.3875]';


% Liczba danych pomiarowych (probek)
N = length(x);


% Argumenty do narysowania wykresow wielomianow aproksymujacych
args = [-5:0.1:5]';


% Stopnie wielomianow aproksymujacych
n = [1 2 5 8 11 15];


% Czasy dzialania solwera dla roznych stopni wielomianow aproksymujacych
T = zeros( length(n), 1 );


% Bledy aproksymacji dla normy maksimum
error_max = zeros(length(n),1);


% Bledy aproksymacji dla normy euklidesowej
error_Euclid = zeros(length(n),1);


for k=1:length(n)
   
    % Wyznaczenie wspolczynnikow
    tic;
    a = solver2( n(k), x, y, N );
    T(k) = toc;
    
    
    % Wypisanie wspolczynnikow wielomianu aproksymujacego
    fprintf( '\nWspolczynniki wielomianu stopnia %s:', num2str( n(k) ) );
    disp(a');
    
    
    % Odwrocenie kolejnosci wspolczynnikow
    a = flip(a); 
    
    
    % Obliczenie wektora F: 
    % wartosci wielomianu aproksymujacego
    F = polyval(a,x);
    
    
    % Bledy dla wielomianu stopnia k
    error_max(k) = norm(F-y,Inf);
    error_Euclid(k) = norm(F-y,2);
    
    
    % Wykres wielomianu aproksymujacego stopnia k
    figure(k);
    hold on;
    plot( args, polyval(a,args) );
    
    for i=1:N
        plot( x(i),y(i), 'r.', 'MarkerSize', 15, 'Color', 'Red' );
    end
    
    title(['Wielomian stopnia ', num2str( n(k) ), ' na tle danych']);
    xlabel('x');
    ylabel('y');
    legend(['Wielomian stopnia ', num2str( n(k) )], 'Probka danych', 'Location', 'South');
    
    grid on;
    hold off;
end


% Przedstawienie czasow w ms
T = T .* 1000;


% Wykres czasow
hold on;
figure( length(n)+1 );
plot( n, T, '-r.', 'MarkerSize', 25 );
grid on;

title('Czasy dzialania solwera w zaleznosci od stopnia wielomianu aproksymujacego');
xlabel('Stopien wielomianu aproksymujacego n');
ylabel('Czas dzialania solwera [ms]');

hold off;


% Wykres bledow
hold on;
figure( length(n)+2 );
plot( n, error_max, '-o', n , error_Euclid, '-o' );
grid on;

title('Normy bledow aproksymacji w zaleznosci od stopnia wielomianu aproksymujacego');
xlabel('Stopien wielomianu aproksymujacego n');
ylabel('Norma bledu aproksymacji');

legend('Blad aproksymacji w normie maksimum','Blad aproksymacji w normie euklidesowej', 'Location', 'North');
hold off;

