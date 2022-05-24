-- Register the behaviour
behaviour("SudoKillSound")

function SudoKillSound:Start()
    self.volume = self.script.mutator.GetConfigurationRange("KillSoundVolume")
    local vol = self.volume/100;
	self.targets.AudioSource.volume = vol
    self.targets.AudioSource.SetOutputAudioMixer(AudioMixer.Important)
    GameEvents.onActorDied.AddListener(self,"onActorDied")
end

function SudoKillSound:onActorDied(actor,source,isSilent)
    if not actor.isPlayer and source == Player.actor and actor.team ~= Player.actor.team then
		-- delete "and actor.team ~= Player.actor.team" if you want the kill sound to play for every bot you kill
        if self.script.mutator.GetConfigurationBool("RandomizeKillSound") then
            self.targets.KillSoundBank.PlayRandom()
        elseif not self.script.mutator.GetConfigurationBool("RandomizeKillSound") then
            local index = self.script.mutator.GetConfigurationDropdown('ListKillSound')
            self.targets.KillSoundBank.PlaySoundBank(index)
        end
    end
end
