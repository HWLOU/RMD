function RPMs = CalcRPM(edgeLengths, operation, particle, fluid, membrane)
% ������������ߴ�������ķ��������ת��
RPMs = arrayfun(@(x)fzero(@(RPM)CalcFn(RPM,x),1/x), edgeLengths);
% ��ͼ���
figure('name','��ͬ�����ߴ��µ���������ת��')
plot(log10(edgeLengths), log10(RPMs), 'ro')
xlabel('$\log_{10}L$ (m)','interpreter','latex')
ylabel('$\log_{10}\Omega$ (RPM)','interpreter','latex')

function Fn = CalcFn(RPM,L)
    operation.Rotation.Speed = RPM;
    [particle,operation] = InitParticle(operation,particle); 
    particle.Volume = L^3;
    particle.Mass = particle.Density*particle.Volume; % ������kg��
    particle.EqvSize = (particle.Volume/(4/3*pi))^(1/3); % ���������뾶��m��
    particle.Interface = L^2; % Һ�̽������m2��  
    % ����ά��Ĥ�������Ծ�ֹ��Ħ����ϵ��
    [~,argout] = CalcForce(operation,particle,fluid,membrane,'stationary');
    Fn = (argout.F(5)-argout.F(1)-argout.F(2))*1e6;

end

end
