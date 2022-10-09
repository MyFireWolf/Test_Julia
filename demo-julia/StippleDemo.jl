#=
using Genie, Genie.Renderer.Html, Stipple

#Base.@kwdef mutable struct Name <: ReactiveModel
@reactive mutable struct Name <: ReactiveModel
  name::R{String} = "World!"
end

#model = Stipple.init(Name())
model = Stipple.init(Name)

function ui()
  page(
    vm(model), class="container", [
      h1([
        "Hello "
        span("", @text(:name))
      ])

      p([
        "What is your name? "
        input("", placeholder="Type your name", @bind(:name))
      ])
    ], channel = model.channel__ # the channel assigned to model
  ) |> html
end

route("/", ui)

up()
=#

import Stipple
import Stipple: @with_kw, @reactors, R, ChannelName
import Genie
import StippleUI
import StipplePlotly
import Colors
import ColorSchemes

@Stipple.reactive mutable struct MarkerModel <: Stipple.ReactiveModel
	plot::Stipple.R{Int} = 0
	data_plot::Stipple.R{Vector{StipplePlotly.PlotData}} = []
end

function plot_data(markers_model::MarkerModel)
	plot_collection = Vector{StipplePlotly.PlotData}()
	plot = StipplePlotly.PlotData(
				x = rand(100),
				y = rand(100),
				mode = "markers",
				marker = Dict(:color => "#" .* Colors.hex.(ColorSchemes.rainbow[rand(100)])),
				plot = StipplePlotly.Charts.PLOT_TYPE_SCATTER)
	push!(plot_collection, plot)
	return plot_collection
end

function markers_ui(markers_model::MarkerModel)
	Stipple.on(markers_model.plot) do (_...)
		@info "Plot  ..."
		markers_model.data_plot[] = plot_data(markers_model)
	end
	Stipple.page(markers_model, class="container",
		prepend=Stipple.style("""
		tr:nth-child(even) {
			background: #F8F8F8 !important;
		}
		.modebar {
			display: none!important;
		}
		.st-module {
			background-color: #FFF;
			border-radius: 2px;
			box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.04);
		}
		.stipple-core .st-module > h5
		.stipple-core .st-module > h6 {
			border-bottom: 0px !important;
		}"""),
		[
			StippleUI.heading("Plot")
			Stipple.row([
				Stipple.cell(class="st-module", [
					Stipple.button("Plot!", @StippleUI.click("plot += 1"))
				])
				Stipple.cell(class="st-module", [
					Stipple.h5("Data:")
					StipplePlotly.plot(:data_plot, layout=:layout, config="{displayLogo:false}")
				])

			])
		]
	)
end

Stipple.route("/") do
	m = Stipple.init(MarkerModel)
	Stipple.html(markers_ui(m))
end

Stipple.up(9000;async=true)
#Stipple.down()Stipple.up(9000, async=true, server=Stipple.bootstrap())



