function [particles,outTab] = Trajectory(tspan,operation,particle,fluid,membrane)

y0 = zeros(6,1); % z�����ٶȡ�z����λ�á�r�����ٶȡ�r����λ�á�theta�����ٶȡ�theta����λ��
y0(2) = particle.Position(1);
y0(4) = particle.Position(2);
y0(6) = particle.Position(3);
y0(1) = particle.Velocity(1);
y0(3) = particle.Velocity(2);
y0(5) = particle.Velocity(3);
[t,y] = ode45(@(t,y) motionEq(t,y,operation,particle,fluid,membrane), tspan, y0);
% ��������켣
particles = struct;
for i = 1:length(t)
    particles(i).Time = t(i);
    particle.Position(1) = y(2);
    particle.Position(2) = y(4);
    particle.Position(3) = y(6);
    particles(i).Spec = particle;
end

% �����켣
outTab = table(t,y(:,2),y(:,6),'VariableNames',{'time','z','theta'});
if max(y(:,2))>membrane.H
    rt = interp1(y(:,2), t, membrane.H);
    fprintf('��������Ĥ�澭����ʱ��Ϊ%.3e�룡\n', rt)
    figure('name', '������Ĥ�滬�ƵĹ켣')
    plot(y(:,6),y(:,2),'ro')
    axis([-membrane.W/2, membrane.W/2, 0, membrane.H])
    xlabel('$\theta R$ (m)', 'interpreter', 'latex')
    ylabel('$z$ (m)', 'interpreter', 'latex')
else
    fprintf('�ڿ���ʱ���ڿ���δ����Ĥ�棡\n')
end


end

function dy = motionEq(t,y,operation,particle,fluid,membrane)
    % ���¿���λ��
    particle.Position = [y(1),y(3),y(5)];
    % ���¿����ٶ�
    particle.Velocity = [y(2),y(4),y(6)];
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