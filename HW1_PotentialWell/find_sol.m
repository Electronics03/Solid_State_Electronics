clear;
close all;
clc;

%% 1. 문제를 풀기 위한 파라미터 설정

% 각종 Constants
hbar = 1.0545718e-34; % [J*s]
m0 = 9.11e-31; % [kg]
eV = 1.60217662e-19; % 1 eV = 1.602e-19 J

% Well width (2a 를 width으로 사용)
a = 2.5e-9; % 50/2 [A] = 2.5e-9 [m]

% 문제의 Parameter을 입력받는다
V0 = input("Energy Differance: ");
V0 = V0 * eV; % Energy Differance [J]

m = input("Effective Mass: ");
m = m * m0; % Effective Mass [kg]

% 임계 상수 Kc: k0^2 + K^2 = 2mV0/hbar^2 = Kc^2
Kc = sqrt(2 * m * V0) / hbar; % [1/m]

%% 2. K0 범위 설정
% K0이 근을 가질 수 있는 범위는 (0 < K0 < Kc)
K0 = linspace(0, Kc, 10000); % 10000 단계로 세분화하였음

% (1) k0^2 + K^2 = Kc^2 를 K로 정리
K = sqrt(Kc ^ 2 - K0 .^ 2); % K0를 기준으로 근을 찾기 위함
% (2) Even-Equation: K = K0 tan(K0 a)
even_func = K0 .* tan(K0 * a);
% (3) Odd-Equation: K = - K0 cot(K0 a)
odd_func =- K0 .* (cos(K0 * a) ./ sin(K0 * a)); % cot(x) = cos(x)/sin(x)

%% 3. 발산점 데이터 제거
% NaN 처리를 통해 발산점의 데이터를 제거한다.
% K0 * a 값이 π/2, 3π/2, 5π/2, ... 인 지점
K0a = K0 * a;
divPoint = (1:ceil(max(K0a) / pi * 2)) * pi / 2; % [π/2, π, 3π/2, ...]

% 제거할 범위 (폭)
tolx = 1e-3; % 0.0001

% [π/2, π, 3π/2, ...]근방을 NaN 처리한다.
% 해당 데이터를 제거하면서 근이 존재하지 않도록 해준다.
for i = 1:length(divPoint)
    tmp_angle = divPoint(i);
    index = abs(K0a - tmp_angle) < tolx;
    even_func(index) = NaN;
    odd_func(index) = NaN;
end

%% 4. 그래프를 그린다.
figure;
subplot(4, 5, [1, 18]);
hold on;
plot(K0, K, 'g-', 'LineWidth', 1, 'DisplayName', 'K = sqrt(K_c^2 - K_0^2)');
plot(K0, even_func, 'r-', 'LineWidth', 1, 'DisplayName', 'K_0tan(K_0a) (Even)');
plot(K0, odd_func, 'b-', 'LineWidth', 1, 'DisplayName', '-K_0cot(K_0a) (Odd)');

xlabel('K_0 (1/m)');
ylabel('K (1/m)');
title('Graphical solution');

legend('Location', 'best');

grid on;
axis([0 Kc 0 1.5 * max(K)]);
axis equal;

%% 5. Numerical Solution을 찾는다.
% Even_equation: f_even(K0) = sqrt(Kc^2 - K0^2) - K0 tan(K0 a) = 0
% Odd_equation: f_odd(K0) = sqrt(Kc^2 - K0^2) + K0 cot(K0 a) = 0
f_even = @(k) sqrt(Kc ^ 2 - k .^ 2) - k .* tan(k * a);
f_odd = @(k) sqrt(Kc ^ 2 - k .^ 2) + k .* (cos(k * a) ./ sin(k * a));

% 발산점에서는 근을 가지지 않으므로 이를 제거한다
% 발산점 목록 생성
n_max = ceil(Kc * 2 * a / pi); % π/2a 의 최대 정수배까지
singular_points = (pi / (2 * a)) * (1:n_max); % 발산점 위치들

