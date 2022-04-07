% Delea Cynthia Andreea 332AB Tema 1: Model_1

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

mdl = 'tema1_mdl';
load_system(mdl);

%% Cerinta 2

t = linspace(0, 400, 1000)';
in = double(t>=0);
set_param(mdl, 'StopTime', num2str(t(end)));
usim = timeseries(in,t); 

%% Cerinta 3

out = sim(mdl)


%% Cerinta 4

for i=1 : length(out.simout_mat1.Data)
    err_1(i) = out.simout_mat1.Data(i) - out.simout_fcn1.Data(i);
end

for j=1 : length(out.simout_mat2.Data)
    err_2(j) = out.simout_mat2.Data(j) - out.simout_fcn2.Data(j);
end

% ma asteptam ca err1 si err 2 sa fie 0, ele sunt intr-adevar 0, 
% deoarece sunt aceleasi ecuatii, dar modul de implementare difera

err1 = norm(err_1,2)
err2 = norm(err_2,2)

%% Cerinta 5

ustar = zeros(10,1);

y1star = zeros(10,1);
y2star = zeros(10,1);

k2 = linspace( 0.05, 3, 10);
%k2 = linspace( 0.05, 10, 10);

for i = 1:numel(k2)
    in = k2(i).*double(t>=0);
    usim = timeseries(in, t);
    out = sim(mdl)
    
    ustar(i) = k2(i);
    y1star(i) = out.simout_mat1.Data(end);
    y2star(i) = out.simout_mat2.Data(end);
    
end

p1 = polyfit(ustar, y1star, 8)
p2 = polyfit(ustar, y2star, 8)

ustar_2 = ustar(1):0.01:ustar(end);
y1_fit = polyval(p1, ustar_2);
y2_fit = polyval(p2, ustar_2);



figure, hold on


plot(ustar, y1star,'bx')
hold on
plot(ustar, y2star,'rx')
hold on

plot(ustar_2,y1_fit,'b--')
plot(ustar_2,y2_fit,'r--')

title('Caracterstica statica')
legend('y1star' , 'y2star', 'aproximarea polinomiala y1', 'aproximarea polinomiala y2','Location' , 'NW' )
xlabel('ustar [Nm]'), ylabel('y1star y2star [rad]')
grid on

%% Cerinta 6

alfa1 = polyval(p1, alfa);
alfa2 = polyval(p2, alfa);

beta1 = polyval(p1, beta);
beta2 = polyval(p2, beta);

gama1 = polyval(p1, gama);
gama2 = polyval(p2, gama);




 


