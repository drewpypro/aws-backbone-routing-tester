import subprocess
import csv

# List of regions to query
regions = ["us-east-1", "us-east-2", "us-west-1", "us-west-2", "eu-west-1", "il-central-1"]

# Output CSV file
output_file = "ami_lookup.csv"

# Function to run AWS CLI command
def get_ami_info(region):
    try:
        result = subprocess.run(
            [
                "aws",
                "ec2",
                "describe-images",
                "--owners",
                "137112412989",  # Amazon official account ID
                "--filters",
                f"Name=name,Values=al2023*minimal*x86_64*",
                "--query",
                "Images[0].[ImageId,Name]",
                "--output",
                "text",
                "--region",
                region,
            ],
            capture_output=True,
            text=True,
            check=True,
        )
        return result.stdout.strip().split("\t") + [region]
    except subprocess.CalledProcessError as e:
        print(f"Error fetching AMI info for region {region}: {e.stderr}")
        return [None, None, region]

# Collect AMI data
ami_data = []
for region in regions:
    print(f"Fetching AMI info for region: {region}")
    ami_info = get_ami_info(region)
    ami_data.append(ami_info)

# Write to CSV
with open(output_file, mode="w", newline="") as file:
    writer = csv.writer(file)
    writer.writerow(["AMI ID", "AMI Name", "Region"])
    writer.writerows(ami_data)

print(f"AMI data exported to {output_file}")
