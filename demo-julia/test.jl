#=
using Plots
sleep(100)
y= rand(20,1)
plot(y,linewidth=2,title="test...")


using Genie
route("/hello") do
    "您好！"
end


using Genie.Renderer.Html
route("/html") do
    h1("Welcome to Genie!") |> html
end


using Genie.Renderer.Json
route("/json") do
    (:greeting => "Welcome to Genie!") |> json
end


up(8888) 
=#
using GLMakie
GLMakie.activate!()
x = 1:10
fig = lines(x, x.^2; label = "Parabola")
axislegend()
save("D:/g20m.png", fig,  resolution = (600,400))
fig



