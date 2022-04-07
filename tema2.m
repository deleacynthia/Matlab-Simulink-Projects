% Delea Cynthia Andreea 332AB Tema 2: Model_1

clc, clear, close all

m = 5.1;
g = 10;
L = 1.56;
zeta = 7.64;
k = 0.25;
J = 2.77;
I = 1.89;
M = 2.82;
alfa = 3.7;
beta = 4.8;
gama = 2.8;

mdl_pin = 'tema2_mdl_pin';


%% Cerinta 2

% liniarizare 
u0 = 1;
[xstar,ustar,ystar,~] = trim(mdl_pin,[],u0,[],[],1,[])
abs(ustar - u0)
r = 2 * ystar;

%% Cerinta 3

S = linmod(mdl_pin, xstar, ustar);

S.StateName

sys = ss(S.a, S.b, S.c, S.d);

A_lin = S.a;
B_lin = S.b;
C_lin = S.c;
D_lin = S.d;

%% Cerinta 4 

%stabilitatea sistemului
%daca polii sunt in semiplanul complex stg => mdl e stabil

eig(sys)
vp = eig(A_lin);

%% Cerinta 5

mdl = 'tema2_mdl';
load_system(mdl);
t = linspace(0, 400, 1000)';
set_param(mdl, 'StopTime', num2str(t(end)));
out = sim(mdl);
y_lin = out.y_lin1;

%% Cerinta 6 
y_nl = out.y_nl1;
err = norm(y_nl.Data - y_lin.Data,inf);

%% Cerinta7

mdl1 = 'tema2_mdl1';
load_system(mdl1);
set_param(mdl1, 'StopTime', num2str(t(end)));
out1 = sim('tema2_mdl1');
y_1 = out1.y1;

%% Cerinta 8

s = tf('s');
Te = 0.06;
C = (s + 0.1)/s;

% Am ales metoda de discretizare Tustin deoarece prin Tustin tot 
%semiplanul complex stang este mapat in interiourul discului unitate 
% => Tustin garanteaza stabilitatea
% alte metode de discretizare nu garanteaza pastrarea stabilitatii la
% trecerea din continuu in discret

Cd = c2d(C,Te,'tustin');

%% Cerinta 9

% u[k] = u[k-1] + 1.003*eps[k] - 0.997*eps[k-1]
mdl2 = 'tema2_mdl2';
load_system(mdl2);
set_param(mdl2, 'StopTime', num2str(t(end)));
out2 = sim('tema2_mdl2');
y = out2.y.Data(end);
norm(r - y)

%% Cerinta 10

% sist neliniar urmareste referinta treapta asemanator cu sistemul liniar
% ambele se stabilizeaza odata cu cresterea timpului
