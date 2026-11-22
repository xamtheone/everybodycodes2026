times_by_ids = {}

line = io.read()
while line do
    -- runs only once
    for id, quest, part, time in string.gmatch(line, 'id=(%d+) quest=(%d+) part=(%d+) time=(%d+)') do
        if times_by_ids[id] == nil then
            times_by_ids[id] = {time = 0, parts = 0}
        end
        times_by_ids[id]['time'] = times_by_ids[id]['time'] + tonumber(time)
        times_by_ids[id]['parts'] = times_by_ids[id]['parts'] + 1
    end

    line = io.read()
end

times = {}
for k, v in pairs(times_by_ids) do
    table.insert(times, v)
end

table.sort(times, function (a, b)
    if a['parts'] ~= b['parts'] then
        return a['parts'] > b['parts']
    end

    return a['time'] < b['time']
end)

checksum = 0

for i = 1, #times do
    checksum = checksum + i * times[i]['time']
end

print(checksum)