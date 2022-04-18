def is_vowel(l):
    return l.upper() in ('AEIOU')

def calculate_tip(tip_percent, total_bill):
    return total_bill * tip_percent

def get_letter_grade(grade):
    if grade >= 88:
        return('A')
    elif grade >= 80:
        return('B')
    elif grade >= 67:
        return('C')
    elif grade >= 60:
        return('D')
    else:
        return('F')
    
    