local item_decay_defaults = require('item_decay_defaults')

Statistics = {}
Statistics.logger = nil

function Statistics.resetStatistics()
    global.SpiceRack_Statistics = global.SpiceRack_Statistics or {}
    global.SpiceRack_Statistics.ItemStatistics = global.SpiceRack_Statistics.ItemStatistics or {}
    global.SpiceRack_Statistics.ItemStatisticsRunning = nil
end

function Statistics.copyStatistics()
    if global.SpiceRack_Statistics.ItemStatisticsRunning then
        
        global.SpiceRack_Statistics.ItemStatistics = table.deepcopy(global.SpiceRack_Statistics.ItemStatisticsRunning)
        
        for _, stat in pairs(global.SpiceRack_Statistics.ItemStatisticsRunning) do
            -- reset some values every "round"
            stat.current_amount = 0
            stat.container_count = 0
            stat.fill_factor_sum = 0
        end
    else
        global.SpiceRack_Statistics.ItemStatisticsRunning = {}
    end
end

function Statistics.updateStatistics(itemname, new_count_ceiling, new_fraction, int_diff, max_decay_factor, per_hour_exponent, fill_factor)
    if not global.SpiceRack_Statistics.ItemStatisticsRunning then
        return
    end

    local specificItemStatistics = global.SpiceRack_Statistics.ItemStatisticsRunning[itemname]
    specificItemStatistics = specificItemStatistics or 
        {
            current_amount = 0,
            current_fraction = 0,
            overall_decayed = 0,
            max_decay_factor = 0,
            per_hour_exponent = 0,
            container_count = 0,
            fill_factor_sum = 0,
        }
    specificItemStatistics.current_amount = specificItemStatistics.current_amount + new_count_ceiling
    specificItemStatistics.current_fraction = new_fraction
    specificItemStatistics.overall_decayed = specificItemStatistics.overall_decayed + int_diff
    specificItemStatistics.max_decay_factor = max_decay_factor
    specificItemStatistics.per_hour_exponent = per_hour_exponent
    specificItemStatistics.container_count = specificItemStatistics.container_count + 1
    specificItemStatistics.fill_factor_sum = specificItemStatistics.fill_factor_sum + fill_factor
    
    global.SpiceRack_Statistics.ItemStatisticsRunning[itemname] = specificItemStatistics
end

function Statistics.logStatistics(nextUpdateInSec)
    if not next(global.SpiceRack_Statistics.ItemStatistics) then
        Statistics.logger.manual(
            string.format("no item statistics yet, wait for next update in ~%0.2f sec.", nextUpdateInSec),
            true)
    else
        Statistics.logger.manual("item statistics:", true)

        for itemname, _ in pairs(item_decay_defaults) do
            local stat = global.SpiceRack_Statistics.ItemStatistics[itemname]
            if stat then
                Statistics.logger.manual(
                    string.format("%s (%d): amount: %d, overall_decayed: %d, fraction: %0.6f, max decay: %0.4f%% in %0.2f sec. (avg fill_factor %0.2f%%)",
                        itemname, stat.container_count, stat.current_amount, stat.overall_decayed, stat.current_fraction, (1 - stat.max_decay_factor) * 100, stat.per_hour_exponent*60*60, stat.fill_factor_sum*100/stat.container_count),
                    true)
            end
        end

        Statistics.logger.manual(
            string.format("next update in ~%0.2f sec.", nextUpdateInSec),
            true)
    end
end

return Statistics