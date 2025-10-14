
####  A  FRESH STATE BACKEND CLONEABLE #############

# clone the state created in backend initially from the first step prefix "initial/state"
# change prefix to "02-backend-clone/state" 
    terraform init -migrate-state

# use this state {"02-backend-clone/state" } by cloning  
# to create a fresh cluster like dev , staging and production environment