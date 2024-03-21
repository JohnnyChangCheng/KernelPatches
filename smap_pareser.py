import sys

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
                    if swap_value != 0 and extract_rss_value(block) != 0:
                        string_blocks_with_swap.append((block.strip(), swap_value))
                    block = ""
    return string_blocks_with_swap

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python script.py <filename>")
        sys.exit(1)

    filename = sys.argv[1]
    
    try:
        result = create_string_block_with_swap(filename)
        for idx, (block, swap_value) in enumerate(result, start=1):
            print(f"Block {idx}:")
            print(block)
            print(f"Swap Value: {swap_value} kB")
            print()
    except FileNotFoundError:
        print("File not found:", filename)
    except Exception as e:
        print("An error occurred:", e)
