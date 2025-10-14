
Only create the project with associated bucket and vpc. No cluster in this step. 
Just create locally and change the backend. DO NOT change the initial state!!!!!!
use this state by cloning in next step 02-backend-clone and reuse on other modules like creating cluster modules

# First Step:(Create project minimum reqs.)
    Declare variables value in terraform.tfvars. Caution: gcp_billing_id
    * Mark as comment terraform > backend "gcs" part in main.tf
    * generate local state:
        terraform init
        terraform plan
        terraform apply

# Second Step:(keep the backend state in remote bucket)
    * Uncomment terraform > backend "gcs" part  in main.tf
    * provide "bucket" name generated in Second step and "prefix" as location of terraform.tfstate
    * generate remote state:
        terraform init -migrate-state
        terraform plan
        terraform apply

# with web-module here project will be created  including bucket, vpc 


# NOTE: Once backend is created. DO NOT USE for further operations even for a single time, just clone it in next module in "01-create-project-test" and use that state in rest of the other modules
