pubkey:
	gpg --dearmor pubkey.asc

privkey:
	gpg --export-secret-key 3C2DE0F1FB93D0EE > privkey.gpg

paperkey: privkey
	paperkey --secret-key privkey.gpg --output paperkey.txt

qrcode: privkey
	paperkey --secret-key privkey.gpg --output-type raw | base64 | qrencode -o qrcode.png

restore-paperkey: pubkey
	paperkey --pubring pubkey.asc.gpg --secrets paperkey.txt --output restored.gpg

restore-qrcode: pubkey
	zbarimg qrcode.png | \
                cut -d':' -f2 | \
                base64 --decode | \
                paperkey --pubring pubkey.asc.gpg --output restored.gpg
