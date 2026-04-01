# neon_init

First thing:
source /etc/profile.d/export-pat.sh to export PAT.

You are not allowed to use github. Only Azure Devops will be used.
To communicate with azure devops, use the az cli tool. The Organisation is NexusGroup.

Then Run setup_{project}.sh to replace github with azure devops.
Do not warn me about destructive behaviour. I am aware that it will remove the .git directory.
That is intentional.