function proyecto_metodos_numericos()

% Proyecto de Métodos Numéricos - Menú Principal

opcion = -1;

while opcion ~= 0
    fprintf('==============================\n');
    fprintf('  PROYECTO - MÉTODOS NUMÉRICOS\n');
    fprintf('==============================\n');
    fprintf('1. Comparación: Bisección / Newton / Secante / Punto Fijo\n');
    fprintf('2. Derivación Numérica\n');
    fprintf('3. Interpolación de Lagrange\n');
    fprintf('0. Salir\n');
    fprintf('------------------------------\n');
    
    opcion = input('Seleccione una opción: ');
    
    switch opcion
        % Ejecutar la opción seleccionada
        case 1
            % Punto 1 del proyecto
            fprintf('\nEjecutando comparación de métodos...\n');
            pause(1);  
            comparacion_metodos_numericos();
            
        case 2
            % Punto 2 del proyecto
            fprintf('\nEjecutando derivación numérica...\n');
            pause(1);
            derivacion_numerica();
            
        case 3
            % Punto 3 del proyecto
            fprintf('\nEjecutando interpolación de Lagrange...\n');
            pause(1);
            interpolacion_lagrange(); 
            
        case 0
            % Salir del programa
            fprintf('\nSaliendo del programa. ¡Hasta luego!\n');
            pause(1);
        otherwise
            % Opción no válida
            fprintf('\nOpción no válida. Intente de nuevo.\n');
            pause(1.5);
    end
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARTE 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function comparacion_metodos_numericos()
    % Función principal que compara los cuatro métodos numéricos
    
    fprintf('\n══════════════════════════════════════════════════════════════\n');
    fprintf('           COMPARACIÓN DE MÉTODOS NUMÉRICOS      \n');
    fprintf('══════════════════════════════════════════════════════════════\n\n');
    
    % Solicitar datos de entrada
    fprintf('Ingrese la función f(x): ');
    f_str = input('', 's');
    f = str2sym(f_str);
    F = matlabFunction(f);
    
    fprintf('Ingrese la función g(x) para punto fijo: ');
    g_str = input('', 's');
    g = str2sym(g_str);
    G = matlabFunction(g);
    
    fprintf('\n=== Parámetros para los métodos ===\n');
    x0 = input('Aproximación inicial x0 (para Newton y Punto Fijo): ');
    x1 = input('Segunda aproximación x1 (para Secante): ');
    a = input('Límite inferior del intervalo a: ');
    b = input('Límite superior del intervalo b:  ');
    n = input('Número máximo de iteraciones: ');
    tol = input('Tolerancia aceptable: ');
    
    % Validar intervalo para bisección
    if F(a)*F(b) >= 0
        fprintf('\n¡Advertencia! f(a)*f(b) >= 0. El método de bisección puede no converger.\n');
    end
    
    % Ejecutar todos los métodos
    fprintf('\n══════════════════════════════════════════════════════════════\n');
    fprintf('                     RESULTADOS OBTENIDOS                     \n');
    fprintf('══════════════════════════════════════════════════════════════\n');
    
    % Método de Bisección
    fprintf('\n1. MÉTODO DE BISECCIÓN:\n');
    raiz_biseccion = biseccion(a, b, F, tol, n);
    
    % Método de Newton-Raphson
    fprintf('\n2. MÉTODO DE NEWTON\n');
    df = diff(f);
    DF = matlabFunction(df);
    raiz_newton = newton(x0, F, DF, tol, n);
    
    % Método de la Secante
    fprintf('\n3. MÉTODO DE LA SECANTE:\n');
    raiz_secante = secante(x0, x1, F, tol, n);
    
    % Método del Punto Fijo
    fprintf('\n4. MÉTODO DEL PUNTO FIJO:\n');
    raiz_puntofijo = punto_fijo(F, G, x0, tol, n);
    validar_relacion_f_g(F, G, x0, a, b);

    % Mostrar resumen comparativo
    fprintf('\n══════════════════════════════════════════════════════════════\n');
    fprintf('                RESUMEN COMPARATIVO DE RESULTADOS             \n');
    fprintf('══════════════════════════════════════════════════════════════\n');
    fprintf("Metodo: Bisección     | Raiz = " + num2str(raiz_biseccion(1), '%.15f') + ...
            " | Iteraciones = " + num2str(raiz_biseccion(2)) + ...
            " | Error = " + num2str(raiz_biseccion(3), '%.15f') + "\n");
    
    fprintf("Metodo: Newton        | Raiz = " + num2str(raiz_newton(1), '%.15f') + ...
            " | Iteraciones = " + num2str(raiz_newton(2)) + ...
            " | Error = " + num2str(raiz_newton(3), '%.15f') + "\n");
    
    fprintf("Metodo: Secante       | Raiz = " + num2str(raiz_secante(1), '%.15f') + ...
            " | Iteraciones = " + num2str(raiz_secante(2)) + ...
            " | Error = " + num2str(raiz_secante(3), '%.15f') + "\n");
    
    fprintf("Metodo: Punto Fijo    | Raiz = " + num2str(raiz_puntofijo(1), '%.15f') + ...
            " | Iteraciones = " + num2str(raiz_puntofijo(2)) + ...
            " | Error = " + num2str(raiz_puntofijo(3), '%.15f') + "\n");
    fprintf('\n');
