% These are the parameters that are assumed to give as a parameters to
% fsolve.
%clear all;
%input parameters for four bar mechanism on the right side;
clc;
gf = 22.46;
af = 22.1;
Taf = -0.025;
ak = 32;
Tka = pi - 0.27;
ao = 2.025;
og = 31.74;
mo = 24.2;
alpha_mg = 2.107;
kl = 9.57;
lm = 10.61;
alpha_mn = -0.0532;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = 100;
theta1 = linspace(0,2*pi,N);
theta_gf = 0*theta1;
theta_go = 0*theta1;
theta_ml = 0*theta1;
theta_kl = 0*theta1;
theta_f_o_l_k = [9*pi/16, 5*pi/4, pi/4, 4*pi/3];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%options = optimoptions('fsolve', 'Display', 'iter');
for i=1:N
    xsol = fsolve(@(x)loop_closure_4_5bar(x,ao,og,mo,gf,af,lm,kl,ak,alpha_mg,Taf,Tka,theta1(i)),theta_f_o_l_k);
    theta_gf(i) = xsol(1);
    theta_go(i) = xsol(2);
    theta_ml(i) = xsol(3);
    theta_kl(i) = xsol(4);
    theta_f_o_l_k = [ theta_gf(i), theta_go(i), theta_ml(i), theta_kl(i)];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ab = 2.11;
bd = 45.365;
de = 40.996;
bc = 20.817;
ae = 18.75;
Tae = -0.0214;
%%%%%%%%%%%%%%
theta_db = 0*theta1;
theta_ed = 0*theta1;
theta_db_ed = [2*pi/3, 3*pi/2];
alpha_cd = 2.007;

for i=1:N
    xsol2 = fsolve(@(x)loop_closure_5_4bar(x,ab,bd,de,ae,Tae,theta1(i)),theta_db_ed);
    theta_db(i) = xsol2(1);
    theta_ed(i) = xsol2(2);
    theta_db_ed = [ theta_db(i), theta_ed(i)];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x_coord_l1 = [ak*cos(Tka)+ kl*cos(theta_kl)+lm*cos(theta_ml-alpha_mn)];
y_coord_l1 = [ak*sin(Tka)+ kl*sin(theta_kl)+lm*sin(theta_ml-alpha_mn)];
x_coord_l2 = [ab*cos(theta1)+bc*cos(theta_db-alpha_cd+pi)];
y_coord_l2 = [ab*sin(theta1)+bc*sin(theta_db-alpha_cd+pi)];

figure(1)
plot(x_coord_l1,y_coord_l1, 'b--')
hold on;
plot(x_coord_l2,y_coord_l2, 'b--')
pause(2);
hold off;


figure(2)
plot(theta1, theta_gf, 'b--');
hold on;
plot(theta1, theta_kl, 'r--');

plot(theta1, theta_ed, 'g--');
legend('theta_41 - blue', 'theta_42 - green', 'theta_6 - red', 'Location', 'best');

hold off;

grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    x_coord_l1 = [l11*cos(theta11)+l10*cos(theta10(i))+a91*l9*cos(theta9(i)-0.12)];
%    y_coord_l1 = [l11*sin(theta11)+l10*sin(theta10(i))+a91*l9*sin(theta9(i)-0.12)];
%    x_coord_l2 = [l1*cos(theta1(i))+l2*cos(theta2(i))+3.1*cos(1.888)];
%    y_coord_l2 = [l1*sin(theta1(i))+l2*sin(theta2(i))+3.1*sin(1.888)];
%    The functions that I got
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function F=loop_closure_4_5bar(x,ao,go,mo,gf,af,ml,kl,ka,alpha_mg,Taf,Tka,theta1)
F(1) = af*cos(Taf) + gf*cos(x(1)) + go*cos(x(2)) - ao*cos(theta1);
F(2) = af*sin(Taf) + gf*sin(x(1)) + go*sin(x(2)) - ao*sin(theta1);
F(3) = ao*cos(theta1)+mo*cos(x(2)+alpha_mg-pi) - ml*cos(x(3))-kl*cos(x(4))-ka*cos(Tka);
F(4) = ao*sin(theta1)+mo*sin(x(2)+alpha_mg-pi) - ml*sin(x(3))-kl*sin(x(4))-ka*sin(Tka);
end

function F2=loop_closure_5_4bar(x,ab,bd,de,ae,Tae,theta1)
F2(1) = -ab*cos(theta1) + bd*cos(x(1)) + de*cos(x(2)) + ae*cos(Tae);
F2(2) = -ab*sin(theta1) + bd*sin(x(1)) + de*sin(x(2)) + ae*sin(Tae);
end