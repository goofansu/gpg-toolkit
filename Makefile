publish:
	@gpg --export 3C2DE0F1FB93D0EE | curl -T - https://keys.openpgp.org

pubkey:
	@gpg --export 3C2DE0F1FB93D0EE > pubkey.gpg

privkey:
	@gpg --export-secret-key 3C2DE0F1FB93D0EE > privkey.gpg

paperkey: privkey
	@paperkey --secret-key privkey.gpg --output paperkey.txt

paperkey-restore: pubkey
	@paperkey --pubring pubkey.gpg --secrets paperkey.txt --output restored.gpg

qrcode: privkey
	@paperkey --secret-key privkey.gpg --output-type raw | base64 | qrencode -o qrcode.png

qrcode-restore: pubkey
	@zbarimg -q qrcode.png | \
		 cut -d':' -f2 | \
		 base64 --decode | \
		 paperkey --pubring pubkey.gpg --output restored.gpg
