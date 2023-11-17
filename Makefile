pubkey:
	gpg --dearmor pubkey.asc

privkey:
	gpg --export-secret-key 3C2DE0F1FB93D0EE > privkey.gpg

paperkey: privkey
	paperkey --secret-key privkey.gpg --output paperkey.txt

restore: pubkey
	paperkey --pubring pubkey.asc.gpg --secrets paperkey.txt --output restored.gpg
