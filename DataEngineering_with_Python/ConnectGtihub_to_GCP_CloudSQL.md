1. To cennect github with VM instance on gcp to be able to access it through gcp tools such as Cloud SQL:

2. for your VM instance, open cloud shell (SSH) and install github by running the following commands:

   sudo apt update
sudo apt install git

3. Clone the GitHub repository to the machine/container:

git clone https://github.com/LinkedInLearning/fundamentals-of-data-transformation-4554074.git

![image](https://github.com/user-attachments/assets/72918f37-af22-445b-a727-ebad402857ea)

![image](https://github.com/user-attachments/assets/71ef0dac-70ed-4e30-b818-71b331dc768f)

4. Navigate to cloned repository

 cd fundamentals-of-data-transformation-4554074

5.  Install the Google Cloud SDK (if it's not already installed) -- OPTIONAL 
If you haven't installed the Google Cloud SDK on your VM, you can do so with the following commands (skip this step if the SDK is already installed on your VM):

bash
Copy
# Update package list and install required packages
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates gnupg

# Download and install the Cloud SDK
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get update && sudo apt-get install google-cloud-sdk

6. Install Cloud SQL Proxy:
The Cloud SQL Proxy itself establishes the connection to your Cloud SQL instance, and you can run queries directly from your application or other environments without needing MySql or PostgreSQL clients.
Download and install the Cloud SQL Proxy:

curl -o cloud-sql-proxy https://storage.googleapis.com/cloud-sql-connectors/cloud-sql-proxy/v2.15.1/cloud-sql-proxy.linux.amd64

Make the Cloud SQL Auth Proxy executable:
chmod +x cloud-sql-proxy

If you're only going to use the Cloud SQL Proxy to allow your application to interact with Cloud SQL (e.g., using Python's psycopg2 for PostgreSQL or mysql-connector for MySQL), then SQL clients are not necessary.
If you want to run SQL queries manually from the terminal, you will need to install the relevant SQL client (postgresql-client or mysql-client).

7. Set your Google Cloud project:
gcloud config set project dataprocapachehive

8.Start the Cloud SQL Proxy:

To start the Cloud SQL Proxy, run the following command, replacing the placeholders with your project and instance details:
./cloud_sql_proxy -dir=/cloudsql -project=dataprocapachehive -instances=dataprocapachehive:us-central1-c:5720235591945055457
* if it doesn't run, run the following :
           Step 1: Ensure the Binary is Executable
         It seems like the permissions might not be correctly set, so let's try setting the permissions again.
         Run this command to ensure the file is executable:
         chmod +x cloud_sql_proxy
         Step 2: Check Ownership and Permissions
         You can also check the ownership and permissions of the file using ls -l to ensure it’s owned by the correct user and is executable.
         ls -l cloud_sql_proxy
         You should see output like:
         -rwxr-xr-x 1 youruser youruser 32126080 Mar 2 21:54 cloud_sql_proxy
         Ensure the file has execute permissions (x) for the user (or all users). If it doesn't, use the following command to correct the permissions:
         sudo chmod u+x cloud_sql_proxy
         Step 3: Try Running the Command Again

![image](https://github.com/user-attachments/assets/4a08ef4d-7c1c-494c-b23d-089bf7e92fe7)

Ensure the Cloud SQL Proxy is Running
Before connecting to Cloud SQL, the Cloud SQL Proxy must be running. You should already have it running with a command like this:

./cloud_sql_proxy -dir=/cloudsql -project=dataprocapachehive -instances=dataprocapachehive:us-central1-c:5720235591945055457
When the proxy is running successfully, you’ll see output like this, which indicates the proxy is connected:

2025/03/02 22:01:33 Connected to [YOUR_PROJECT_ID:YOUR_REGION:YOUR_INSTANCE_ID]
