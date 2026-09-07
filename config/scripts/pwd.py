#!/usr/bin/env python3
import random
import string


def generate_password(length=18):
    # Allowed special characters (only these work)
    specials = "!@#"

    # Character pools
    uppercase = string.ascii_uppercase
    lowercase = string.ascii_lowercase
    digits = string.digits

    # Ensure at least one from each category
    password = [
        random.choice(uppercase),
        random.choice(lowercase),
        random.choice(digits),
        random.choice(specials),
    ]

    # Fill remaining positions with any allowed characters
    all_allowed = uppercase + lowercase + digits + specials
    for _ in range(length - 4):
        password.append(random.choice(all_allowed))

    # Shuffle to avoid predictable pattern
    random.shuffle(password)

    return "".join(password)


# Generate 10 examples
for i in range(10):
    print(f"{i + 1}: {generate_password(18)}")
