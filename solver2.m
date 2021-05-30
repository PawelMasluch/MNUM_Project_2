function a = solver2(n, x, y, N)
% Znajdowanie wspolczynnikow wielomianu
% aproksymujacego stopnia n: W(t) = a_1 + a_2*t + ... + a_(n+1) * t^n,
% za pomoca metody najmniejszych kwadratow (uklad rownan liniowych z macierza R)

% n - stopien poszukiwanego wielomianu aproksymujacego
% a - poszukiwane wspolczynniki wielomianu aproksymujacego
% x, y - wektory danych pomiarowych (probek) 
% N - liczba punktow pomiarowych (probek)


    % Generacja macierzy A
    A = zeros( N, n+1 );

    for i=1:N
        for j=1:n+1
            A(i,j) = x(i)^(j-1);
        end
    end
    
    
    % Wyznaczenie macierzy Q, R (rozklad QR macierzy A)
    [Q, R] = qr(A,0);
    
    
    % Obliczenie wektora a:
    % nieznanych wspolczynnikow wielomianu
    % aproksymujacego (wspolczynniki od wyrazu
    % wolnego do wyrazu przy najwyzszej 
    % potedze zmiennej x)
    if n+1 < N % rozklad waski QR
        a = inv(R) * Q.' * y;
    else % rozklad pelny QR
        a = inv(R.' * R) * A.' * y;
    end

end

