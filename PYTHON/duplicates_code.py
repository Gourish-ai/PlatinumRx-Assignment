def unique_string(s):
    result = ""
    
    for char in s:
        if char not in result:
            result += char
            
    return result

s=input()
print(unique_string(s)) 