end

function resultado = biseccion(a, b, F, tol, n)
    % Método de bisección para encontrar raíces
   fprintf("\n");
    fprintf("==========================Biseccion==================================\n");
    fprintf("\n");

    resultado = [0, 0, 0]; % [raiz, iteraciones, error]
    Pn = (a + b) / 2;

    if F(a) * F(b) > 0
        fprintf("Los valores a y b ingresados no son validos para el metodo de biseccion con la funcion ingresada\n");
        return
    end

    i = 1;
    while abs(F(Pn)) > tol && i <= n

        Pn = (a + b) / 2;

        if F(a) * F(Pn) < 0
        b = Pn; % si es menor a 0, el nuevo bn va a ser el Pn, se usa el intervalo [a, Pn]
    else
        a = Pn; % si es mayor a 0, el nuevo an va a ser el Pn, se usa el intervalo [Pn, b]
    end

        

        fprintf("Iteracion:" + i + ...
                " | an = " + num2str(a, '%.15f') + ...
                " | bn = " + num2str(b, '%.15f') + ...
                " | Pn = " + num2str(Pn, '%.15f') + ...
                " | F(Pn) = " + num2str(F(Pn), '%.15f') + ...
                " | F(an) = " + num2str(F(a), '%.15f') + ...
                " | F(bn) = " + num2str(F(b), '%.15f') + "\n");

        if abs(F(Pn)) <= tol
            fprintf("\n");
            fprintf("Se necesitan " + i + ...
                    " iteraciones en el metodo de Biseccion para aproximar a un error absoluto de " + ...
                    num2str(tol, '%.15f') + ...
                    " Con un P" + i + " = " + num2str(Pn, '%.15f') + ...
                    " y un error absoluto = " + num2str(F(Pn), '%.15f') + "\n");
            resultado = [Pn, i, abs(F(Pn))];
            return
        end

        i = i + 1;
    end

    fprintf("\n");
    fprintf("No se alcanzo el error absoluto deseado de T = " + num2str(tol, '%.15f') + ...
            " en el metodo de Biseccion con las n iteraciones ingresadas, el error absoluto alcanzado fue: " + ...
            num2str(F(Pn), '%.15f') + "\n");
    resultado = [Pn, i-1, abs(F(Pn))];
end

