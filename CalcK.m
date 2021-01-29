function argout = CalcK(edgeLengths,operation,particle,fluid,membrane,plotName)
%% ����������
if ~exist('plotName','var')
    plotName = 'Unnamed';
end
%% ���鲻ͬ�����ߴ�ľ�Ħ����ϵ��
% edgeLengths = 10.^linspace(-7,-3); % ������������ı߳�
% edgeLengths = 100e-6;
argout = arrayfun(@(x) setParticleSize(x), edgeLengths);
% ��ͼ���
% ÿ�ε���CalcK()������Ƿ�������Ϊ'Ħ����ϵ��������ߴ�ı仯����'��figure����
% �������½��ö����ɴ˷�ֹ�ڶ��ͬ������Ų�ͬ��figure�зֱ����Ħ����ϵ�������
% �ߴ�ı仯����
if isempty(findobj('Name','Ħ����ϵ��������ߴ�ı仯����')) 
    figure('name', 'Ħ����ϵ��������ߴ�ı仯����')
end
plot(edgeLengths,[argout.K],'DisplayName',plotName)
xlabel('$L$ (m)','interpreter','latex');
ylabel('$K$ (dimensionless)','interpreter','latex');
if ~strcmp(plotName,'Unnamed')
    legend boxoff;
end
hold on

function argout = setParticleSize(L)
    particle.Volume = L^3;
    particle.Mass = particle.Density*particle.Volume; % ������kg��
    particle.EqvSize = (particle.Volume/(4/3*pi))^(1/3); % ���������뾶��m��
    particle.Interface = L^2; % Һ�̽������m2��
    % ����ά��Ĥ�������Ծ�ֹ��Ħ����ϵ��
    [~,argout] = CalcForce(operation,particle,fluid,membrane,'stationary');
end

end