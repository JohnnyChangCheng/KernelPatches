import re 
import sys

#Regular expression pattern to match the "Start:" value
start_pattern = r'Start: (0x[0-9a-fA-F]+)' 
file_pattern = r'VMA: (.+)' 
file_fault_pattern = r'File Fault: (\d+)'

#Ensure a filename is provided as a command - line argument
if len (sys.argv)< 2:
    print("Usage: python script.py <filename>")
    sys.exit(1)

#Get the filename from command - line arguments
filename = sys.argv[1]

#Create a set to store unique start addresses
start_addresses_anon = set()
start_addresses_file = set()

file_pages_fault = 0
anon_page_fault = 0

prev_start_address = None
prev_start_address_count_file = 0
prev_start_address_count_anon = 0

#Open the file
with open(filename, 'r') as file:
#Iterate through each line
    for line in file:
#Search for the pattern in the line
        start_match = re.search(start_pattern, line)
        file_fault_match = re.search(file_fault_pattern, line)
        file_match = re.search(file_pattern, line)

#If a match is found, extract the start address
        if start_match and file_match and file_fault_match:
            start_address = start_match.group(1)
            file_fault = file_fault_match.group(1)
            if file_fault == "1":
                start_addresses_file.add(start_address)
                file_pages_fault += 1
            else:
                start_addresses_anon.add(start_address)
                anon_page_fault += 1
                print(file_match.group(1))
#Check if the current start address is the same as the previous one
            if start_address == prev_start_address:
#If yes, increment the count
                if file_fault == "1":
                    prev_start_address_count_file += 1
                else:
                    prev_start_address_count_anon += 1
            else:
                prev_start_address = start_address

print("File page: " + str(file_pages_fault) + " File fault vma amount: " + str(len(start_addresses_file)) + " The fault continuos from the previous vma: " + str(prev_start_address_count_file))
print("Anon page: " + str(anon_page_fault)+ " Anon fault vma amount: " + str(len(start_addresses_anon)) + " The fault continuos from the previous vma: " + str(prev_start_address_count_anon))