even_roots = [];
odd_roots = [];

for i = 1:length(K0) - 1
    K0_left = K0(i);
    K0_right = K0(i + 1);
    % 근을 찾는 구간

    % 현재 구간이 발산점을 포함하는지 검사
    if (any(abs(singular_points - K0_left) < abs(K0_right - K0_left)) || any(abs(singular_points - K0_right) < abs(K0_right - K0_left)))
        continue; % 발산점 포함 구간이면 넘어간다
    end

    % Even
    y1 = f_even(K0_left);
    y2 = f_even(K0_right);

    if (y1 * y2 < 0) && ~isnan(y1) && ~isnan(y2)
        root_even = fzero(f_even, [K0_left, K0_right]);
        even_roots = [even_roots, root_even]; % 근 리스트에 추가한다
    end

    % Odd
    y1o = f_odd(K0_left);
    y2o = f_odd(K0_right);

    if (y1o * y2o < 0) && ~isnan(y1o) && ~isnan(y2o)
        root_odd = fzero(f_odd, [K0_left, K0_right]);
        odd_roots = [odd_roots, root_odd]; % 근 리스트에 추가한다
    end

end

E_even_J = (hbar ^ 2 ./ (2 * m)) .* (even_roots .^ 2); % [J]
E_odd_J = (hbar ^ 2 ./ (2 * m)) .* (odd_roots .^ 2); % [J]
E_even_eV = E_even_J / eV; % [J -> eV]
E_odd_eV = E_odd_J / eV; % [J -> eV]

fprintf('\n');
fprintf('Even state K0 (1/m) Solution: %E\n', even_roots);
fprintf('Even state Energy (eV): %f\n', E_even_eV);

fprintf('\nOdd state K0 (1/m) Solution: %E\n', odd_roots);
fprintf('Odd state Energy (eV): %f\n', E_odd_eV);

% 근을 그래프에 추가한다
hold on;
% Even
for i = 1:length(even_roots)
    K0_val = even_roots(i);
    K_val = sqrt(Kc ^ 2 - K0_val ^ 2);
    plot(K0_val, K_val, 'ro', 'MarkerSize', 2, 'LineWidth', 2, 'DisplayName', 'Even Root');
end

% Odd
for i = 1:length(odd_roots)
    K0_val = odd_roots(i);
    K_val = sqrt(Kc ^ 2 - K0_val ^ 2);
    plot(K0_val, K_val, 'bo', 'MarkerSize', 2, 'LineWidth', 2, 'DisplayName', 'Odd Root');
end

%% 6. 파동 함수 그래프 출력
x = linspace(-5 * a, 5 * a, 10000); % 여유있게 범위를 정함

subplot(4, 5, [4, 10]);
hold on;

% Even
for i = 1:length(even_roots) % 모든 근의 그래프를 출력한다
    K0_val = even_roots(i);
    K = sqrt(Kc ^ 2 - K0_val ^ 2);

    psi = zeros(size(x));

    for j = 1:length(x)

        if abs(x(j)) <= a % (x<-a), (-a<x<z), (a<x)로 세 부분으로 나눠진다
            psi(j) = cos(K0_val * x(j));
        else
            psi(j) = cos(K0_val * a) * exp(-K * (abs(x(j)) - a));
        end

    end

    psi = psi / max(abs(psi)); % 최댓값을 1로 보기편하게 정규화함
    % 원래는 적분 후 정규화 해야하지만 어떻게 하는지 찾지 못하여 1로 하는 방법을 사용하였음
    plot(x * 1e9, psi, 'r-', 'LineWidth', 2, 'DisplayName', sprintf('Even_%d', i));
end

