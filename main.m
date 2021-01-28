%% ��תĤ������������������
%
% by Dr. Guoqiang Guan @ SCUT on 2021-1-13

%% ��ʼ��
clear
% ��������
operation.Rotation.Radium = 10e-3; % תͲ�뾶��m��
operation.Rotation.Speed = 50; % ת�٣�rpm��
operation.Rotation.AngularVelocity = operation.Rotation.Speed/2/pi/60; % ���ٶȣ�rad/s��
operation.Inlet.Velocity = 0; % �������٣���z�����ٶȣ�m/s��
operation.Z0 = 5e-2; 
% ��������
particle.Form = '������';
particle.Density = 2.165e3; % �ܶȣ�kg/m3��
particle.Volume = 1e-6; % �����m3��
particle.Mass = particle.Density*particle.Volume; % ������kg��
particle.EqvSize = (particle.Volume/(4/3*pi))^(1/3); % ���������뾶��m��
particle.Interface = particle.Volume^(2/3); % Һ�̽������m2��
particle.Position = [0,operation.Rotation.Radium,0]; % ����(z,r,theta)
% ��������
fluid.Viscosity = 1e-3;
fluid.Density = 1e3;
% Ĥ������
membrane.Roughness = 1e-8;
membrane.KS = 1e-1; % ��Ħ����ϵ��
membrane.KM = 1e-2; % ��Ħ����ϵ��
membrane.H = 40e-3; % Ĥ��ߴ�H
membrane.W = 2*pi*operation.Rotation.Radium; % Ĥ��ߴ�W

%% ��������˶�
y0 = zeros(6,1); % z�����ٶȡ�z����λ�á�r�����ٶȡ�r����λ�á�theta�����ٶȡ�theta����λ��
y0(2) = particle.Position(1);
y0(4) = particle.Position(2);
y0(6) = particle.Position(3);
[t,y] = ode45(@(t,y) motionEq(t,y,operation,particle,fluid,membrane), [0,1.0], y0);

%% ���
% �����켣
outTab = table(t,y(:,2),y(:,6),'VariableNames',{'time','z','theta'});
rt = interp1(y(:,2), y(:,6), membrane.H);
fprintf('��������Ĥ�澭����ʱ��Ϊ%.3e�룡\n', rt)
figure('name', '������Ĥ�滬�ƵĹ켣')
plot(y(:,6),y(:,2),'ro')
axis([-membrane.W/2, membrane.W/2, 0, membrane.H])
xlabel('$\theta R$ (m)', 'interpreter', 'latex')
ylabel('$z$ (m)', 'interpreter', 'latex')
hold on
% rectangle('Position', [y(1,6), y(1,2), membrane.W, membrane.H])
% hold off

function dy = motionEq(t,y,operation,particle,fluid,membrane)
    % ���¿���λ��
    particle.Position = [y(1),y(3),y(5)];
    % �����������
    force = CalcForce(operation,particle,fluid,membrane);
    m = particle.Mass;
    dy = zeros(6,1);
    dy(1) = force(1)/m; 
    dy(2) = y(1);
    dy(3) = force(2)/m;
    dy(4) = y(3);
    dy(5) = force(3)/m;
    dy(6) = y(5);
end

