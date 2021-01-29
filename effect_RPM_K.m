function argout = effect_RPM_K(speeds, edgeLengths, operation, particle, fluid, membrane)
%
i = 1;
operation.Rotation.Speed = speeds(i);
[particle,operation] = InitParticle(operation,particle);
plotName = sprintf('%drpm',speeds(i));
% ���㲻ͬ�����ߴ�ľ�Ħ����ϵ��
argout = CalcK(edgeLengths, operation, particle, fluid, membrane, plotName);
% ����������ת���Ƿ���ڿ�����Ĥ�淨�����˶����������룩
idx = find(isnan([argout.K]),1);
if ~isempty(idx)
    fprintf('�߳�����%.4em�Ŀ�����%dRPM���������룡\n',edgeLengths(idx),speeds(i))
end
argout = repmat(argout,length(speeds),1);
for i = 2:length(speeds)
    operation.Rotation.Speed = speeds(i);
    [particle,operation] = InitParticle(operation,particle);
    plotName = sprintf('%drpm',speeds(i));
    % ���㲻ͬ�����ߴ�ľ�Ħ����ϵ��
    argout(i,:) = CalcK(edgeLengths, operation, particle, fluid, membrane, plotName);
    % ����������ת���Ƿ���ڿ�����Ĥ�淨�����˶����������룩
    idx = find(isnan([argout(i,:).K]),1);
    if ~isempty(idx)
        fprintf('�߳�����%.4em�Ŀ�����%dRPM�½��������룡\n',edgeLengths(idx),speeds(i))
    end
end
hold off
