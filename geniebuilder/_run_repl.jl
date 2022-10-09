using GenieBuilder
using GenieBuilder.Genie.HTTPUtils.HTTP
using RemoteREPL

get!(ENV, "GB_HOST", "127.0.0.1")
get!(ENV, "GB_PORT", "10101")

function appid()
  appid = 0

  for arg in ARGS
    if startswith(arg, "appid=")
      appid = parse(Int, arg[7:end])
      break
    end
  end

  appid == 0 && throw("appid is required")

  appid
end

function startrepl()
  response = try
    url = "http://$(ENV["GB_HOST"]):$(ENV["GB_PORT"])/api/v1/apps/$(appid())/startrepl"
    HTTP.get(url).body |> String |> GenieBuilder.Genie.Renderers.Json.JSONParser.JSON3.read
  catch
    @error "Something went wrong. Please try again."
    Dict("status" => "KO")
  end

  if response["status"] == "OK"
    @async while true
      if isdefined(Base,:active_repl)
        RemoteREPL.connect_repl(response["port"])
        break
      else
        sleep(0.25)
      end
    end
  else
    println("Invalid response from server: $response")
    exit(1)
  end

  nothing
end