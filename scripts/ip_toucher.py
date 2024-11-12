import os
import subprocess
import csv
from datetime import datetime

# List of IP addresses to test
ip_addresses = [ip_list]
region = regionvar

# Output CSV file
output_file = f"${region}-network_traffic_report.csv"

# Create CSV headers
headers = ["Region", "IP Address", "Protocol", "Command", "Result"]

def run_command(command):
    """Run a shell command and return the output or error."""
    print(f"Executing: {command}")
    try:
        result = subprocess.run(command, shell=True, text=True, capture_output=True)
        if result.returncode == 0:
            print(f"Success: {command}\nOutput:\n{result.stdout.strip()}\n")
            return f"Success\nOutput:\n{result.stdout.strip()}"
        else:
            print(f"Error: {command}\nError Message:\n{result.stderr.strip()}\n")
            return f"Error\nMessage:\n{result.stderr.strip()}"
    except subprocess.TimeoutExpired:
        print(f"Timeout: {command}\n")
        return "Timeout\nCommand took too long to complete"
    except Exception as e:
        print(f"Exception while running command: {command}\n{str(e)}\n")
        return f"Exception\n{str(e)}"

def generate_report(ip_list):
    """Generate network traffic and write results to a CSV."""
    with open(output_file, mode="w", newline="") as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow([f"Region: {region}"])
        writer.writerow([f"Test Start Time: {datetime.now()}"])
        writer.writerow([])
        writer.writerow(headers)

        for ip in ip_list:
            print(f"Starting tests for IP: {ip}\n{'='*40}")

            # TCP Test using Netcat
            tcp_command = f"echo 'Test TCP' | nc -v -w 5 {ip} 6969"
            tcp_result = run_command(tcp_command)
            writer.writerow([ip, "TCP", tcp_command, tcp_result])

            # UDP Test using Netcat
            udp_command = f"echo 'Test UDP' | nc -u -v -w 5 {ip} 6969"
            udp_result = run_command(udp_command)
            writer.writerow([ip, "UDP", udp_command, udp_result])

            # Ping Test
            ping_command = f"ping -c 4 {ip}"
            ping_result = run_command(ping_command)
            writer.writerow([ip, "ICMP", ping_command, ping_result])

            # Traceroute Test
            traceroute_command = f"traceroute {ip}"
            traceroute_result = run_command(traceroute_command)
            writer.writerow([ip, "Traceroute", traceroute_command, traceroute_result])

            print(f"Completed tests for IP: {ip}\n{'='*40}\n")

    print(f"Network traffic report saved to {output_file}")

# Run the script
if __name__ == "__main__":
    print(f"Starting network tests at {datetime.now()}...\n")
    generate_report(ip_addresses)
    print(f"All tests completed at {datetime.now()}.")
