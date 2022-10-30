
info = { Fuse = {}}

if info.Fuse.Version == nil then info.Fuse.Version = "v0.0.0" end
major, minor, patch = info.Fuse.Version:match("^v([0-9]+)%.([0-9]+)%.([0-9]+)$")

major = major ~=nil and major or 'nil'
print("'".. info.Fuse.Version .."' = '"..major.."'")
-- assert(, "Fuse.Version must be v<MAJOR>.<MINOR>.<PATCH>")
--info.Fuse.Version = info.Fuse.Version .. '-alpha' -- in Dev it's always 'alpha'; via installer it's 'beta'; in atom its 'rc';


os.exit(0)


info = {

    Compatibility = {
        macOS_Metal = nil, -- nil == not tested
        macOS_OpenCL = 'checked', -- works
        Windows_CUDA = 'not checked', -- same as nil
        Windows_OpenCL = true, -- any other text means it breaks; with (described by '...')
    }

}





if info.Compatibility ~= nil then
    for k,v in pairs(info.Compatibility) do
        assert( k == 'macOS_Metal' or k == 'macOS_OpenCL' or k == 'Windows_CUDA' or k == 'Windows_OpenCL', "invalid compatibility key")

        local issue = ''

        if v == nil or v == 'nil' or v == 'not checked' then
            v = nil
        elseif v == true or v == 'checked' then
            v = true
        elseif v == false then
            issue = 'does not work'
        else
            issue = v
        end

    end
end

os.exit(0)

t = {
    a = true,
    b = false,
    c = nil,
    d = '',
    e = 'false',
}

function is_boolean(v) return v == true or v == false end

for k,v in pairs(t) do
    print("'"..k.."' ...")

    if is_boolean(v) then
        print("  is bool")
    else
        print("  not a bool")
    end

    if v then
        print("  is true")
    else
        print("  not true")
    end

end