% Odd
for i = 1:length(odd_roots) % 모든 근의 그래프를 출력한다
    K0_val = odd_roots(i);
    K = sqrt(Kc ^ 2 - K0_val ^ 2);

    psi = zeros(size(x));

    for j = 1:length(x)

        if abs(x(j)) <= a % (x<-a), (-a<x<z), (a<x)로 세 부분으로 나눠진다
            psi(j) = sin(K0_val * x(j));
        else
            psi(j) = sign(x(j)) * sin(K0_val * a) * exp(-K * (abs(x(j)) - a));
        end

    end

    psi = psi / max(abs(psi)); % 최댓값을 1로 보기편하게 정규화함
    % 원래는 적분 후 정규화 해야하지만 어떻게 하는지 찾지 못하여 1로 하는 방법을 사용하였음
    plot(x * 1e9, psi, 'b-', 'LineWidth', 2, 'DisplayName', sprintf('Odd_%d', i));
end

xlabel('x (nm)');
ylabel('\psi(x)');
title('Wavefunction');
legend('Location', 'best');
grid on;

%% 7. 파동 함수 + 에너지 + 전위 V(x) 함께 플로팅
x = linspace(-5 * a, 5 * a, 10000); % 여유있게 범위를 정함

subplot(4, 5, [14, 20]);
hold on;

% Even
for i = 1:length(even_roots)
    K0_val = even_roots(i);
    E_val = E_even_eV(i); % 에너지 레벨 [eV]
    K = sqrt(Kc ^ 2 - K0_val ^ 2);

    psi = zeros(size(x));

    for j = 1:length(x)

        if abs(x(j)) <= a
            psi(j) = cos(K0_val * x(j));
        else
            psi(j) = cos(K0_val * a) * exp(-K * (abs(x(j)) - a));
        end

    end

    psi = psi / max(abs(psi)); % 최댓값을 1로 보기편하게 정규화함
    % 원래는 적분 후 정규화 해야하지만 어떻게 하는지 찾지 못하여 1로 하는 방법을 사용하였음
    psi = psi * 0.05 + E_val; % 에너지 위치에 맞춰 위로 이동

    plot(x * 1e9, psi, 'r-.', 'LineWidth', 2, 'DisplayName', sprintf('Even_%d', i));
end

% Odd
for i = 1:length(odd_roots)
    K0_val = odd_roots(i);
    E_val = E_odd_eV(i); % 에너지 레벨 [eV]
    K = sqrt(Kc ^ 2 - K0_val ^ 2);

    psi = zeros(size(x));

    for j = 1:length(x)

        if abs(x(j)) <= a
            psi(j) = sin(K0_val * x(j));
        else
            psi(j) = sign(x(j)) * sin(K0_val * a) * exp(-K * (abs(x(j)) - a));
        end

    end

    psi = psi / max(abs(psi)); % 최댓값을 1로 보기편하게 정규화함
    % 원래는 적분 후 정규화 해야하지만 어떻게 하는지 찾지 못하여 1로 하는 방법을 사용하였음
    psi = psi * 0.05 + E_val; % 에너지 레벨맡큼 위로 이동시킨다
    plot(x * 1e9, psi, 'b-.', 'LineWidth', 2, 'DisplayName', sprintf('Odd_%d', i));
end

% Energy Level 표시
for i = 1:length(E_even_eV)
    yline(E_even_eV(i), 'r:', 'LineWidth', 1.5, 'DisplayName', sprintf('E_{even %d}', i));
end

for i = 1:length(E_odd_eV)
    yline(E_odd_eV(i), 'b:', 'LineWidth', 1.5, 'DisplayName', sprintf('E_{odd %d}', i));
end

xlabel('x (nm)');
ylabel('Energy and \psi(x) [eV]');
title('Energy Level and Wavefunction');
grid on;

% 전위 V(x)
V_x = zeros(size(x)); % 0으로 초기화한다

for j = 1:length(x)

    if abs(x(j)) > a % (-a<x<a) 가 아닌 부분은 V0로 전위를 변경
        V_x(j) = V0 / eV;
    end

end

% 전위를 표시한다
plot(x * 1e9, V_x, 'k-', 'LineWidth', 2, 'DisplayName', 'V(x)');

legend('Location', 'eastoutside');
ylim([-0.05, V0 / eV * 1.2]);
