function argout = CalcK(edgeLengths,operation,particle,fluid,membrane)
%% 考查不同颗粒尺寸的静摩擦力系数
% edgeLengths = 10.^linspace(-7,-3); % 正六面体颗粒的边长
% edgeLengths = 100e-6;
argout = arrayfun(@(x) setParticleSize(x), edgeLengths);
% 绘图输出
figure('name', '不同颗粒尺寸的静摩擦力系数')
plot(edgeLengths,[argout.K])
xlabel('$L$ (m)','interpreter','latex');
ylabel('$K$ (dimensionless)','interpreter','latex');

function argout = setParticleSize(L)
    particle.Volume = L^3;
    particle.Mass = particle.Density*particle.Volume; % 质量（kg）
    particle.EqvSize = (particle.Volume/(4/3*pi))^(1/3); % 等体积球体半径（m）
    particle.Interface = L^2; % 液固界面积（m2）
    % 计算维持膜面颗粒相对静止的摩擦力系数
    [~,argout] = CalcForce(operation,particle,fluid,membrane);
end

end