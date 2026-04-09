def convert_minutes(minutes):
    hrs = minutes // 60
    mins = minutes % 60
    
    if hrs == 0:
        return f"{mins} minutes"
    elif hrs == 1:
        return f"1 hr {mins} minutes"
    else:
        return f"{hrs} hrs {mins} minutes"



minutes=int(input())
print(convert_minutes(minutes)) 
