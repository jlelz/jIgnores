local _, Addon = ...;
Addon.Defaults = {
    Debug = true,
};

Addon.Events = CreateFrame( 'Frame' );
Addon.Events:RegisterEvent('GROUP_ROSTER_UPDATE');
Addon.Events:SetScript( 'OnEvent',function( self,Event,... )
    local GroupSize = GetNumGroupMembers();
    local GroupMembers = {};
    local Alerted = {};

    if IsInRaid() then
        for I = 1,GroupSize do
            local Name = GetRaidRosterInfo(I);
            GroupMembers[ Name ] = {
                Name = Name,
            };
        end
    end
    if IsInGroup() then
        for I = 1,GroupSize do
            local Name = GetRaidRosterInfo(I);
            GroupMembers[ Name ] = {
                Name = Name,
            };
        end
    end
    for I,PartyMember in pairs( GroupMembers ) do
        if( C_FriendList.IsOnIgnoredList( PartyMember.Name ) ) then
            if( not Alerted[ PartyMember.Name ] ) then
                Addon.FRAMES:Error( 'ignored idiot in your group!',PartyMember.Name );
                Alerted[ PartyMember.Name ] = true;
            end
        end
    end
end );