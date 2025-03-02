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

Download and install the Cloud SQL Proxy:

curl -o cloud-sql-proxy https://storage.googleapis.com/cloud-sql-connectors/cloud-sql-proxy/v2.15.1/cloud-sql-proxy.linux.amd64

Make the Cloud SQL Auth Proxy executable:
chmod +x cloud-sql-proxy

7. 