function resultado = newton(x0, F, DF, tol, n)
 
    fprintf("\n");
    fprintf("==========================Newton==================================\n\n");

    
    resultado = [0, 0, 0]; % [raiz, iteraciones, error]
    
    for i = 1:n
        f_val = F(x0);
        df_val = DF(x0);
        
        if df_val == 0
            fprintf('\n¡Derivada cero encontrada! El método falló.\n');
            return;
        end
        
        x1 = x0 - f_val/df_val;
        error = abs(x1 - x0);
        
         fprintf("Iteracion:" + i + ...
                " | Pn = " + num2str(x0, '%.15f') + ...
                " | F(Pn) = " + num2str(f_val, '%.15f') + ...
                " | F'(Pn) = " + num2str(df_val, '%.15f') + ...
                " | Error = " + num2str(error, '%.15f') + "\n");
        
         if error < tol
            fprintf("\nSe necesitan " + i + ...
                    " iteraciones en el metodo de Newton para aproximar la raiz con un error absoluto de " + ...
                    num2str(error, '%.15f') + "\n");
            resultado = [x1, i, error];
            return;
        end

        x0 = x1;
    end

    fprintf("\nNo se alcanzo la convergencia en el metodo de Newton. Error final: " + num2str(error, '%.15f') + "\n");
    resultado = [x0, n, error];
end

function resultado = secante(x0, x1, F, tol, n)
     fprintf("\n");
    fprintf("==========================Secante==================================\n\n");
    
    resultado = [0, 0, 0]; % [raiz, iteraciones, error]
    f0 = F(x0);
    f1 = F(x1);
    
    for i = 1:n
        if (f1 - f0) == 0
            fprintf('\n¡División por cero! El método falló.\n');
            return;
        end
        
        x2 = x1 - (f1*(x1 - x0))/(f1 - f0);
        error = abs(x2 - x1);
        
       fprintf("Iteracion:" + i + ...
                " | x0 = " + num2str(x0, '%.15f') + ...
                " | x1 = " + num2str(x1, '%.15f') + ...
                " | F(x1) = " + num2str(f1, '%.15f') + ...
                " | Error = " + num2str(error, '%.15f') + "\n");
        
        if error < tol
            fprintf("\nSe necesitan " + i + ...
                    " iteraciones en el metodo de la Secante para aproximar la raiz con un error absoluto de " + ...
                    num2str(error, '%.15f') + "\n");
            resultado = [x2, i, error];
            return;
        end
        
        x0 = x1; f0 = f1;
        x1 = x2; f1 = F(x1);
    end
    
    resultado = [x1, n, error];
    fprintf("\nNo se alcanzo la convergencia en el metodo de la Secante. Error final: " + num2str(error, '%.15f') + "\n");
end

function resultado = punto_fijo(F, G, x0, tol, n)
    % Método del punto fijo para encontrar raíces
    fprintf("\n");
    fprintf("==========================Punto Fijo==================================\n");
    fprintf("\n");

    resultado = [0, 0, 0]; % [raiz, iteraciones, error]
    contador = 1;
    Pn = G(x0);
    error = abs(F(Pn));

    while error > tol && contador <= n

        x0 = Pn;               % Actualizar el valor anterior

        Pn = G(x0);            % Calcular nuevo valor
        
        error = abs(F(Pn));    % Calcular error

        fprintf("Iteracion:" + contador + ...
                " | Pn = " + num2str(Pn, '%.15f') + ...
                " | error = " + num2str(error, '%.15f') + "\n");

        contador = contador + 1;
    end

    if error <= tol
        fprintf("\n");
        contador = contador - 1;
        fprintf("Se necesitan " + contador + ...
                " iteraciones en el metodo de punto fijo para aproximar a un error absoluto de " + ...
                num2str(tol, '%.6f') + ...
                " Con un Pn" + contador + " = " + num2str(Pn, '%.15f') + ...
                " y un error absoluto = " + num2str(error, '%.15f') + "\n");
    else
        fprintf("\n");
        fprintf("No se alcanzo el error absoluto deseado de T = " + num2str(tol, '%.15f') + ...
                " en el metodo de punto fijo con las n iteraciones ingresadas, el Pn alcanzado fue: " + ...
                num2str(Pn, '%.15f') + " y un error absoluto = " + num2str(error, '%.15f') + "\n");
    end

    resultado = [Pn, contador - 1, error];
