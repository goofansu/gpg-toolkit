.PHONY: help publish pubkey privkey backup restore

help:
	@echo "GPG Toolkit Makefile"
	@echo "===================="
	@echo "Usage: make <target> GPG_ID=<your-gpg-key-id>"
	@echo ""
	@echo "Targets:"
	@echo "  help             - Show this help message"
	@echo "  publish          - Export and upload public key to keys.openpgp.org"
	@echo "  pubkey           - Export public key to pubkey.gpg file"
	@echo "  privkey          - Export private key to privkey.gpg file"
	@echo "  backup           - Create paperkey text backup from private key"
	@echo "  restore          - Restore private key from paperkey backup to privkey-restored.gpg"

	@echo ""
	@echo "Example: make publish GPG_ID=3C2DE0F1FB93D0EE"

# Environment variable validation
env-GPG_ID:
	@if [ -z '${GPG_ID}' ]; then echo 'ERROR: variable GPG_ID not set. Usage: make <target> GPG_ID=<your-gpg-key-id>' && exit 1; fi

publish: env-GPG_ID
	@gpg --export $(GPG_ID) | curl -T - https://keys.openpgp.org

pubkey: env-GPG_ID
	@gpg --export $(GPG_ID) > pubkey.gpg

privkey: env-GPG_ID
	@gpg --export-secret-key $(GPG_ID) > privkey.gpg

backup: privkey
	@paperkey --secret-key privkey.gpg --output paperkey.txt
	@rm privkey.gpg

restore:
	@paperkey --pubring pubkey.gpg --secrets paperkey.txt --output privkey-restored.gpg
