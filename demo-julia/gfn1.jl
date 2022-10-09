macro gfn(fname, arg)
    quote
        function $fname($arg)
            $arg
        end
    end
end

#展开宏 @macroexpand(@gfn(fn1,arg1))

macro varname(arg)
    string(arg)
end