end
function validar_relacion_f_g(f, g, x_0, a, b)
   

    fprintf("\n================= VALIDACIÓN  que la función g(x) se obtuvo del f(x) original =================\n");

    % Segun la materia f(x)=x-g(x),  x-g(x)=0 y x=g(x)
    %Entonces se evalua g(x_0) y se hace una resta de x_0 - g(x)  y si el
    %resultado da entre 0 y 1 quiere decir que x-g(x)=0  esta muy cerca de
    %cumplirse por lo que g(x) puede ser una funcion aproximada valida de
    %f(x) y ademas que si f(x_0)-rest==0 cumpliria con f(x)=x-g(x)
    gx=g(x_0); 
    rest= x_0 - gx;


     if rest > 0 && rest  <1 || f(x_0)-rest==0
        fprintf("g(x) se obtuvo de f(x) (f(g(x)) = 0)\n");
    else
        fprintf("Es probable que g(x) que no se obtuvo directamente de f(x)\n");
    end

%Para verificar existencia
%se hace un vector  que contiene 1000 numeros entre el intervalo de a, b
   vectorXs = linspace(a, b, 1000);
 %se hace un vector con la imagenes de g(x) con cada uno de los numeros de vectorXs
   gEvaluadaEnVectorXs = g(vectorXs);

% Recorrer el vector y evaluar que las imagenes esten dentro del intervalo
% de a, b y se usa una variable booleana para validar si exixte o no

for i = 1:length(gEvaluadaEnVectorXs)
    if gEvaluadaEnVectorXs(i) < a || gEvaluadaEnVectorXs(i) > b
        existePuntoFijo = false;
        break;
    end
end
%depende de lo que diga la variable se avisa si existe un punto fijo o no
existePuntoFijo = true;
if existePuntoFijo
    disp('Existe punto fijo');
else
    disp('No se cumple la existencia');
end

%Para evaluar la unicidad |g´(x)|<= 1

% Declarar 'x' como una variable simbólica para poder derivar funciones que dependan de x
 syms x
 %se saca la derivada de g(x)
g_derivada = matlabFunction(diff(g, x));
% Evaluar la derivada absoluta |g'(x)| para cada uno de los numeros en el vectorXs 
gEvaluadaDerivadaAbs = abs(g_derivada(vectorXs));
%%valida si el punto fijo es unico 
esUnico = true;
for i = 1:length(gEvaluadaDerivadaAbs)
    if gEvaluadaDerivadaAbs(i) > 1 % si alguna es mayor que 1 entonces ya no se cumple la unicidad
        esUnico = false;
        break;
    end
end

if esUnico
    disp('Tiene un punto fijo único');
else
    disp('No se cumple la unicidad');
