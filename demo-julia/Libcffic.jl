#=
using Cxx
cxx"""
#include <iostream>
"""
function playing()
    for i = 1:5
        icxx"""
            int tellme;
            std::cout<< "Please enter a number: " << std::endl;
            std::cin >> tellme;
            std::cout<< "\nYour number is " << tellme<< "\n" << std::endl;
        """
    end
end
playing()

using PyCall
@pyimport Tkinter as tk

@pydef type SampleApp <: tk.Tk
    __init__(self, args...; kwargs...) = begin
        tk.Tk[:__init__](self, args...; kwargs...)
        self[:label] = tk.Label(text="Hello, world!")
        self[:label][:pack](padx=10, pady=10)
    end
end

app = SampleApp()
app[:mainloop]()




using PyCall
math = pyimport("math")
math.sin(math.pi / 4)

s = pyimport("os")
print(string(s.__file__))



# 引用可视化库
using GLMakie
using GLMakie.Colors
using GLMakie.GeometryBasics
# 引用格式化输出库
using Printf

# 生成30个角度序列，范围从0~1
frame_iterator = range(0, 1, length=30)

# 组成的正方形的四个坐标(0,0),(1,0),(1,1),(0,1)
# 表示成矩阵形式，每一列表示为一对坐标
square = [0 1 1 0
          0 0 1 1]

# 创建图形窗口
fig = Figure()
# Axis表示在Figure中创建一个子图
ax = Axis(fig[1, 1])
# 设置x，y轴坐标范围设置
xlims!(ax, -2, 4)
ylims!(ax, -2, 4)


function update(frame)
    # 错切变换矩阵
    M1 = [1 2*frame
          0 1]
    # 计算变换后的向量
    square2 = M1*square
    # 每一帧绘制前清空之前的绘制画面
    empty!(ax)
    # 绘制变换后的正方形区域
    # color定义填充区域的颜色，填充颜色随着角度不断变化
    # strokecolor为正方形边框的颜色
    # strokewidth为边框的宽度
    poly!(Point2f[square2[1:2], square2[3:4],square2[5:6], square2[7:8]], color = HSV(frame*360, 1, 0.75), strokecolor = :black, strokewidth = 1)
    # 分别绘制四个顶点坐标数据
    x, y = @sprintf("%1.1f",square2[1]), @sprintf("%1.1f",square2[1])
    text!("($x,$y)", position=(square2[1],square2[2]))
    x, y = @sprintf("%1.1f",square2[3]), @sprintf("%1.1f",square2[4])
    text!("($x,$y)", position=(square2[3],square2[4]))
    x, y = @sprintf("%1.1f",square2[5]), @sprintf("%1.1f",square2[6])
    text!("($x,$y)", position=(square2[5],square2[6]))
    x, y = @sprintf("%1.1f",square2[7]), @sprintf("%1.1f",square2[8])
    text!("($x,$y)", position=(square2[7],square2[8]))
end
# 动画录制方法，动画生成gif文件
# frame_iterator为0~1范围的序列，每个值对应动画的一帧
# framerate控制动画的快慢
# update方法是具体的画面绘制，输入参数为frame_iterator中的值
record(update, fig, "2d_transform_miscut.gif", frame_iterator; framerate = 10)

using Makie
scene = mesh(Sphere(Point3f0(0), 1f0))
display(scene)
=#
using WGLMakie.JSServe
JSServe.Server("hello,world!","0.0.0.0",80)
