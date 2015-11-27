# Creds are read from file generated using aws CLI ("aws configure").
access_key = `cat ~/.aws/credentials | grep aws_access | cut -d "=" -f2 | tr -d ' '`
secret_key = `cat ~/.aws/credentials | grep aws_secret | cut -d "=" -f2 | tr -d ' '`

install:
	@terraform get -update

plan: install
	@terraform plan \
		-var "access_key=$(access_key)" \
		-var "secret_key=$(secret_key)" \
		-module-depth=-1 \
		-out "demo.tfplan"

refresh: install
	@terraform refresh \
		-var "access_key=$(access_key)" \
		-var "secret_key=$(secret_key)" \
		-state-out "terraform.tfstate"

apply: install
	@terraform apply demo.tfplan

plan_destroy: install
	@terraform plan \
		-var "access_key=$(access_key)" \
		-var "secret_key=$(secret_key)" \
		-module-depth=-1 \
		-destroy \
		-out "demo.tfplan"

clean:
	rm demo.tfplan demo.tfplan.backup terraform.tfstate terraform.tfstate.backup

.PHONY: install plan apply plan_destroy
