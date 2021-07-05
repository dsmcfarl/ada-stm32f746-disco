# adapted from:
# https://stackoverflow.com/questions/57807905/openocd-exit-on-breakpoint
# https://stackoverflow.com/questions/10501121/how-to-execute-finish-and-then-another-command-from-inside-commands

target extended-remote localhost:3333
monitor arm semihosting enable
monitor reset halt
load
monitor reset init

define handlerunner
finish
quit fail_count
end

break runner
commands
handlerunner
end

continue
