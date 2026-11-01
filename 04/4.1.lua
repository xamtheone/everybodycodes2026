times_by_ids = {}

line = io.read()
while line do
    -- runs only once
    for id, quest, part, time in string.gmatch(line, 'id=(%d+) quest=(%d+) part=(%d+) time=(%d+)') do
        if times_by_ids[id] == nil then
            times_by_ids[id] = 0
        end
        times_by_ids[id] = times_by_ids[id] + tonumber(time)
    end

    line = io.read()
end

times = {}
for k, v in pairs(times_by_ids) do
    table.insert(times, v)
end

table.sort(times, function (a, b)
    return a < b
end)

checksum = 0

for i = 1, #times do
    checksum = checksum + i * times[i]
end

print(checksum)