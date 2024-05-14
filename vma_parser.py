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
    for line in file:
        start_match = re.search(start_pattern, line)
        file_fault_match = re.search(file_fault_pattern, line)
        file_match = re.search(file_pattern, line)

#If a match is found, extract the start address
        if start_match and file_match and file_fault_match:
            start_address = start_match.group(1)[2:]
            start_address = int(start_address, 16)
            file_fault = file_fault_match.group(1)
            if file_fault == "1":
                start_addresses_file.add(start_address)
                file_pages_fault += 1
            else:
                start_addresses_anon.add(start_address)
                anon_page_fault += 1
                print(file_match)

            if start_address == prev_start_address:
                if file_fault == "1":
                    prev_start_address_count_file += 1
                else:
                    prev_start_address_count_anon += 1
            else:
                prev_start_address = start_address

start_addresses_regex_in_smap = r'^([0-9a-fA-F]+)-'

def extract_swap_value(string_block):
    swap_value = None
    for line in string_block.split('\n'):
        if line.startswith('Swap:'):
            swap_value = int(line.split()[1])
            break
    return swap_value

def extract_rss_value(string_block):
    rss_value = None
    for line in string_block.split('\n'):
        if line.startswith('Rss:'):
            rss_value = int(line.split()[1])
            break
    return rss_value

def create_string_block_with_swap(filename):
    string_blocks_with_swap = []
    block = ""
    with open(filename, 'r') as file:
        for line in file:
            if line.strip():  # Check if the line is not empty
                block += line
                if line.startswith('VmFlags:'):  # Check if it's the last line of the block
                    swap_value = extract_swap_value(block)
                    start_address_match = re.match(start_addresses_regex_in_smap, block)
                    start_address_str = start_address_match.group(1)[2:]

                    if swap_value != 0 and extract_rss_value(block) != 0:
                        if int(start_address_str, 16) in start_addresses_anon:
                            string_blocks_with_swap.append((block.strip(), swap_value))
                    block = ""
    return string_blocks_with_swap



filename = sys.argv[2]
total_swap = 0
try:
    result = create_string_block_with_swap(filename)
    for idx, (block, swap_value) in enumerate(result, start=1):
        #print(f"{block}")
        print(f"Swap Value: {swap_value} kB")
        total_swap += int(swap_value)
        pass
except FileNotFoundError:
    print("File not found:", filename)
except Exception as e:
    print("An error occurred:", e)

print("File page: " + str(file_pages_fault) + " File fault vma amount: " + str(len(start_addresses_file)) + " The fault continuos from the previous vma: " + str(prev_start_address_count_file))
print("Anon page: " + str(anon_page_fault)+ " Anon fault vma amount: " + str(len(start_addresses_anon)) + " The fault continuos from the previous vma: " + str(prev_start_address_count_anon))
print(total_swap)