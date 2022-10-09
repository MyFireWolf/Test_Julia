(pwd() != @__DIR__) && cd(@__DIR__) # allow starting app from bin/ dir

using App1
const UserApp = App1
App1.main()
