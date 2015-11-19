install:
	@terraform get -update

plan: install
	@terraform plan \
		-var "access_key=`cat ~/.aws/credentials | grep aws_access | cut -d "=" -f2 | tr -d ' '`" \
		-var "secret_key=`cat ~/.aws/credentials | grep aws_secret | cut -d "=" -f2 | tr -d ' '`" \
		-module-depth=-1 \
		-out "demo.tfplan"

refresh: install
	@terraform refresh \
		-var "access_key=`cat ~/.aws/credentials | grep aws_access | cut -d "=" -f2 | tr -d ' '`" \
		-var "secret_key=`cat ~/.aws/credentials | grep aws_secret | cut -d "=" -f2 | tr -d ' '`" \
		-state-out "terraform.tfstate"

apply: install
	@terraform apply demo.tfplan

plan_destroy: install
	@terraform plan \
		-var "access_key=`cat ~/.aws/credentials | grep aws_access | cut -d "=" -f2 | tr -d ' '`" \
		-var "secret_key=`cat ~/.aws/credentials | grep aws_secret | cut -d "=" -f2 | tr -d ' '`" \
		-module-depth=-1 \
		-destroy \
		-out "demo.tfplan"

clean:
	rm demo.tfplan demo.tfplan.backup terraform.tfstate terraform.tfstate.backup

.PHONY: install plan apply plan_destroy
