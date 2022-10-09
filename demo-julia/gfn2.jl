macro gfn1(fname, arg)
    quote
        function $(esc(fname))($arg)
            $arg
        end
    end
end

#展开宏 @macroexpand(@gfn1(fn1,arg1))

