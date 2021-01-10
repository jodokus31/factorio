local Logger = {}
Logger.mode = 0
Logger.print_to_console = false

function Logger.set_mode(mode)
    Logger.mode = mode
end

function Logger.set_print_to_console(print_to_console)
    Logger.print_to_console = print_to_console
end

function Logger.get_severity_text(severity)
    
    local severity_text = nil
    
    if severity == 0 then
        severity_text = "fatal"
    elseif severity == 1 then
        severity_text = "error"
    elseif severity == 2 then
        severity_text = "warning"
    elseif severity == 3 then
        severity_text = "info"
    elseif severity == 4 then
        severity_text = "debug"
    end

    return severity_text
end

function Logger.log(severity, text, print_to_console)
    if Logger.mode < severity then
        return
    end

    local severity_text = Logger.get_severity_text(severity)
    local logtext = text
    if severity_text then
        logtext = severity_text .. ": " .. logtext 
    end

    log(logtext)
    if print_to_console and game and game.print then
        game.print(logtext)
    end
end

function Logger.fatal(text) Logger.log(0, text, Logger.print_to_console) end
function Logger.error(text) Logger.log(1, text, Logger.print_to_console) end
function Logger.warn(text) Logger.log(2, text, Logger.print_to_console) end
function Logger.info(text) Logger.log(3, text, Logger.print_to_console) end
function Logger.debug(text) Logger.log(4, text, Logger.print_to_console) end

function Logger.manual(text, enableprint) Logger.log(-1, text, enableprint) end

return Logger