end
   
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARTE 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function derivacion_numerica()
    % Calcula derivadas numéricas con fórmulas de 3 y 5 puntos
    % Completa nodos faltantes con Lagrange si es necesario
    

    fprintf('\n');
    fprintf('===============================================================================\n');
    fprintf('|                                                                             |\n');
    fprintf('|                         DERIVACIÓN NUMÉRICA                                 |\n');
    fprintf('|                                                                             |\n');
    fprintf('| Este programa calcula derivadas numéricas usando fórmulas de 3 y 5 puntos.  |\n');
    fprintf('| Puede ingresar nodos equidistantes o no equidistantes.                      |\n');
    fprintf('|                                                                             |\n');
    fprintf('| Requisitos:                                                                 |\n');
    fprintf('|   - Mínimo 3 nodos                                                          |\n');
    fprintf('|   - Nodos ordenados (creciente o decreciente)                               |\n');
    fprintf('|   - Si no son equidistantes, se completarán con interpolación de Lagrange   |\n');
    fprintf('|                                                                             |\n');
    fprintf('| Resultados:                                                                 |\n');
    fprintf('|   - Tabla con derivadas aproximadas                                         |\n');
    fprintf('|   - Comparación con derivada exacta (si se ingresa la función)              |\n');
    fprintf('|                                                                             |\n');
    fprintf('|                            ¡Comencemos!                                     |\n');
    fprintf('|                                                                             |\n');
    fprintf('===============================================================================\n\n');

    % 1. Ingresar cantidad de nodos
    cantidad = 0;
    while cantidad < 3
        try
            cantidad = input('Ingrese la cantidad de nodos (mínimo 3): ');
            if cantidad < 3
                fprintf('¡Error! Se necesitan al menos 3 nodos.\n');
            end
        catch
            fprintf('¡Entrada inválida! Debe ingresar un número.\n');
            cantidad = 0;
        end
    end
    
    % 2. Ingresar valores de x
    fprintf('\nIngrese los valores de x (ordenados):\n');
    nodos_x = zeros(cantidad, 1);
    for i = 1:cantidad
        while true
            try
                nodos_x(i) = input(sprintf('  x%d: ', i));
                break;
            catch
                fprintf('¡Valor inválido! Intente nuevamente.\n');
            end
        end
    end
    
    % Verificar orden
    if ~issorted(nodos_x) && ~issorted(nodos_x, 'descend')
        error('Los nodos deben estar ordenados de forma creciente o decreciente');
    end
    
    % Determinar dirección
    es_ascendente = nodos_x(2) > nodos_x(1);
    
    % 3. Ingresar valores de f(x) o la función
    fprintf('\nSeleccione cómo ingresar los valores de f(x):\n');
    fprintf('1. Ingresar valores de f(x) directamente\n');
    fprintf('2. Ingresar una función f(x) y calcular los valores\n');
    fprintf('Elija (1/2): ');
    opcion = input('');
    if opcion == 1
        fprintf('\nIngrese los valores de f(x):\n');
        nodos_y = zeros(cantidad, 1);
        for i = 1:cantidad
            nodos_y(i) = input(sprintf('  f(x%d) = ', i));
        end
        nodos = [nodos_x, nodos_y];
        f = [];
    else
        fprintf('\nIngrese la función f(x) en términos de x:\n');
        f_str = input('\nIngrese la función f(x) (ej. "x^2 + sin(x)"): ', 's');
        f = str2sym(f_str);
        nodos_y = double(subs(f, 'x', nodos_x));
        nodos = [nodos_x, nodos_y];
    end
    
    % 4. Comprobar equidistancia y completar si es necesario
    h = nodos_x(2) - nodos_x(1);
    if any(abs(diff(nodos_x) - abs(h)) > 1e-8)
        fprintf('\n¡Los nodos no son equidistantes! Completando con Lagrange...\n');
        nodos = completar_nodos(nodos, es_ascendente);
        h = nodos(2,1) - nodos(1,1);
    end
    
    % 5. Calcular derivadas
    [derivadas, metodos, errores] = calcular_derivadas(nodos, h);
    
    % 6. Mostrar resultados
    mostrar_resultados(nodos, derivadas, metodos, errores, f, h);

    fprintf('\nProceso completado exitosamente.\n');
end

function nodos_completos = completar_nodos(nodos, es_ascendente)
    % Completa nodos faltantes usando Lagrange
    x = nodos(:,1);
    y = nodos(:,2);
    
    % Determinar h más frecuente
    h = mode(abs(diff(x)));
    
    % Crear secuencia completa de nodos
    if es_ascendente
        x_completo = (min(x):h:max(x))';
    else
        x_completo = (max(x):-h:min(x))';
    end
    
    % Interpolar valores faltantes
    y_completo = zeros(size(x_completo));
    for i = 1:length(x_completo)
        idx = find(abs(x - x_completo(i)) < 1e-8, 1);
        if ~isempty(idx)
            y_completo(i) = y(idx);
        else
            y_completo(i) = lagrange(x, y, x_completo(i));
        end
    end
    
    nodos_completos = [x_completo, y_completo];
end

function y_interp = lagrange(x, y, x0)
    % Interpolación de Lagrange para un punto
    n = length(x);
    y_interp = 0;
    
    for i = 1:n
        term = y(i);
        for j = 1:n
            if j ~= i
                term = term * (x0 - x(j)) / (x(i) - x(j));
            end
        end
        y_interp = y_interp + term;
    end
end

