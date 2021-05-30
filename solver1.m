function a = solver1(n, x, y, N)
% Znajdowanie wspolczynnikow wielomianu
% aproksymujacego stopnia n: W(t) = a_1 + a_2*t + ... + a_(n+1) * t^n,
% za pomoca metody najmniejszych kwadratow (uklad rownan normalnych)

% n - stopien poszukiwanego wielomianu aproksymujacego
% a - poszukiwane wspolczynniki wielomianu aproksymujacego
% x, y - wektory danych pomiarowych (probek) 
% N - liczba punktow pomiarowych (probek)


% Generacja macierzy G
G = zeros( n+1, n+1 );

for i=1:n+1
    % Elementy ponizej diagonali
    for k=1:i-1
        G(i,k) = G(k,i);
    end
    
    % Pozostale elementy
    for k=i:n+1
        for j=1:N
            G(i,k) = G(i,k) + x(j)^(i+k-2);
        end
    end
end


% Generacja wektora ro
ro = zeros(n+1,1);

for k=1:n+1
    for j=1:N
        ro(k) = ro(k) + y(j)*x(j)^(k-1);
    end
end


% Obliczenie wektora a:
% nieznanych wspolczynnikow wielomianu
% aproksymujacego (wspolczynniki od wyrazu
% wolnego do wyrazu przy najwyzszej 
% potedze zmiennej)
a = inv(G)*ro;

end

