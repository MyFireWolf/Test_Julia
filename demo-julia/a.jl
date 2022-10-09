function f(x, y)
    x + y
end
#测试 通过Julia宏  调用C标准库 打印函数
println(f(2, 3))
println("第102129100129中91000733569012018309宏\n")
println("第9129003919尊861873258101502968哈富\n")

using Printf
@printf "Hello %s\n" "world"

foo = 6
@ccall printf("%s = %d"::Cstring; "foo"::Cstring, foo::Cint)::Cint
for i in range(0, 10)
    println(i)
end

#using IJulia
#notebook()
println(5 isa Real)
function f(x)
    x + 1
end
println(f.(5))

@printf("Hello %s\n", "world")

#=
struct Foo
    bar
    baz::Int
    qux::Float64
    end
aa = Foo("()",25,1.2)

aa.bar="Hello" 不可变复合类型不能改变字段值



mutable struct Foo
    bar
    baz::Int
    qux::Float64
end
aa = Foo("()", 25, 1.2)
aa.bar = "Hello"

macro say(a)
     :(print("show $a"))
end

@say(show(4))
=#

macro showarg(x)
    show(x)
    :(
        if $x
            3
        end
    )
    # ... remainder of macro, returning an expression
end


macro sws(x)
    show(x)
    quote
        if $x
            3
        end
    end

    # ... remainder of macro, returning an expression
end

#= 
julia> @sws(x)
:xERROR: UndefVarError: x not defined
Stacktrace:
 [1] top-level scope
   @ c:\Users\52282\Desktop\a.jl:68

julia> @sws(4<5)
:(4 < 5)3

julia> @sws(46<5)
:(46 < 5)
=#

#=
macro say1(a)
    println(a)
    :(
        println(5)
        print("Show:  ", $a)
    )
    :(
        print("Show:  ", $a)
    )
end
=#

macro say(a)
    println(a)
    quote
        println(5)
        println("Show:  ", $a)
    end
end
@say(show(4))

macro ff(x, y)
    println(x)
    return typeof(x)
end
y = @ff(xx, 4)
println(y)

macro gfn(fname, arg)
    quote
        function $(esc(fname))($arg)
            $y
        end
    end
end

#@macroexpand(@gfn(fn1,arg1))
#fn1=@gfn(fn1,arg1)
#fn1(6)
#@ffn(fn1,arg1)(7)
#fn1(7)
println(9)