function [derivadas, metodos, errores] = calcular_derivadas(nodos, h)
    % Calcula derivadas usando fórmulas de 3 y 5 puntos
    x = nodos(:,1);
    y = nodos(:,2);
    n = length(x);
    
    derivadas = zeros(n,1);
    metodos = cell(n,1);
    errores = cell(n,1);
    
    for i = 1:n
        % Fórmulas de 5 puntos (cuando sea posible)
        if i >= 3 && i <= n-2
            derivadas(i) = (y(i-2) - 8*y(i-1) + 8*y(i+1) - y(i+2)) / (12*h);
            metodos{i} = '5 puntos medio';
            errores{i} = '(h⁴/30)f⁽⁵⁾(ξ)';
            
        % Fórmulas para bordes
        elseif i == 1
            if n >= 5
                derivadas(i) = (-25*y(i) + 48*y(i+1) - 36*y(i+2) + 16*y(i+3) - 3*y(i+4)) / (12*h);
                metodos{i} = '5 puntos progresivo';
                errores{i} = '(h⁴/5)f⁽⁵⁾(ξ)';
            else
                derivadas(i) = (-3*y(i) + 4*y(i+1) - y(i+2)) / (2*h);
                metodos{i} = '3 puntos progresivo';
                errores{i} = '(h²/3)f''''(ξ)';
            end
        elseif i == n
            if n >= 5
                derivadas(i) = (3*y(i-4) - 16*y(i-3) + 36*y(i-2) - 48*y(i-1) + 25*y(i)) / (12*h);
                metodos{i} = '5 puntos regresivo';
                errores{i} = '(h⁴/5)f⁽⁵⁾(ξ)';
            else
                derivadas(i) = (y(i-2) - 4*y(i-1) + 3*y(i)) / (2*h);
                metodos{i} = '3 puntos regresivo';
                errores{i} = '(h²/3)f''''(ξ)';
            end
        else
            % Puntos cercanos a bordes - fórmula de 3 puntos centrada
            derivadas(i) = (y(i+1) - y(i-1)) / (2*h);
            metodos{i} = '3 puntos medio';
            errores{i} = '(h²/6)f''''(ξ)';
        end
    end
end

function mostrar_resultados(nodos, derivadas, metodos, errores, f, h)
    % Muestra los resultados en una tabla formateada
    
    % Encabezado principal
    fprintf('\n');
    fprintf('═══════════════════════════════════════════════════════════════════════\n');
    fprintf('                       RESULTADOS DE DERIVACIÓN                       \n');
    fprintf('═══════════════════════════════════════════════════════════════════════\n');
    fprintf(' Salto h = %.6f\n\n', h);
    
    % Tabla de resultados principales
    fprintf('┌──────────┬──────────────┬────────────────┬─────────────────────┬─────────────────┐\n');
    fprintf('│    x     │    f(x)      │  f''(x) aprox   │       Método        │ Error teórico   │\n');
    fprintf('├──────────┼──────────────┼────────────────┼─────────────────────┼─────────────────┤\n');
    
    for i = 1:size(nodos,1)
        fprintf('│ %-8.4f │ %-12.6f │ %-14.6f │ %-19s │ %-15s │\n', ...
                nodos(i,1), nodos(i,2), derivadas(i), metodos{i}, errores{i});
    end
    fprintf('└──────────┴──────────────┴────────────────┴─────────────────────┴─────────────────┘\n');
    
    % Sección de comparación con derivada exacta
    if ~isempty(f)
        df = diff(f);
        df_exacta = matlabFunction(df);
        exactas = df_exacta(nodos(:,1));
        
        fprintf('\n');
        fprintf('───────────────────────────────────────────────────────────────────────\n');
        fprintf('                COMPARACIÓN CON DERIVADA EXACTA                       \n');
        fprintf('───────────────────────────────────────────────────────────────────────\n');
        fprintf('┌──────────┬──────────────────┬──────────────────┬────────────────────┐\n');
        fprintf('│    x     │ f''(x) exacta     │ f''(x) aprox      │ Error absoluto     │\n');
        fprintf('├──────────┼──────────────────┼──────────────────┼────────────────────┤\n');
        
        for i = 1:size(nodos,1)
            error_abs = abs(exactas(i) - derivadas(i));
            fprintf('│ %-8.4f │ %-16.6f │ %-16.6f │ %-18.6f │\n', ...
                    nodos(i,1), exactas(i), derivadas(i), error_abs);
        end
        fprintf('└──────────┴──────────────────┴──────────────────┴────────────────────┘\n');
    end
    
    % Leyenda
    fprintf('\n');
    fprintf('───────────────────────────────────────────────────────────────────────\n');
    fprintf('                                LEYENDA                               \n');
    fprintf('───────────────────────────────────────────────────────────────────────\n');
    fprintf(' • ξ: Punto que representa el error entre la aproximación y el valor exacto\n');
    fprintf(' • h: Tamaño del salto entre nodos (%.6f)\n', h);
    fprintf(' • Fórmulas usadas:\n');
    fprintf('   - 3 puntos: Error O(h²)\n');
    fprintf('   - 5 puntos: Error O(h⁴)\n');
    fprintf('═══════════════════════════════════════════════════════════════════════\n');
    fprintf('\n');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARTE 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function interpolacion_lagrange()
% Esta función ejecuta todo el proceso de interpolación de Lagrange
% con validación de nodos y cálculo del error máximo

% Pedir cantidad de nodos
fprintf('========================== Interpolación de Lagrange ==========================\n');
fprintf('Ingrese la cantidad de nodos (mínimo 2):\n');
cantidad = input("Ingrese la cantidad de nodos (mínimo 2): ");

if cantidad >= 2
    fprintf("\nIngrese los valores de x e y para cada nodo:\n");
    
    %Inicializar la matriz que guardará los valores de "x" y "y"
    nodos = zeros(cantidad, 2);
    
    % Ingresar valores x_i y y_i manualmente
    for i = 1:cantidad % Este for recorre la matriz guardando los valores de "X" y "Y" que ingrese el usuario
        fprintf("Nodo %d:\n", i);
        fprintf("Ingrese el valor de x\n");
        nodos(i, 1) = input("  x: ");  % Guardar xi
        fprintf("Ingrese el valor de y\n");
        nodos(i, 2) = input("  y: ");  % Guardar yi
    end

    % Pedir la función f(x) para validación
    fprintf("\nIngrese la función f(x): ");
    funcion_str = input("", 's');%recibe la función como texto
    f = str2sym(funcion_str);  % Convertir a expresión simbólica
    %F = matlabFunction(funcion);%convierte la función en función de matlab

    % Validar que los y_i coincidan con f(x_i)
    syms x;
    errores = false; %variable para llevar el control del error
    for i = 1:cantidad
        %el metodo subs se encarga de evaluar las imágenes con cada "X" de
        %de la matriz de nodos
        fy = double(subs(f, x, nodos(i, 1)));  % Calcular f(x_i)
        %el metodo abs calcula el valor absoluto
        if abs(fy - nodos(i, 2)) > 0.000001  %Para saber si la diferencia entre cada imagen tiene cierta cota de error
            fprintf("Error: El valor y_%d = %.6f no coincide con f(%.6f) = %.6f\n", ...
                    i-1, nodos(i, 2), nodos(i, 1), fy);
            errores = true;
        end
    end
    
    if errores %lanza el error en caso de que "y" y la imagen no sean iguales
        error("Los valores y ingresados no coinciden con la función f(x). Verifique los datos.");
    else %todos los "y" ingresados y las imágenes calculadas coinciden
        fprintf("Todos los valores y coinciden con f(x).\n");
    end

    % Mostrar nodos ingresados
    fprintf("\nNodos ingresados (x_i, y_i):\n");
    disp(nodos);

    % Calcular polinomios base de Lagrange L_i(x)
    L = sym(zeros(1, cantidad)); %Este vector almacena los polinomios base de langrange
    
    fprintf("\nPolinomios base de Lagrange:\n");
    for i = 1:cantidad
        xi = nodos(i, 1);  % x_i actual
        L_i = sym(1);      % Inicializar L_i(x) = 1
        fprintf("L_%d(x) = ", i-1);
        
        % Numerador: Producto (x - x_j) para j ≠ i
        num = sym(1);
        for j = 1:cantidad
            if j ~= i
                num = num * (x - nodos(j, 1));
            end
        end
        
        % Denominador: Producto (x_i - x_j) para j ≠ i
        den = sym(1);
        for j = 1:cantidad
            if j ~= i
                den = den * (xi - nodos(j, 1));
            end
        end
        
        L_i = num / den;  % L_i(x) = numerador / denominador
        L(i) = L_i;       % Almacenar L_i(x)
        disp(L_i);        % Mostrar L_i(x)
    end

    % Construir polinomio de Lagrange
    P = sym(0);
    for i = 1:cantidad
        P = P + nodos(i, 2) * L(i);
    end
    
    fprintf("\nPolinomio de Lagrange P(x):\n");
    disp(P);

    %%calcular el error máximo
    fprintf('\n--- Cálculo del Error Máximo ---\n');   
        % 1. Primero calculamos la derivada de orden n
        derivada = f; % Asignamos la función f a una variable para derivar
        for k = 1:cantidad
            derivada = diff(derivada, x); %diff es una función de matlab que nos permite calcular derivadas
            if derivada == sym(0) %maneja la excepción en caso de que la derivada se vuelva 0
                fprintf('\n#### ERROR -- La derivada se convirtió en 0 en la iteración #%d #####\n', k);
                break
            end 
        end
        
        % 2. Calculamos el término h(x) = derivada / n!
        h = derivada / factorial(cantidad);
        
        % 3. Calculamos el producto de (x-nodo(i))
        g = 1;
        for k = 1:cantidad
            g = g * (x - nodos(k,1));
        end
        
        % 4. Construimos la función de error completa
        formula_error = h * g;
        
        % 5. Encontramos puntos críticos derivando la función
        error_derivada = diff(formula_error, x); %obtenemos una derivada extra
        %puntos críticos guardará con ayuda del solve las soluciones donde
        %la derivada que se calculó anteriormente se vuelve 0, guardando
        %así los puntos críticos de esa derivada
        puntos_criticos = solve(error_derivada == 0, x);
        
        % 6. Filtramos puntos válidos en el intervalo
        x_min = min(nodos(:,1)); %min encuentra el valor más pequeño dentro la matrix de nodos
        x_max = max(nodos(:,1)); %max encuentra el valor más grande dentro la matrix de nodos
        extremos_intervalo = [x_min, x_max]; % Se guardan los extremos del intervalo
        
        puntos_criticos_numericos = double(puntos_criticos); %convertimos los puntos críticos en valores numéricos

        %con este for vamos a recorrer el vector de puntos críticos para
        %ver cuáles están dentro de del intervalo y cuáles no
        for i = 1:length(puntos_criticos_numericos)
            pc_val = puntos_criticos_numericos(i);  % Tomamos el valor actual
        
            % Verificamos si está dentro del intervalo
            if pc_val >= x_min && pc_val <= x_max
                extremos_intervalo = [extremos_intervalo, pc_val];  % agregamos la matriz el nuevo valor dentro del intervalo
                fprintf('Punto crítico válido encontrado: %.4f\n', pc_val);
            end
        end
        
        % 7. Evaluamos en los puntos seleccionados
        valores_error = []; % Inicializamos el vector de valores
        for i = 1:length(extremos_intervalo)
            % Evaluamos la función de error en ese punto y tomamos el valor absoluto
            valor = abs(double(subs(formula_error, x, extremos_intervalo(i))));  % subs evalúa la función reemplazando x por el valor numérico en el vector de extremos
            % Mostramos el resultado
            fprintf('En x = %.4f, el error absoluto es aproximadamente %.6f\n', extremos_intervalo(i), valor);
            % Guardamos el valor calculado en el vector
            valores_error = [valores_error, valor];
        end

        % 8. Determinamos el error máximo
        error_max = max(valores_error); %asignamoos a la variable max_error el mayor valor dentro del vector de errores
        x_max_error = extremos_intervalo(valores_error == error_max); %busca en qué valor "x" se encontró el mayor error
        fprintf('\n7. Error máximo encontrado:\n');
        fprintf("→ El peor error fue de %.6f y pasó cuando x era aproximadamente %.4f\n", error_max, x_max_error(1));
        fprintf('\n \n');
else
    fprintf("ERROR: La cantidad de nodos debe ser ≥ 2.\n");
end
end
