times_by_ids = {}
last_quest = 0

line = io.read()
while line do
    -- runs only once
    for id, quest, part, time in string.gmatch(line, 'id=(%d+) quest=(%d+) part=(%d+) time=(%d+)') do
        quest = tonumber(quest)
        part = tonumber(part)
        time = tonumber(time)
        last_quest = math.max(last_quest, quest)
        if times_by_ids[id] == nil then
            times_by_ids[id] = {time = 0, parts = 0, quests = {}}
        end
        if times_by_ids[id]['quests'][quest] == nil then
            times_by_ids[id]['quests'][quest] = {}
        end
        times_by_ids[id]['time'] = times_by_ids[id]['time'] + time
        times_by_ids[id]['parts'] = times_by_ids[id]['parts'] + 1
        times_by_ids[id]['quests'][quest][part] = time
    end

    line = io.read()
end

quests_parts_sum = {}
for q = 1, last_quest do
    quests_parts_sum[q] = {{}, {}, {}}
end

for id, data in pairs(times_by_ids) do
    for quest, parts in pairs(data['quests']) do
        for part = 1, 3 do
            if parts[part] ~= nil then
                if part > 1 then
                    parts[part] = parts[part] + parts[part - 1]
                end
                table.insert(quests_parts_sum[quest][part], {time = parts[part], id = id})
            end
        end
    end
end

overall_rankings_by_ids = {}

for quest, parts in pairs(quests_parts_sum) do
    for part, times in pairs(parts) do
        table.sort(times, function (a, b)
            return a['time'] < b['time']
        end)

        last_time = nil
        last_score = nil
        for i = 1, #times do
            time = times[i]['time']
            
            position = i

            if time == last_time then
                position = last_position
            end

            score = math.max(0, part * 50 - position + 1)

            if overall_rankings_by_ids[times[i]['id']] == nil then
                overall_rankings_by_ids[times[i]['id']] = 0
            end
            overall_rankings_by_ids[times[i]['id']] = overall_rankings_by_ids[times[i]['id']] + score

            last_time = time
            last_position = position
        end
    end
end


overall_rankings = {}
for _, v in pairs(overall_rankings_by_ids) do
    table.insert(overall_rankings, v)
end
table.sort(overall_rankings, function (a, b)
    return a > b
end)

checksum = 0
last_position = 0
last_score = 0
for i, score in ipairs(overall_rankings) do
    position = i

    if score == last_score then
        position = last_position
    end

    checksum = checksum + position * score

    last_score = score
    last_position = position
end

print(checksum)